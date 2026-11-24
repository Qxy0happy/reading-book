import 'package:material_ui/material_ui.dart';

import '../bootstrap.dart';
import '../domain/models.dart';
import 'reader_controller.dart';
import 'widgets/passage_reader.dart';
import '../settings/settings_screen.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({
    super.key,
    required this.dependencies,
    required this.passageKey,
  });

  final AppDependencies dependencies;
  final String passageKey;

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  late final ReaderController _controller;
  late final Listenable _listenable;

  @override
  void initState() {
    super.initState();
    _controller = ReaderController(
      contentRepository: widget.dependencies.contentRepository,
      progressRepository: widget.dependencies.progressRepository,
      settingsController: widget.dependencies.settingsController,
      passageKey: widget.passageKey,
    );
    _listenable = Listenable.merge([
      _controller,
      widget.dependencies.settingsController,
    ]);
    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _listenable,
      builder: (context, _) {
        final settings = widget.dependencies.settingsController.settings;
        final content = _controller.content;
        final allExpanded =
            content != null &&
            content.paragraphs.isNotEmpty &&
            content.paragraphs.every(
              (paragraph) =>
                  _controller.expandedParagraphKeys.contains(paragraph.key),
            );
        return Scaffold(
          appBar: AppBar(
            title: Text(
              content?.passage.displayTitle ?? '阅读',
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              if (content != null)
                IconButton(
                  tooltip: _controller.isCurrentBookmarked ? '取消书签' : '添加书签',
                  icon: Icon(
                    _controller.isCurrentBookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                  ),
                  onPressed: _controller.toggleBookmark,
                ),
              if (content != null)
                TextButton(
                  onPressed: allExpanded
                      ? _controller.hideAllTranslations
                      : _controller.showAllTranslations,
                  child: Text(allExpanded ? '隐藏译文' : '显示译文'),
                ),
              IconButton(
                tooltip: '设置',
                icon: const Icon(Icons.tune),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SettingsScreen(
                      controller: widget.dependencies.settingsController,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: _buildBody(settings),
        );
      },
    );
  }

  Widget _buildBody(ReaderSettings settings) {
    if (_controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_controller.error != null) {
      return _ReaderError(error: _controller.error!, onRetry: _controller.load);
    }
    final content = _controller.content;
    if (content == null) {
      return const Center(child: Text('没有可阅读的内容'));
    }
    return NotificationListener<ScrollEndNotification>(
      onNotification: (_) {
        _controller.updateCurrentParagraphFromKeys();
        return false;
      },
      child: PassageReader(controller: _controller, settings: settings),
    );
  }
}

class _ReaderError extends StatelessWidget {
  const _ReaderError({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.menu_book_outlined,
              size: 40,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 12),
            Text('无法打开篇目', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              '$error',
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
