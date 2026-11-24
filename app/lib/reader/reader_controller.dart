import 'dart:async';

import 'package:flutter/widgets.dart';

import '../domain/models.dart';
import '../domain/repositories.dart';
import '../settings/settings_controller.dart';

class ReaderController extends ChangeNotifier {
  ReaderController({
    required this.contentRepository,
    required this.progressRepository,
    required this.settingsController,
    required this.passageKey,
  });

  final ContentRepository contentRepository;
  final ProgressRepository progressRepository;
  final SettingsController settingsController;
  final String passageKey;

  final Set<String> expandedParagraphKeys = {};
  final Map<String, GlobalKey> paragraphKeys = {};
  final ScrollController scrollController = ScrollController();

  PassageContent? content;
  bool isLoading = true;
  Object? error;
  String? currentParagraphKey;
  Set<String> bookmarkedParagraphKeys = {};

  StreamSubscription<List<Bookmark>>? _bookmarksSubscription;
  Timer? _progressTimer;
  bool _disposed = false;

  bool get isCurrentBookmarked =>
      currentParagraphKey != null &&
      bookmarkedParagraphKeys.contains(currentParagraphKey);

  Future<void> load() async {
    isLoading = true;
    error = null;
    _notify();
    try {
      final loaded = await contentRepository.loadPassage(passageKey);
      final bookmarks = await progressRepository.watchBookmarks().first;
      final progress = await progressRepository.watchProgress(passageKey).first;
      content = loaded;
      bookmarkedParagraphKeys = bookmarks
          .map((bookmark) => bookmark.paragraphKey)
          .toSet();
      currentParagraphKey =
          progress?.lastParagraphKey ??
          (loaded.paragraphs.isEmpty ? null : loaded.paragraphs.first.key);
      for (final paragraph in loaded.paragraphs) {
        paragraphKeys.putIfAbsent(paragraph.key, () => GlobalKey());
      }
      if (settingsController.settings.showTranslations) {
        expandedParagraphKeys.addAll(
          loaded.paragraphs.map((paragraph) => paragraph.key),
        );
      }
      await _bookmarksSubscription?.cancel();
      _bookmarksSubscription = progressRepository.watchBookmarks().listen((
        value,
      ) {
        bookmarkedParagraphKeys = value
            .map((bookmark) => bookmark.paragraphKey)
            .toSet();
        _notify();
      });
      isLoading = false;
    } catch (caught) {
      error = caught;
      isLoading = false;
    }
    _notify();
  }

  void toggleParagraph(String paragraphKey) {
    if (expandedParagraphKeys.contains(paragraphKey)) {
      expandedParagraphKeys.remove(paragraphKey);
    } else {
      expandedParagraphKeys.add(paragraphKey);
    }
    currentParagraphKey = paragraphKey;
    _scheduleProgressSave();
    _notify();
  }

  void showAllTranslations() {
    final content = this.content;
    if (content == null) return;
    expandedParagraphKeys
      ..clear()
      ..addAll(content.paragraphs.map((paragraph) => paragraph.key));
    _notify();
  }

  void hideAllTranslations() {
    expandedParagraphKeys.clear();
    _notify();
  }

  Future<void> toggleBookmark() async {
    final paragraphKey = currentParagraphKey;
    if (paragraphKey == null) return;
    if (bookmarkedParagraphKeys.contains(paragraphKey)) {
      await progressRepository.removeBookmark(paragraphKey);
    } else {
      await progressRepository.addBookmark(passageKey, paragraphKey);
    }
  }

  void updateCurrentParagraphFromKeys() {
    final content = this.content;
    if (content == null) return;
    for (final paragraph in content.paragraphs) {
      final context = paragraphKeys[paragraph.key]?.currentContext;
      final box = context?.findRenderObject();
      if (box is! RenderBox || !box.attached) continue;
      final top = box.localToGlobal(Offset.zero).dy;
      if (top + box.size.height > 96) {
        if (currentParagraphKey != paragraph.key) {
          currentParagraphKey = paragraph.key;
          _scheduleProgressSave();
          _notify();
        }
        return;
      }
    }
  }

  void _scheduleProgressSave() {
    _progressTimer?.cancel();
    _progressTimer = Timer(const Duration(milliseconds: 500), _saveProgress);
  }

  Future<void> _saveProgress() async {
    final content = this.content;
    final paragraphKey = currentParagraphKey;
    if (content == null || paragraphKey == null) return;
    try {
      final existing = await progressRepository.watchProgress(passageKey).first;
      final isLast =
          content.paragraphs.isNotEmpty &&
          paragraphKey == content.paragraphs.last.key;
      await progressRepository.saveProgress(
        ReadingProgress(
          passageKey: passageKey,
          lastParagraphKey: paragraphKey,
          lastSentenceKey: existing?.lastSentenceKey,
          isRead: (existing?.isRead ?? false) || isLast,
          updatedAt: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    } catch (_) {
      // Progress is best-effort; reading must not fail because of a write.
    }
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _progressTimer?.cancel();
    unawaited(_saveProgress());
    _bookmarksSubscription?.cancel();
    scrollController.dispose();
    super.dispose();
  }
}
