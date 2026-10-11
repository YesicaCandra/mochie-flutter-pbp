import 'package:flutter/material.dart';

// =============================================================
// SPACING & RADIUS (token ukuran, dipakai bertahap di tiap halaman)
// =============================================================

class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
}

class AppRadius {
  static const double chip = 12;
  static const double button = 16;
  static const double input = 16;
  static const double card = 24;
  static const double sheet = 28;
  static const double dialog = 28;
}

// =============================================================
// APP THEME — "Playful Mochi"
// =============================================================

class AppTheme {
  // -----------------------------------------------------------
  // PALET BARU
  // -----------------------------------------------------------

  /// Warna identitas. Untuk ikon, indikator, fill besar.
  static const Color primary = Color(0xFFFF4F81);

  /// Pink lebih tua (kontras 4.58:1 di atas putih).
  /// Untuk teks pink, harga, link, dan latar tombol dengan teks putih.
  static const Color primaryDeep = Color(0xFFE0245E);

  static const Color peach = Color(0xFFFF9F68);
  static const Color yellow = Color(0xFFFFD95A);
  static const Color lavender = Color(0xFFB9A0FF);
  static const Color mint = Color(0xFF78DCC0);

  static const Color background = Color(0xFFFFF8F0);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cocoa = Color(0xFF49312F);

  /// Warna pesan error (kontras baik di atas putih dan cream).
  static const Color errorRed = Color(0xFFC4124A);

  // Tint lembut untuk latar ikon, chip, dan kotak ringan.
  static const Color mintSoft = Color(0xFFDDF6EF);
  static const Color lavenderSoft = Color(0xFFEFE9FF);
  static const Color yellowSoft = Color(0xFFFFF1CC);

  // -----------------------------------------------------------
  // ALIAS NAMA LAMA
  // Dipertahankan agar semua halaman yang memakai nama ini
  // tetap berjalan. Nilainya sudah diarahkan ke palet baru.
  // -----------------------------------------------------------

  static const Color cream = background;
  static const Color softPink = Color(0xFFFFE5EC);
  static const Color dustyRose = Color(0xFFFFCADA);
  static const Color dustyRoseDark = primaryDeep;
  static const Color darkPlum = cocoa;
  static const Color white = Color(0xFFFFFFFF);

  // -----------------------------------------------------------
  // FONT (di-bundle manual lewat pubspec.yaml)
  // Jika file font belum dipasang, Flutter memakai font bawaan.
  // -----------------------------------------------------------

  static const String fontDisplay = 'Fredoka';
  static const String fontBody = 'Nunito';

  // -----------------------------------------------------------
  // TEXT THEME
  // -----------------------------------------------------------

  static TextTheme _buildTextTheme() {
    final base = ThemeData(useMaterial3: true).textTheme
        .apply(fontFamily: fontBody, bodyColor: cocoa, displayColor: cocoa);

    TextStyle display(double size) => TextStyle(
      fontFamily: fontDisplay,
      fontWeight: FontWeight.w600,
      fontSize: size,
      height: 1.15,
      color: cocoa,
    );

    TextStyle body(double size, FontWeight weight, {double height = 1.45}) {
      return TextStyle(
        fontFamily: fontBody,
        fontWeight: weight,
        fontSize: size,
        height: height,
        color: cocoa,
      );
    }

    return base.copyWith(
      displayLarge: display(40),
      displayMedium: display(34),
      displaySmall: display(30),
      headlineLarge: display(28),
      headlineMedium: display(24),
      headlineSmall: display(20),
      titleLarge: display(20),
      titleMedium: body(16, FontWeight.w800),
      titleSmall: body(14, FontWeight.w800),
      bodyLarge: body(16, FontWeight.w600, height: 1.5),
      bodyMedium: body(14, FontWeight.w600, height: 1.5),
      bodySmall: body(12, FontWeight.w600),
      labelLarge: body(14, FontWeight.w800),
      labelMedium: body(12, FontWeight.w700),
      labelSmall: body(11, FontWeight.w700),
    );
  }

  static OutlineInputBorder _outline(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.input),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  // -----------------------------------------------------------
  // THEME DATA
  // -----------------------------------------------------------

