import 'package:flutter/material.dart';
import '../../core/models/settings.dart';

/// CerlitaTheme - Sistema de temas con 5 temas personalizados
/// Temas: claro, oscuro, cerdita, koalita, cerdita y koalita
class CerlitaTheme {
  // ========== Colores por tema ==========
  
  // Tema Claro
  static const Color lightPrimary = Color(0xFF075E54);
  static const Color lightPrimaryVariant = Color(0xFF054C44);
  static const Color lightBackground = Color(0xFFF0F2F5);
  static const Color lightSurface = Colors.white;
  static const Color lightError = Color(0xFFB00020);
  static const Color lightOnPrimary = Colors.white;
  static const Color lightOnBackground = Color(0xFF111B21);
  static const Color lightOnSurface = Color(0xFF111B21);
  static const Color lightBubbleOutgoing = Color(0xFFDCF8C6);
  static const Color lightBubbleIncoming = Colors.white;

  // Tema Oscuro (WhatsApp Dark)
  static const Color darkPrimary = Color(0xFF00A884);
  static const Color darkPrimaryVariant = Color(0xFF008A6D);
  static const Color darkBackground = Color(0xFF111B21);
  static const Color darkSurface = Color(0xFF202C33);
  static const Color darkError = Color(0xFFCF6679);
  static const Color darkOnPrimary = Colors.black;
  static const Color darkOnBackground = Color(0xFFE9EDEF);
  static const Color darkOnSurface = Color(0xFFE9EDEF);
  static const Color darkBubbleOutgoing = Color(0xFF005C4B);
  static const Color darkBubbleIncoming = Color(0xFF202C33);

  // Tema Cerdita (Rosa pastel)
  static const Color cerditaPrimary = Color(0xFFFF69B4); // Hot pink
  static const Color cerditaPrimaryVariant = Color(0xFFDB4D96);
  static const Color cerditaBackground = Color(0xFFFFF0F5); // Lavender blush
  static const Color cerditaSurface = Color(0xFFFFD1DC); // Pink pastel
  static const Color cerditaError = Color(0xFFB00020);
  static const Color cerditaOnPrimary = Colors.white;
  static const Color cerditaOnBackground = Color(0xFF5C3A4C);
  static const Color cerditaOnSurface = Color(0xFF5C3A4C);
  static const Color cerditaBubbleOutgoing = Color(0xFFFFB6D9);
  static const Color cerditaBubbleIncoming = Color(0xFFFFE4F1);

  // Tema Koalita (Gris ceniza / Verde eucalipto)
  static const Color koalitaPrimary = Color(0xFF5F8575); // Eucalyptus green
  static const Color koalitaPrimaryVariant = Color(0xFF4A6B5F);
  static const Color koalitaBackground = Color(0xFFF5F5F0); // Ash gray
  static const Color koalitaSurface = Color(0xFFE8E8E3);
  static const Color koalitaError = Color(0xFFB00020);
  static const Color koalitaOnPrimary = Colors.white;
  static const Color koalitaOnBackground = Color(0xFF3D3D3D);
  static const Color koalitaOnSurface = Color(0xFF3D3D3D);
  static const Color koalitaBubbleOutgoing = Color(0xFF8FB8A8);
  static const Color koalitaBubbleIncoming = Color(0xFFD8D8D3);

  // Tema Cerdita y Koalita (Mezcla)
  static const Color cerditaKoalitaPrimary = Color(0xFFFF69B4);
  static const Color cerditaKoalitaPrimaryVariant = Color(0xFF5F8575);
  static const Color cerditaKoalitaBackground = Color(0xFFFFF5F8);
  static const Color cerditaKoalitaSurface = Color(0xFFE8E8E3);
  static const Color cerditaKoalitaError = Color(0xFFB00020);
  static const Color cerditaKoalitaOnPrimary = Colors.white;
  static const Color cerditaKoalitaOnBackground = Color(0xFF4A4A4A);
  static const Color cerditaKoalitaOnSurface = Color(0xFF4A4A4A);
  static const Color cerditaKoalitaBubbleOutgoing = Color(0xFFFFB6D9);
  static const Color cerditaKoalitaBubbleIncoming = Color(0xFFD8D8D3);

  /// Get ThemeData based on ThemeType
  static ThemeData getTheme(ThemeType themeType) {
    switch (themeType) {
      case ThemeType.light:
        return _buildLightTheme();
      case ThemeType.dark:
        return _buildDarkTheme();
      case ThemeType.cerdita:
        return _buildCerditaTheme();
      case ThemeType.koalita:
        return _buildKoalitaTheme();
      case ThemeType.cerditaKoalita:
        return _buildCerditaKoalitaTheme();
    }
  }

