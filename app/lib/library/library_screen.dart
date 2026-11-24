import 'package:material_ui/material_ui.dart';

import '../bootstrap.dart';
import '../domain/models.dart';
import '../reader/reader_screen.dart';
import '../settings/settings_screen.dart';
import '../shared/errors.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key, required this.dependencies});

  final AppDependencies dependencies;

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  late Future<List<PassageSummary>> _passagesFuture;

  @override
  void initState() {
    super.initState();
    _passagesFuture = widget.dependencies.contentRepository.listPassages();
  }

  void _reload() {
    setState(() {
      _passagesFuture = widget.dependencies.contentRepository.listPassages();
    });
  }

  void _openPassage(String passageKey) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ReaderScreen(
          dependencies: widget.dependencies,
          passageKey: passageKey,
        ),
      ),
    );
  }

  void _openSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            SettingsScreen(controller: widget.dependencies.settingsController),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('阅读本'),
        actions: [
          IconButton(
            tooltip: '设置',
            icon: const Icon(Icons.tune),
            onPressed: _openSettings,
          ),
        ],
      ),
      body: FutureBuilder<List<PassageSummary>>(
        future: _passagesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return _LibraryError(error: snapshot.error!, onRetry: _reload);
          }
          final passages = snapshot.data ?? const <PassageSummary>[];
          if (passages.isEmpty) {
            return Center(
              child: Text('内容库没有可阅读篇目', style: theme.textTheme.bodyLarge),
            );
          }
          return StreamBuilder<List<ReadingProgress>>(
            stream: widget.dependencies.progressRepository.watchAllProgress(),
            initialData: const <ReadingProgress>[],
            builder: (context, progressSnapshot) {
              return StreamBuilder<List<Bookmark>>(
                stream: widget.dependencies.progressRepository.watchBookmarks(),
                initialData: const <Bookmark>[],
                builder: (context, bookmarkSnapshot) {
                  return _LibraryList(
                    passages: passages,
                    progress:
                        progressSnapshot.data ?? const <ReadingProgress>[],
                    bookmarks: bookmarkSnapshot.data ?? const <Bookmark>[],
                    notice: widget.dependencies.notice,
                    onOpen: _openPassage,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _LibraryList extends StatelessWidget {
  const _LibraryList({
    required this.passages,
    required this.progress,
    required this.bookmarks,
    required this.notice,
    required this.onOpen,
  });

  final List<PassageSummary> passages;
  final List<ReadingProgress> progress;
  final List<Bookmark> bookmarks;
  final String? notice;
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progressByKey = {for (final item in progress) item.passageKey: item};
    final bookmarkedPassages = bookmarks
        .map((bookmark) => bookmark.passageKey)
        .toSet();

    ReadingProgress? latest;
    for (final item in progress) {
      if (latest == null || item.updatedAt > latest.updatedAt) latest = item;
    }
    PassageSummary? resume;
    if (latest != null) {
      for (final passage in passages) {
        if (passage.key == latest.passageKey) {
          resume = passage;
          break;
        }
      }
    }

    final groups = <int, List<PassageSummary>>{};
    for (final passage in passages) {
      groups.putIfAbsent(passage.year, () => []).add(passage);
    }
    final years = groups.keys.toList()..sort((a, b) => b.compareTo(a));

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
      children: [
        if (notice != null) ...[
          Card(
            color: theme.colorScheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: theme.colorScheme.onSecondaryContainer,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      notice!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (resume != null) ...[
          Card(
            child: ListTile(
              leading: Icon(
                Icons.play_circle_outline,
                color: theme.colorScheme.primary,
              ),
              title: const Text('继续阅读'),
              subtitle: Text(resume.displayTitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => onOpen(resume!.key),
            ),
          ),
          const SizedBox(height: 16),
        ],
        for (final year in years) ...[
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 6),
            child: Text(
              '$year 年',
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                letterSpacing: 0.5,
              ),
            ),
          ),
          for (final passage in groups[year]!)
            Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Icon(
                  Icons.article_outlined,
                  color: theme.colorScheme.primary,
                ),
                title: Text(
                  '${passage.label} · ${passage.displayTitle}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  '${passage.wordCount} 词'
                  '${progressByKey[passage.key]?.isRead == true ? ' · 已读' : ''}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (bookmarkedPassages.contains(passage.key))
                      const Icon(Icons.bookmark, size: 18),
                    if (progressByKey[passage.key]?.isRead == true)
                      const Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Icon(Icons.check_circle_outline, size: 18),
                      ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
                onTap: () => onOpen(passage.key),
              ),
            ),
        ],
      ],
    );
  }
}

class _LibraryError extends StatelessWidget {
  const _LibraryError({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final details = error is BootstrapException
        ? (error as BootstrapException).details
        : null;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 40, color: theme.colorScheme.error),
            const SizedBox(height: 12),
            Text('无法读取内容库', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              details ?? '$error',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(onPressed: onRetry, child: const Text('重试')),
          ],
        ),
      ),
    );
  }
}
