import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import 'data/content/content_database.dart';
import 'data/content/content_repository_impl.dart';
import 'data/progress/progress_database.dart';
import 'data/progress/progress_repository_impl.dart';
import 'domain/repositories.dart';
import 'settings/settings_controller.dart';
import 'shared/errors.dart';

const _contentAsset = 'assets/content.sqlite';
const _contentSchemaVersion = 1;

class AppDependencies {
  const AppDependencies({
    required this.contentRepository,
    required this.progressRepository,
    required this.settingsController,
    required this.contentVersion,
    required this.dispose,
    this.notice,
  });

  final ContentRepository contentRepository;
  final ProgressRepository progressRepository;
  final SettingsController settingsController;
  final String contentVersion;
  final String? notice;
  final Future<void> Function() dispose;
}

Future<AppDependencies> bootstrap({
  Directory? supportDirectory,
  AssetBundle? assetBundle,
}) async {
  final support = supportDirectory ?? await getApplicationSupportDirectory();
  await support.create(recursive: true);

  final contentFile = File('${support.path}/content.sqlite');
  final expectedVersion = await _prepareContent(contentFile, assetBundle ?? rootBundle);
  _validateContent(contentFile, expectedVersion: expectedVersion);

  final contentDb = ContentDatabase(
    NativeDatabase.createInBackground(
      contentFile,
      setup: (db) => db.execute('PRAGMA query_only = ON'),
    ),
  );

  final progressFile = File('${support.path}/progress.sqlite');
  ProgressDatabase? progressDb;
  String? notice;
  try {
    progressDb = ProgressDatabase(
      NativeDatabase.createInBackground(progressFile),
    );
    await progressDb.customSelect('SELECT 1').get();
  } catch (error) {
    await progressDb?.close();
    final backup = await _backupProgress(progressFile);
    progressDb = ProgressDatabase(
      NativeDatabase.createInBackground(progressFile),
    );
    try {
      await progressDb.customSelect('SELECT 1').get();
    } catch (retryError) {
      throw BootstrapException(
        '无法创建进度库',
        details: '重建后仍然失败：$retryError',
        cause: error,
      );
    }
    notice = '进度已重置，旧数据已备份到 ${backup.path}';
  }

  final progressRepo = DriftProgressRepository(progressDb);
  await progressRepo.ensureDefaults();
  final settingsController = SettingsController(progressRepo);
  await settingsController.load();
  final contentRepo = DriftContentRepository(contentDb);
  final contentVersion = await contentRepo.readContentVersion();

  return AppDependencies(
    contentRepository: contentRepo,
    progressRepository: progressRepo,
    settingsController: settingsController,
    contentVersion: contentVersion,
    notice: notice,
    dispose: () async {
      settingsController.dispose();
      await progressRepo.close();
      await contentRepo.close();
    },
  );
}

Future<String> _prepareContent(File target, AssetBundle bundle) async {
  final data = await bundle.load(_contentAsset);
  final temp = File('${target.path}.tmp');
  await temp.writeAsBytes(
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
    flush: true,
  );

  final String assetVersion;
  try {
    assetVersion = _readContentVersion(temp);
  } catch (error) {
    await temp.delete();
    throw BootstrapException(
      '内置内容库无法读取',
      details: 'assets/content.sqlite 缺少有效的 meta.content_version',
      cause: error,
    );
  }

  String? targetVersion;
  if (target.existsSync()) {
    try {
      targetVersion = _readContentVersion(target);
    } catch (_) {
      targetVersion = null;
    }
  }

  if (targetVersion == assetVersion) {
    await temp.delete();
    return assetVersion;
  }

  try {
    await temp.rename(target.path);
  } on FileSystemException {
    if (target.existsSync()) {
      await target.delete();
    }
    await temp.rename(target.path);
  }
  return assetVersion;
}

String _readContentVersion(File file) {
  final db = sqlite3.open(file.path, mode: OpenMode.readOnly);
  try {
    final rows = db.select('SELECT value FROM meta WHERE key = ?', [
      'content_version',
    ]);
    if (rows.isEmpty) {
      throw StateError('meta.content_version is missing');
    }
    return rows.first['value'] as String;
  } finally {
    db.close();
  }
}

void _validateContent(File file, {required String expectedVersion}) {
  final db = sqlite3.open(file.path, mode: OpenMode.readOnly);
  try {
    final userVersion =
        db.select('PRAGMA user_version').first.values.first as int;
    if (userVersion != _contentSchemaVersion) {
      throw BootstrapException(
        '内容库版本不兼容',
        details: '期望 schema v$_contentSchemaVersion，实际为 v$userVersion',
      );
    }
    final rows = db.select('SELECT value FROM meta WHERE key = ?', [
      'schema_version',
    ]);
    if (rows.isEmpty || rows.first['value'] != '$_contentSchemaVersion') {
      throw BootstrapException(
        '内容库 schema 标记不匹配',
        details: 'meta.schema_version 不是 $_contentSchemaVersion',
      );
    }
    final actualVersion = _readContentVersion(file);
    if (actualVersion != expectedVersion) {
      throw BootstrapException(
        '内容库版本标记不一致',
        details: '期望 $expectedVersion，实际为 $actualVersion',
      );
    }
  } finally {
    db.close();
  }
}

Future<File> _backupProgress(File file) async {
  final stamp = DateTime.now().millisecondsSinceEpoch;
  final backup = File('${file.path}.bak-$stamp');
  if (file.existsSync()) {
    await file.rename(backup.path);
  }
  for (final suffix in const ['-wal', '-shm']) {
    final sidecar = File('${file.path}$suffix');
    if (sidecar.existsSync()) {
      await sidecar.rename('${backup.path}$suffix');
    }
  }
  return backup;
}