  static ThemeData get theme {
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.light,
        ).copyWith(
          primary: primaryDeep,
          onPrimary: white,
          primaryContainer: softPink,
          onPrimaryContainer: cocoa,
          secondary: peach,
          onSecondary: cocoa,
          secondaryContainer: dustyRose,
          onSecondaryContainer: cocoa,
          tertiary: lavender,
          onTertiary: cocoa,
          tertiaryContainer: lavenderSoft,
          onTertiaryContainer: cocoa,
          error: errorRed,
          onError: white,
          surface: surface,
          onSurface: cocoa,
          surfaceTint: Colors.transparent,
          outline: dustyRose,
          outlineVariant: softPink,
        );

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.button),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      fontFamily: fontBody,
      textTheme: _buildTextTheme(),
      iconTheme: const IconThemeData(color: cocoa, size: 24),

      // ---------------------------------------------------------
      // APP BAR (tanpa tint saat di-scroll)
      // ---------------------------------------------------------
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: cocoa,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        iconTheme: IconThemeData(color: cocoa, size: 24),
        actionsIconTheme: IconThemeData(color: cocoa, size: 24),
        titleTextStyle: TextStyle(
          fontFamily: fontDisplay,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: cocoa,
        ),
      ),

      // ---------------------------------------------------------
      // BUTTON
      // ---------------------------------------------------------
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryDeep,
          foregroundColor: white,
          disabledBackgroundColor: primaryDeep.withValues(alpha: 0.35),
          disabledForegroundColor: white,
          elevation: 0,
          minimumSize: const Size(64, 44),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: shape,
          textStyle: const TextStyle(
            fontFamily: fontBody,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryDeep,
          foregroundColor: white,
          disabledBackgroundColor: primaryDeep.withValues(alpha: 0.35),
          disabledForegroundColor: white,
          elevation: 0,
          minimumSize: const Size(64, 44),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: shape,
          textStyle: const TextStyle(
            fontFamily: fontBody,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryDeep,
          side: const BorderSide(color: primaryDeep, width: 1.5),
          minimumSize: const Size(64, 44),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: shape,
          textStyle: const TextStyle(
            fontFamily: fontBody,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryDeep,
          textStyle: const TextStyle(
            fontFamily: fontBody,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      // ---------------------------------------------------------
      // INPUT
      // ---------------------------------------------------------
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: TextStyle(
          fontFamily: fontBody,
          fontWeight: FontWeight.w600,
          color: cocoa.withValues(alpha: 0.7),
        ),
        labelStyle: TextStyle(
          fontFamily: fontBody,
          fontWeight: FontWeight.w600,
          color: cocoa.withValues(alpha: 0.75),
        ),
        floatingLabelStyle: const TextStyle(
          fontFamily: fontBody,
          fontWeight: FontWeight.w800,
          color: primaryDeep,
        ),
        errorStyle: const TextStyle(
          fontFamily: fontBody,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: errorRed,
        ),
        border: _outline(dustyRose, 1.5),
        enabledBorder: _outline(dustyRose, 1.5),
        focusedBorder: _outline(primary, 2),
        errorBorder: _outline(errorRed, 1.5),
        focusedErrorBorder: _outline(errorRed, 2),
      ),

      // ---------------------------------------------------------
      // CARD, DIALOG, BOTTOM SHEET
      // ---------------------------------------------------------
      cardTheme: CardThemeData(
        color: white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: cocoa.withValues(alpha: 0.12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.dialog),
        ),
        titleTextStyle: const TextStyle(
          fontFamily: fontDisplay,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: cocoa,
        ),
        contentTextStyle: TextStyle(
          fontFamily: fontBody,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: cocoa.withValues(alpha: 0.85),
        ),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: background,
        modalBackgroundColor: background,
        surfaceTintColor: Colors.transparent,
        showDragHandle: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.sheet),
          ),
        ),
      ),

      // ---------------------------------------------------------
      // SNACKBAR
      // ---------------------------------------------------------
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: cocoa,
        actionTextColor: yellow,
        contentTextStyle: const TextStyle(
          fontFamily: fontBody,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
      ),

      // ---------------------------------------------------------
      // NAVIGATION BAR + BADGE
      // ---------------------------------------------------------
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: white,
        surfaceTintColor: Colors.transparent,
        indicatorColor: dustyRose,
        elevation: 4,
        shadowColor: cocoa.withValues(alpha: 0.15),
        height: 72,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);

          return TextStyle(
            fontFamily: fontBody,
            fontSize: 12,
            fontWeight: selected ? FontWeight.w800 : FontWeight.w700,
            color: selected ? primaryDeep : cocoa,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);

          return IconThemeData(size: 24, color: selected ? primaryDeep : cocoa);
        }),
      ),

      badgeTheme: const BadgeThemeData(
        backgroundColor: primaryDeep,
        textColor: white,
      ),

      // ---------------------------------------------------------
      // CHIP, MENU, CHECKBOX, DIVIDER, PROGRESS
      // ---------------------------------------------------------
      chipTheme: ChipThemeData(
        backgroundColor: white,
        selectedColor: primaryDeep,
        showCheckmark: false,
        side: const BorderSide(color: dustyRose, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.chip),
        ),
        labelStyle: const TextStyle(
          fontFamily: fontBody,
          fontSize: 13,
          fontWeight: FontWeight.w800,
          color: cocoa,
        ),
      ),

      popupMenuTheme: PopupMenuThemeData(
        color: white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        textStyle: const TextStyle(
          fontFamily: fontBody,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: cocoa,
        ),
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryDeep;
          }

          return null;
        }),
        checkColor: WidgetStateProperty.all(white),
        side: const BorderSide(color: primaryDeep, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),

      dividerTheme: const DividerThemeData(
        color: softPink,
        thickness: 1,
        space: 1,
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(color: primary),
    );
  }
}
