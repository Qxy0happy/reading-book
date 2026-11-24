import 'package:material_ui/material_ui.dart';

import '../domain/models.dart';

class AppColors {
  static const paperBackground = Color(0xFFF6F0E4);
  static const paperSurface = Color(0xFFFBF7EF);
  static const paperInk = Color(0xFF2A2620);
  static const paperMuted = Color(0xFF7A7265);
  static const paperDivider = Color(0xFFD8CEBC);
  static const paperAccent = Color(0xFF6B4F35);

  static const darkBackground = Color(0xFF161412);
  static const darkSurface = Color(0xFF211E1A);
  static const darkInk = Color(0xFFE8E0D2);
  static const darkMuted = Color(0xFFA79C8B);
  static const darkDivider = Color(0xFF3C352D);
  static const darkAccent = Color(0xFFD2B48C);

  static const eyeBackground = Color(0xFFE8EFDF);
  static const eyeSurface = Color(0xFFF1F5E8);
  static const eyeInk = Color(0xFF2A3328);
  static const eyeMuted = Color(0xFF6B7864);
  static const eyeDivider = Color(0xFFC9D4BE);
  static const eyeAccent = Color(0xFF4E6648);
}

class AppTheme {
  static const _latinFamily = 'SourceSerif4';
  static const _cjkFamily = 'NotoSerifSC';

  static ThemeData build(ReaderTheme theme) {
    final (background, surface, ink, muted, divider, accent) = switch (theme) {
      ReaderTheme.paper => (
        AppColors.paperBackground,
        AppColors.paperSurface,
        AppColors.paperInk,
        AppColors.paperMuted,
        AppColors.paperDivider,
        AppColors.paperAccent,
      ),
      ReaderTheme.dark => (
        AppColors.darkBackground,
        AppColors.darkSurface,
        AppColors.darkInk,
        AppColors.darkMuted,
        AppColors.darkDivider,
        AppColors.darkAccent,
      ),
      ReaderTheme.eyeCare => (
        AppColors.eyeBackground,
        AppColors.eyeSurface,
        AppColors.eyeInk,
        AppColors.eyeMuted,
        AppColors.eyeDivider,
        AppColors.eyeAccent,
      ),
    };

    final baseText =
        ThemeData(
          brightness: theme == ReaderTheme.dark
              ? Brightness.dark
              : Brightness.light,
          useMaterial3: true,
        ).textTheme.apply(
          fontFamily: _latinFamily,
          fontFamilyFallback: const [_cjkFamily],
          bodyColor: ink,
          displayColor: ink,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: theme == ReaderTheme.dark
          ? Brightness.dark
          : Brightness.light,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accent,
        brightness: theme == ReaderTheme.dark
            ? Brightness.dark
            : Brightness.light,
        surface: surface,
        onSurface: ink,
      ),
      textTheme: baseText,
      dividerColor: divider,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: ink,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: baseText.titleLarge?.copyWith(color: ink),
      ),
      cardTheme: CardThemeData(
        color: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: divider),
        ),
      ),
      dividerTheme: DividerThemeData(color: divider, thickness: 1, space: 1),
      listTileTheme: ListTileThemeData(iconColor: muted, textColor: ink),
      iconTheme: IconThemeData(color: muted),
      sliderTheme: SliderThemeData(
        activeTrackColor: accent,
        thumbColor: accent,
        inactiveTrackColor: divider,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ink,
        contentTextStyle: baseText.bodyMedium?.copyWith(color: surface),
      ),
    );
  }

  static TextStyle readerStyle(ReaderSettings settings) => TextStyle(
    fontFamily: _latinFamily,
    fontFamilyFallback: const [_cjkFamily],
    fontSize: settings.fontSize,
    height: settings.lineHeight,
    letterSpacing: 0.1,
  );

  static TextStyle translationStyle(ReaderSettings settings) =>
      readerStyle(settings).copyWith(
        fontSize: settings.fontSize - 1,
        height: settings.lineHeight + 0.08,
        color: AppColors.paperMuted,
      );
}
