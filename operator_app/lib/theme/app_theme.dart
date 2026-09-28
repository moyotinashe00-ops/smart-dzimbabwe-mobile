import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Smart Dzimbabwe brand palette — deep forest green, warm cream, gold accent.
/// Kept identical across the traveler and operator apps so the two feel
/// like one product even though they ship separately.
class AppColors {
  AppColors._();

  static const ink = Color(0xFF0E2A1E);       // primary dark green (panels, nav, heroes)
  static const inkDeep = Color(0xFF091A12);   // near-black green (deepest panels)
  static const inkPanel = Color(0xFF163A2A);  // slightly lighter green for cards on ink
  static const cream = Color(0xFFF3EDE0);     // app background
  static const card = Color(0xFFFBF8F1);      // light surface cards
  static const gold = Color(0xFFE3A73A);      // primary accent / CTA
  static const goldDeep = Color(0xFFC48A24);  // pressed / gradient end
  static const goldSoft = Color(0xFFF2D9A6);  // subtle gold fills
  static const textOnDark = Color(0xFFF6F2E7);
  static const textOnDarkMuted = Color(0xFFB7C4B9);
  static const textOnLight = Color(0xFF16221A);
  static const textOnLightMuted = Color(0xFF5C6960);
  static const line = Color(0xFFE0D6C2);
  static const lineOnDark = Color(0xFF2A4A38);
  static const success = Color(0xFF4C8C5B);
  static const danger = Color(0xFFC65A45);
}

/// Fraunces for display/headings (the elegant editorial serif used across
/// every screen in the reference), Manrope for body/UI text — deliberately
/// not Inter/Arial/Roboto/Space Grotesk.
class AppTheme {
  AppTheme._();

  static TextTheme _textTheme(Color base, Color muted) {
    return TextTheme(
      displayLarge: GoogleFonts.fraunces(
          fontSize: 34, fontWeight: FontWeight.w600, color: base, height: 1.12, letterSpacing: -0.4),
      displayMedium: GoogleFonts.fraunces(
          fontSize: 27, fontWeight: FontWeight.w600, color: base, height: 1.16, letterSpacing: -0.2),
      headlineMedium: GoogleFonts.fraunces(fontSize: 21, fontWeight: FontWeight.w600, color: base),
      headlineSmall: GoogleFonts.fraunces(fontSize: 18, fontWeight: FontWeight.w600, color: base),
      titleLarge: GoogleFonts.fraunces(fontSize: 17, fontWeight: FontWeight.w600, color: base),
      titleMedium: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w700, color: base),
      titleSmall: GoogleFonts.manrope(fontSize: 12.5, fontWeight: FontWeight.w700, color: muted, letterSpacing: 0.3),
      bodyLarge: GoogleFonts.manrope(fontSize: 15, fontWeight: FontWeight.w500, color: base, height: 1.45),
      bodyMedium: GoogleFonts.manrope(fontSize: 13.5, fontWeight: FontWeight.w500, color: muted, height: 1.4),
      bodySmall: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w500, color: muted),
      labelLarge: GoogleFonts.manrope(fontSize: 13.5, fontWeight: FontWeight.w700, letterSpacing: 0.2, color: base),
    );
  }

  static ThemeData get light {
    final base = ThemeData(useMaterial3: true, brightness: Brightness.light);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.cream,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.ink,
        secondary: AppColors.gold,
        surface: AppColors.card,
        error: AppColors.danger,
      ),
      textTheme: _textTheme(AppColors.textOnLight, AppColors.textOnLightMuted),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      dividerColor: AppColors.line,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.card,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.gold, width: 1.6),
        ),
        hintStyle: GoogleFonts.manrope(color: AppColors.textOnLightMuted, fontSize: 14),
        labelStyle: GoogleFonts.manrope(color: AppColors.textOnLightMuted, fontSize: 13),
      ),
    );
  }

  /// Text theme to use for content painted directly onto an ink-green panel.
  static TextTheme get onDarkTextTheme => _textTheme(AppColors.textOnDark, AppColors.textOnDarkMuted);
}
