import 'package:material_ui/material_ui.dart';

import '../../domain/models.dart';
import '../../shared/theme.dart';
import '../reader_controller.dart';

class PassageReader extends StatelessWidget {
  const PassageReader({
    super.key,
    required this.controller,
    required this.settings,
  });

  final ReaderController controller;
  final ReaderSettings settings;

  @override
  Widget build(BuildContext context) {
    final content = controller.content;
    if (content == null) {
      return const SizedBox.shrink();
    }
    final theme = Theme.of(context);
    return ListView(
      controller: controller.scrollController,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 48),
      children: [
        _PassageHeader(passage: content.passage, settings: settings),
        const SizedBox(height: 12),
        for (final paragraph in content.paragraphs)
          Padding(
            key: controller.paragraphKeys[paragraph.key],
            padding: const EdgeInsets.only(bottom: 8),
            child: ParagraphBlock(
              paragraph: paragraph,
              expanded: controller.expandedParagraphKeys.contains(
                paragraph.key,
              ),
              settings: settings,
              onTap: () => controller.toggleParagraph(paragraph.key),
            ),
          ),
        if (content.options.isNotEmpty) ...[
          const SizedBox(height: 12),
          Divider(color: theme.dividerColor),
          const SizedBox(height: 12),
          Text('选项', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          for (final option in content.options)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 28,
                    child: Text(
                      '${option.optionKey}.',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      option.textEn,
                      style: AppTheme.readerStyle(settings),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ],
    );
  }
}

class _PassageHeader extends StatelessWidget {
  const _PassageHeader({required this.passage, required this.settings});

  final Passage passage;
  final ReaderSettings settings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${passage.year} · ${passage.label}',
          style: theme.textTheme.labelMedium?.copyWith(
            letterSpacing: 0.8,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          passage.displayTitle,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${passage.wordCount} 词',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        if (passage.sourceNote != null && passage.sourceNote!.isNotEmpty)
          Theme(
            data: theme.copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: const EdgeInsets.only(bottom: 8),
              title: Text(
                '文章信息',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              children: [
                Text(
                  passage.sourceNote!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 16),
        Divider(color: theme.dividerColor),
      ],
    );
  }
}

class ParagraphBlock extends StatelessWidget {
  const ParagraphBlock({
    super.key,
    required this.paragraph,
    required this.expanded,
    required this.settings,
    required this.onTap,
  });

  final Paragraph paragraph;
  final bool expanded;
  final ReaderSettings settings;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translationColor = theme.colorScheme.onSurfaceVariant;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (paragraph.headingEn != null) ...[
              Text(
                paragraph.headingEn!,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
            ],
            if (paragraph.speaker != null || paragraph.label != null) ...[
              Text(
                [
                  paragraph.speaker,
                  paragraph.label,
                ].whereType<String>().join(' · '),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
            ],
            Text(paragraph.textEn, style: AppTheme.readerStyle(settings)),
            AnimatedSize(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              child: expanded
                  ? Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(color: theme.dividerColor),
                          const SizedBox(height: 12),
                          if (paragraph.hasTranslation)
                            Text(
                              paragraph.textZh!,
                              style: AppTheme.translationStyle(settings)
                                  .copyWith(color: translationColor),
                            )
                          else
                            Text(
                              '暂无译文',
                              style: AppTheme.translationStyle(settings)
                                  .copyWith(color: translationColor),
                            ),
                          if (paragraph.isMachine) ...[
                            const SizedBox(height: 6),
                            Text(
                              '机器译文',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
