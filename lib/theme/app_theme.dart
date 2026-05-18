import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Earthy & Natural color palette
  static const Color primary = Color(0xFF5D7A3E); // Millet Green
  static const Color primaryDark = Color(0xFF3E5429);
  static const Color secondary = Color(0xFFD4872A); // Harvest Gold
  static const Color accent = Color(0xFFE8C46A); // Grain Yellow
  static const Color background = Color(0xFFF9F5EE); // Parchment
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBg = Color(0xFFFDF8F0);
  static const Color textDark = Color(0xFF2C1F0E);
  static const Color textMedium = Color(0xFF5C4A2A);
  static const Color textLight = Color(0xFF8B7355);
  static const Color upColor = Color(0xFF2E7D32);
  static const Color downColor = Color(0xFFC62828);
  static const Color divider = Color(0xFFE8DCC8);

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.light,
          surface: surface,
          primary: primary,
          secondary: secondary,
        ),
        scaffoldBackgroundColor: background,
        textTheme: GoogleFonts.nunitoTextTheme().copyWith(
          displayLarge: GoogleFonts.playfairDisplay(
            color: textDark,
            fontWeight: FontWeight.w700,
          ),
          displayMedium: GoogleFonts.playfairDisplay(
            color: textDark,
            fontWeight: FontWeight.w600,
          ),
          headlineLarge: GoogleFonts.playfairDisplay(
            color: textDark,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
          headlineMedium: GoogleFonts.playfairDisplay(
            color: textDark,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          titleLarge: GoogleFonts.nunito(
            color: textDark,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
          titleMedium: GoogleFonts.nunito(
            color: textDark,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          bodyLarge: GoogleFonts.nunito(
            color: textMedium,
            fontSize: 15,
          ),
          bodyMedium: GoogleFonts.nunito(
            color: textMedium,
            fontSize: 14,
          ),
          labelLarge: GoogleFonts.nunito(
            color: surface,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        cardTheme: CardThemeData(
          color: cardBg,
          elevation: 2,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: GoogleFonts.nunito(
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: accent.withValues(alpha: 0.2),
          labelStyle: GoogleFonts.nunito(
            color: primaryDark,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: divider),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: divider),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primary, width: 2),
          ),
          hintStyle: GoogleFonts.nunito(color: textLight),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      );
}
