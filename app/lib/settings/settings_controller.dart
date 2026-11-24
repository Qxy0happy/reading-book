import 'dart:async';

import 'package:flutter/foundation.dart';

import '../domain/models.dart';
import '../domain/repositories.dart';

class SettingsController extends ChangeNotifier {
  SettingsController(this._repository);

  final ProgressRepository _repository;
  StreamSubscription<ReaderSettings>? _subscription;
  ReaderSettings _settings = ReaderSettings.defaults;

  ReaderSettings get settings => _settings;

  Future<void> load() async {
    _settings = await _repository.watchSettings().first;
    _subscription = _repository.watchSettings().listen((value) {
      if (value == _settings) return;
      _settings = value;
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> update(ReaderSettings next) async {
    _settings = next;
    notifyListeners();
    await _repository.saveSettings(next);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
