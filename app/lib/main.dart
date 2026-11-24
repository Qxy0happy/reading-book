import 'package:flutter/widgets.dart';
import 'package:material_ui/material_ui.dart';

import 'app.dart';
import 'bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final dependencies = await bootstrap();
    runApp(ReadingBookApp(dependencies: dependencies));
  } catch (error, stack) {
    debugPrint('Bootstrap failed: $error\n$stack');
    runApp(BootstrapErrorApp(error: error));
  }
}
