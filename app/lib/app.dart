import 'package:material_ui/material_ui.dart';

import 'bootstrap.dart';
import 'domain/models.dart';
import 'library/library_screen.dart';
import 'shared/errors.dart';
import 'shared/theme.dart';

class ReadingBookApp extends StatelessWidget {
  const ReadingBookApp({super.key, required this.dependencies});

  final AppDependencies dependencies;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: dependencies.settingsController,
      builder: (context, _) {
        final settings = dependencies.settingsController.settings;
        return MaterialApp(
          title: '阅读本',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.build(settings.theme),
          home: LibraryScreen(dependencies: dependencies),
        );
      },
    );
  }
}

class BootstrapErrorApp extends StatefulWidget {
  const BootstrapErrorApp({super.key, required this.error});

  final Object error;

  @override
  State<BootstrapErrorApp> createState() => _BootstrapErrorAppState();
}

class _BootstrapErrorAppState extends State<BootstrapErrorApp> {
  late Object _error = widget.error;
  bool _retrying = false;

  Future<void> _retry() async {
    setState(() => _retrying = true);
    try {
      final dependencies = await bootstrap();
      runApp(ReadingBookApp(dependencies: dependencies));
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error;
        _retrying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.build(ReaderTheme.paper);
    final exception = _error is BootstrapException
        ? _error as BootstrapException
        : null;
    return MaterialApp(
      title: '阅读本',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.menu_book_outlined,
                    size: 44,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text('无法启动阅读本', style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 12),
                  Text(
                    exception?.message ?? '初始化内容库或进度库时发生错误。',
                    style: theme.textTheme.bodyLarge,
                  ),
                  if (exception?.details != null) ...[
                    const SizedBox(height: 12),
                    SelectableText(
                      exception!.details!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _retrying ? null : _retry,
                    child: _retrying
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('重试'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
