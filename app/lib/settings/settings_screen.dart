import 'package:material_ui/material_ui.dart';

import '../domain/models.dart';
import '../settings/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.controller});

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final settings = controller.settings;
        final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(title: const Text('设置')),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
            children: [
              _SectionLabel('阅读排版'),
              const SizedBox(height: 8),
              Text(
                '字号 ${settings.fontSize.toStringAsFixed(0)}',
                style: theme.textTheme.bodyMedium,
              ),
              Slider(
                value: settings.fontSize.clamp(16, 24),
                min: 16,
                max: 24,
                divisions: 8,
                label: settings.fontSize.toStringAsFixed(0),
                onChanged: (value) =>
                    controller.update(settings.copyWith(fontSize: value)),
              ),
              const SizedBox(height: 8),
              Text(
                '行距 ${settings.lineHeight.toStringAsFixed(1)}',
                style: theme.textTheme.bodyMedium,
              ),
              Slider(
                value: settings.lineHeight.clamp(1.4, 2.0),
                min: 1.4,
                max: 2.0,
                divisions: 6,
                label: settings.lineHeight.toStringAsFixed(1),
                onChanged: (value) =>
                    controller.update(settings.copyWith(lineHeight: value)),
              ),
              const SizedBox(height: 24),
              _SectionLabel('主题'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final themeOption in ReaderTheme.values)
                    ChoiceChip(
                      label: Text(_themeLabel(themeOption)),
                      selected: settings.theme == themeOption,
                      onSelected: (_) => controller.update(
                        settings.copyWith(theme: themeOption),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              _SectionLabel('译文'),
              const SizedBox(height: 4),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('打开篇目时显示译文'),
                subtitle: const Text('仍可逐段点按收起'),
                value: settings.showTranslations,
                onChanged: (value) => controller.update(
                  settings.copyWith(showTranslations: value),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _themeLabel(ReaderTheme theme) => switch (theme) {
    ReaderTheme.paper => '纸色',
    ReaderTheme.dark => '暗色',
    ReaderTheme.eyeCare => '护眼',
  };
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.labelLarge?.copyWith(
        color: theme.colorScheme.primary,
        letterSpacing: 0.6,
      ),
    );
  }
}
