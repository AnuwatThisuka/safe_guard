import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Primary colors - using a more vibrant emergency red and a calmer blue
  static final Color primaryColor = const Color(0xFFD32F2F);
  static final Color secondaryColor = const Color(0xFF1976D2);
  static final Color accentColor = const Color(0xFFFF8F00);

  // Background colors
  static final Color backgroundColor = const Color(0xFFF5F5F5);
  static final Color surfaceColor = Colors.white;
  static final Color darkBackgroundColor = const Color(0xFF121212);
  static final Color darkSurfaceColor = const Color(0xFF1E1E1E);

  // Status colors
  static final Color successColor = const Color(0xFF43A047);
  static final Color warningColor = const Color(0xFFFFA000);
  static final Color errorColor = const Color(0xFFE53935);
  static final Color infoColor = const Color(0xFF1E88E5);

  // Border styles
  static final BorderSide lightBorderSide =
      BorderSide(color: Colors.grey[300]!);
  static final BorderSide darkBorderSide = BorderSide(color: Colors.grey[800]!);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.notoSansThai().fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: accentColor,
      background: backgroundColor,
      surface: surfaceColor,
      error: errorColor,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
      shadowColor: primaryColor.withOpacity(0.3),
      titleTextStyle: GoogleFonts.notoSansThai(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey[600],
      selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(fontSize: 12),
      elevation: 8,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: surfaceColor,
      indicatorColor: primaryColor.withOpacity(0.1),
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => TextStyle(
          color: states.contains(WidgetState.selected)
              ? primaryColor
              : Colors.grey[600],
          fontSize: 12,
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w500
              : FontWeight.normal,
        ),
      ),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          color: states.contains(WidgetState.selected)
              ? primaryColor
              : Colors.grey[600],
          size: 24,
        ),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 1,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      clipBehavior: Clip.antiAlias,
      color: surfaceColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: lightBorderSide,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: lightBorderSide,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: errorColor, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: TextStyle(color: Colors.grey[500]),
      labelStyle: TextStyle(color: Colors.grey[700]),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: primaryColor.withOpacity(0.3),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.notoSansThai(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(color: primaryColor),
        textStyle: GoogleFonts.notoSansThai(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: secondaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        textStyle: GoogleFonts.notoSansThai(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    iconTheme: IconThemeData(
      color: primaryColor,
      size: 24,
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey[300],
      thickness: 1,
      space: 24,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: backgroundColor,
      disabledColor: Colors.grey[200],
      selectedColor: primaryColor.withOpacity(0.1),
      secondarySelectedColor: primaryColor.withOpacity(0.2),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: TextStyle(fontSize: 14),
      secondaryLabelStyle: TextStyle(fontSize: 14, color: primaryColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: Colors.grey[300]!),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.grey[900],
      contentTextStyle: GoogleFonts.notoSansThai(
        color: Colors.white,
        fontSize: 14,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      behavior: SnackBarBehavior.floating,
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      titleTextStyle: GoogleFonts.notoSansThai(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      contentTextStyle: GoogleFonts.notoSansThai(
        fontSize: 16,
        color: Colors.black87,
      ),
    ),
    textTheme: _buildTextTheme(Brightness.light),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.notoSansThai().fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor.withOpacity(0.9),
      secondary: secondaryColor.withOpacity(0.9),
      tertiary: accentColor,
      background: darkBackgroundColor,
      surface: darkSurfaceColor,
      error: errorColor.withOpacity(0.9),
      brightness: Brightness.dark,
      onBackground: Colors.white.withOpacity(0.87),
      onSurface: Colors.white.withOpacity(0.87),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: darkSurfaceColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.notoSansThai(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkSurfaceColor,
      selectedItemColor: primaryColor.withOpacity(0.9),
      unselectedItemColor: Colors.grey[400],
      selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(fontSize: 12),
      elevation: 8,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: darkSurfaceColor,
      indicatorColor: primaryColor.withOpacity(0.2),
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => TextStyle(
          color: states.contains(WidgetState.selected)
              ? primaryColor.withOpacity(0.9)
              : Colors.grey[400],
          fontSize: 12,
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w500
              : FontWeight.normal,
        ),
      ),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          color: states.contains(WidgetState.selected)
              ? primaryColor.withOpacity(0.9)
              : Colors.grey[400],
          size: 24,
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: Color(0xFF252525),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey[800]!),
      ),
      clipBehavior: Clip.antiAlias,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF2A2A2A),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: darkBorderSide,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: darkBorderSide,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor.withOpacity(0.9), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: errorColor.withOpacity(0.9), width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: TextStyle(color: Colors.grey[500]),
      labelStyle: TextStyle(color: Colors.grey[400]),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor.withOpacity(0.9),
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.3),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.notoSansThai(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor.withOpacity(0.9),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(color: primaryColor.withOpacity(0.9)),
        textStyle: GoogleFonts.notoSansThai(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: secondaryColor.withOpacity(0.9),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        textStyle: GoogleFonts.notoSansThai(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    iconTheme: IconThemeData(
      color: primaryColor.withOpacity(0.9),
      size: 24,
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey[800],
      thickness: 1,
      space: 24,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Color(0xFF2A2A2A),
      disabledColor: Colors.grey[800],
      selectedColor: primaryColor.withOpacity(0.2),
      secondarySelectedColor: primaryColor.withOpacity(0.3),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle:
          TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.87)),
      secondaryLabelStyle:
          TextStyle(fontSize: 14, color: primaryColor.withOpacity(0.9)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: Colors.grey[700]!),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.grey[900],
      contentTextStyle: GoogleFonts.notoSansThai(
        color: Colors.white,
        fontSize: 14,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      behavior: SnackBarBehavior.floating,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: darkSurfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      titleTextStyle: GoogleFonts.notoSansThai(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white.withOpacity(0.95),
      ),
      contentTextStyle: GoogleFonts.notoSansThai(
        fontSize: 16,
        color: Colors.white.withOpacity(0.87),
      ),
    ),
    textTheme: _buildTextTheme(Brightness.dark),
  );

  static TextTheme _buildTextTheme(Brightness brightness) {
    final Color textPrimaryColor = brightness == Brightness.light
        ? const Color(0xFF212121)
        : Colors.white.withOpacity(0.87);

    final Color textSecondaryColor = brightness == Brightness.light
        ? const Color(0xFF616161)
        : Colors.white.withOpacity(0.6);

    final Color textTertiaryColor = brightness == Brightness.light
        ? const Color(0xFF757575)
        : Colors.white.withOpacity(0.4);

    return TextTheme(
      displayLarge: _textStyle(32, FontWeight.bold, textPrimaryColor, -0.5),
      displayMedium: _textStyle(28, FontWeight.bold, textPrimaryColor, -0.5),
      displaySmall: _textStyle(24, FontWeight.bold, textPrimaryColor, -0.5),
      headlineLarge: _textStyle(32, FontWeight.bold, textPrimaryColor, -0.5),
      headlineMedium: _textStyle(24, FontWeight.bold, textPrimaryColor, -0.5),
      headlineSmall: _textStyle(20, FontWeight.bold, textPrimaryColor, -0.25),
      titleLarge: _textStyle(20, FontWeight.w600, textPrimaryColor, -0.25),
      titleMedium: _textStyle(16, FontWeight.w600, textPrimaryColor, -0.25),
      titleSmall: _textStyle(14, FontWeight.w600, textPrimaryColor, -0.25),
      bodyLarge: _textStyle(16, FontWeight.normal, textPrimaryColor, 0.15, 1.5),
      bodyMedium:
          _textStyle(14, FontWeight.normal, textSecondaryColor, 0.25, 1.5),
      bodySmall: _textStyle(12, FontWeight.normal, textTertiaryColor, 0.4, 1.5),
      labelLarge: _textStyle(14, FontWeight.w500, textPrimaryColor, 0.1),
      labelMedium: _textStyle(12, FontWeight.w500, textSecondaryColor, 0.5),
      labelSmall: _textStyle(11, FontWeight.w500, textSecondaryColor, 0.5),
    );
  }

  static TextStyle _textStyle(
    double size,
    FontWeight weight,
    Color color,
    double letterSpacing, [
    double? height,
  ]) {
    return GoogleFonts.notoSansThai(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  // Helper methods for emergency-focused components
  static BoxDecoration emergencyCardDecoration(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          primaryColor.withOpacity(isDark ? 0.7 : 0.9),
          primaryColor.withOpacity(isDark ? 0.5 : 0.7),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: primaryColor.withOpacity(isDark ? 0.4 : 0.3),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    );
  }

  static BoxDecoration serviceCardDecoration(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDark ? darkSurfaceColor : surfaceColor,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    );
  }
}