  /// Build Light Theme
  static ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: lightPrimary,
      primaryColorLight: lightPrimary,
      primaryColorDark: lightPrimaryVariant,
      scaffoldBackgroundColor: lightBackground,
      colorScheme: const ColorScheme.light(
        primary: lightPrimary,
        secondary: lightPrimaryVariant,
        surface: lightSurface,
        error: lightError,
        onPrimary: lightOnPrimary,
        onSecondary: lightOnPrimary,
        onSurface: lightOnSurface,
        onError: lightOnPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightPrimary,
        foregroundColor: lightOnPrimary,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardTheme(
        color: lightSurface,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: lightPrimary,
        foregroundColor: lightOnPrimary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
      ),
    );
  }

  /// Build Dark Theme
  static ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: darkPrimary,
      primaryColorLight: darkPrimary,
      primaryColorDark: darkPrimaryVariant,
      scaffoldBackgroundColor: darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: darkPrimary,
        secondary: darkPrimaryVariant,
        surface: darkSurface,
        error: darkError,
        onPrimary: darkOnPrimary,
        onSecondary: darkOnPrimary,
        onSurface: darkOnSurface,
        onError: darkOnSurface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurface,
        foregroundColor: darkOnSurface,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardTheme(
        color: darkSurface,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkPrimary,
        foregroundColor: darkOnPrimary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
      ),
    );
  }

  /// Build Cerdita Theme
  static ThemeData _buildCerditaTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: cerditaPrimary,
      primaryColorLight: cerditaPrimary,
      primaryColorDark: cerditaPrimaryVariant,
      scaffoldBackgroundColor: cerditaBackground,
      colorScheme: const ColorScheme.light(
        primary: cerditaPrimary,
        secondary: cerditaPrimaryVariant,
        surface: cerditaSurface,
        error: cerditaError,
        onPrimary: cerditaOnPrimary,
        onSecondary: cerditaOnPrimary,
        onSurface: cerditaOnSurface,
        onError: cerditaOnPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: cerditaPrimary,
        foregroundColor: cerditaOnPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        color: cerditaSurface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: cerditaPrimary,
        foregroundColor: cerditaOnPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cerditaSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
      ),
      fontFamily: 'Nunito',
    );
  }

  /// Build Koalita Theme
  static ThemeData _buildKoalitaTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: koalitaPrimary,
      primaryColorLight: koalitaPrimary,
      primaryColorDark: koalitaPrimaryVariant,
      scaffoldBackgroundColor: koalitaBackground,
      colorScheme: const ColorScheme.dark(
        primary: koalitaPrimary,
        secondary: koalitaPrimaryVariant,
        surface: koalitaSurface,
        error: koalitaError,
        onPrimary: koalitaOnPrimary,
        onSecondary: koalitaOnPrimary,
        onSurface: koalitaOnSurface,
        onError: koalitaOnSurface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: koalitaSurface,
        foregroundColor: koalitaOnSurface,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardTheme(
        color: koalitaSurface,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: koalitaPrimary,
        foregroundColor: koalitaOnPrimary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: koalitaSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
      ),
      fontFamily: 'Nunito',
    );
  }

  /// Build Cerdita y Koalita Theme
  static ThemeData _buildCerditaKoalitaTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: cerditaKoalitaPrimary,
      primaryColorLight: cerditaKoalitaPrimary,
      primaryColorDark: cerditaKoalitaPrimaryVariant,
      scaffoldBackgroundColor: cerditaKoalitaBackground,
      colorScheme: const ColorScheme.dark(
        primary: cerditaKoalitaPrimary,
        secondary: cerditaKoalitaPrimaryVariant,
        surface: cerditaKoalitaSurface,
        error: cerditaKoalitaError,
        onPrimary: cerditaKoalitaOnPrimary,
        onSecondary: cerditaKoalitaOnPrimary,
        onSurface: cerditaKoalitaOnSurface,
        onError: cerditaKoalitaOnSurface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: cerditaKoalitaSurface,
        foregroundColor: cerditaKoalitaOnPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        color: cerditaKoalitaSurface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: cerditaKoalitaPrimary,
        foregroundColor: cerditaKoalitaOnPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cerditaKoalitaSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
      ),
      fontFamily: 'Nunito',
    );
  }
}
