import 'package:flutter/material.dart';
import 'app_colors.dart';

// Material Design 3 Seed Colors for TCloset
const Color _seedColor =
    Color(0xFF2E7D32); // Forest Green - sophisticated and modern

ThemeData get lightTheme => ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.light,
        dynamicSchemeVariant: DynamicSchemeVariant.tonalSpot,
      ).copyWith(
        // Custom overrides for fashion app aesthetics
        surface: const Color(0xFFFEFEFE),
        surfaceContainerLowest: const Color(0xFFFFFFFF),
        surfaceContainerLow: const Color(0xFFF7F9F7),
        surfaceContainer: const Color(0xFFF1F4F1),
        surfaceContainerHigh: const Color(0xFFEBEFEB),
        surfaceContainerHighest: const Color(0xFFE5E9E5),
      ),

      // Modern Typography with Google Fonts
      textTheme: _buildTextTheme(Brightness.light),

      // Enhanced App Bar Theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: Color(0xFFFEFEFE),
        surfaceTintColor: _seedColor,
        foregroundColor: Color(0xFF1D1B20),
        iconTheme: IconThemeData(
          color: Color(0xFF49454F),
          size: 24,
        ),
        shape: RoundedRectangleBorder(),
      ),

      // Modern Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: const Color(0xFF79747E).withValues(alpha: 0.12),
            width: 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        surfaceTintColor: _seedColor,
      ),

      // Modern Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 3,
        highlightElevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        sizeConstraints: const BoxConstraints.tightFor(
          width: 56,
          height: 56,
        ),
      ),

      // Enhanced Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          side: BorderSide(
            color: _seedColor.withValues(alpha: 0.12),
            width: 1,
          ),
        ),
      ),

      // Modern Navigation Bar Theme
      navigationBarTheme: NavigationBarThemeData(
        height: 80,
        elevation: 0,
        backgroundColor: const Color(0xFFFEFEFE),
        surfaceTintColor: _seedColor,
        indicatorColor: _seedColor.withValues(alpha: 0.12),
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(
              color: _seedColor,
              size: 24,
            );
          }
          return const IconThemeData(
            color: Color(0xFF49454F),
            size: 24,
          );
        }),
      ),

      // Modern Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF7F9F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: const Color(0xFF79747E).withValues(alpha: 0.38),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: _seedColor,
            width: 2,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),

      // Modern Chip Theme
      chipTheme: ChipThemeData(
        elevation: 0,
        pressElevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),

      // Modern Dialog Theme
      dialogTheme: DialogThemeData(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        backgroundColor: const Color(0xFFFEFEFE),
        surfaceTintColor: _seedColor,
      ),

      // Modern Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(28),
          ),
        ),
        backgroundColor: Color(0xFFFEFEFE),
      ),

      extensions: const <ThemeExtension<dynamic>>[
        CustomThemeExtension.lightMode,
      ],
    );

ThemeData get darkTheme => ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.dark,
        dynamicSchemeVariant: DynamicSchemeVariant.tonalSpot,
      ).copyWith(
        // Custom overrides for dark mode
        surface: const Color(0xFF131316),
        surfaceContainerLowest: const Color(0xFF0E0E11),
        surfaceContainerLow: const Color(0xFF1B1B1F),
        surfaceContainer: const Color(0xFF1F1F23),
        surfaceContainerHigh: const Color(0xFF2A2A2E),
        surfaceContainerHighest: const Color(0xFF353539),
      ),

      // Modern Typography with Google Fonts
      textTheme: _buildTextTheme(Brightness.dark),

      // Enhanced App Bar Theme for Dark Mode
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: Color(0xFF131316),
        surfaceTintColor: _seedColor,
        foregroundColor: Color(0xFFE6E0E9),
        iconTheme: IconThemeData(
          color: Color(0xFFCAC4D0),
          size: 24,
        ),
        shape: RoundedRectangleBorder(),
      ),

      // Modern Card Theme for Dark Mode
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: const Color(0xFF938F99).withValues(alpha: 0.12),
            width: 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        surfaceTintColor: _seedColor,
      ),

      // Modern Navigation Bar Theme for Dark Mode
      navigationBarTheme: NavigationBarThemeData(
        height: 80,
        elevation: 0,
        backgroundColor: const Color(0xFF131316),
        surfaceTintColor: _seedColor,
        indicatorColor: _seedColor.withValues(alpha: 0.24),
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(
              color: Color(0xFF4F9548),
              size: 24,
            );
          }
          return const IconThemeData(
            color: Color(0xFFCAC4D0),
            size: 24,
          );
        }),
      ),

      // Modern Input Decoration for Dark Mode
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1F1F23),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: const Color(0xFF938F99).withValues(alpha: 0.38),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFF4F9548),
            width: 2,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),

      extensions: const <ThemeExtension<dynamic>>[
        CustomThemeExtension.darkMode,
      ],
    );

// Modern Typography using Google Fonts
TextTheme _buildTextTheme(Brightness brightness) {
  return const TextTheme();
}

extension ExtendedTheme on BuildContext {
  CustomThemeExtension get theme =>
      Theme.of(this).extension<CustomThemeExtension>() ??
      CustomThemeExtension.lightMode;
}

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  final Color bg;
  final Color appBar;
  final Color textColor;
  final Color shadow;
  final Color surface;
  final Color surfaceVariant;

  // Green Palette
  final Color greenPrimary;
  final Color greenSecondary;
  final Color greenTertiary;
  final Color greenAccent;

  // Complementary Colors
  final Color yellow;
  final Color blue;
  final Color red;
  final Color orange;
  final Color purple;
  final Color grey;

  // Semantic Colors
  final Color success;
  final Color warning;
  final Color error;
  final Color info;

  // Pastel Colors for Categories
  final Color pastelGreenPrimary;
  final Color pastelGreenSecondary;
  final Color pastelMint;
  final Color pastelSage;

  static const lightMode = CustomThemeExtension(
    bg: AppColors.bgLight,
    appBar: AppColors.appBarLight,
    textColor: AppColors.textColorLight,
    shadow: AppColors.shadowLight,
    surface: AppColors.surfaceLight,
    surfaceVariant: AppColors.surfaceVariantLight,
    greenPrimary: AppColors.greenPrimary,
    greenSecondary: AppColors.greenSecondary,
    greenTertiary: AppColors.greenTertiary,
    greenAccent: AppColors.greenAccent,
    yellow: AppColors.yellowLight,
    blue: AppColors.blueLight,
    red: AppColors.redLight,
    orange: AppColors.orangeLight,
    purple: AppColors.purpleLight,
    grey: AppColors.greyLight,
    success: AppColors.successLight,
    warning: AppColors.warningLight,
    error: AppColors.errorLight,
    info: AppColors.infoLight,
    pastelGreenPrimary: AppColors.pastelGreenPrimary,
    pastelGreenSecondary: AppColors.pastelGreenSecondary,
    pastelMint: AppColors.pastelMint,
    pastelSage: AppColors.pastelSage,
  );

  static const darkMode = CustomThemeExtension(
    bg: AppColors.bgDark,
    appBar: AppColors.appBarDark,
    textColor: AppColors.textColorDark,
    shadow: AppColors.shadowDark,
    surface: AppColors.surfaceDark,
    surfaceVariant: AppColors.surfaceVariantDark,
    greenPrimary: AppColors.greenDark,
    greenSecondary: AppColors.greenDarkSecondary,
    greenTertiary: AppColors.greenDarkTertiary,
    greenAccent: AppColors.greenAccent,
    yellow: AppColors.yellowDark,
    blue: AppColors.blueDark,
    red: AppColors.redDark,
    orange: AppColors.orangeDark,
    purple: AppColors.purpleDark,
    grey: AppColors.greyDark,
    success: AppColors.successDark,
    warning: AppColors.warningDark,
    error: AppColors.errorDark,
    info: AppColors.infoDark,
    pastelGreenPrimary: AppColors.pastelGreenPrimary,
    pastelGreenSecondary: AppColors.pastelGreenSecondary,
    pastelMint: AppColors.pastelMint,
    pastelSage: AppColors.pastelSage,
  );

  const CustomThemeExtension({
    required this.bg,
    required this.appBar,
    required this.textColor,
    required this.shadow,
    required this.surface,
    required this.surfaceVariant,
    required this.greenPrimary,
    required this.greenSecondary,
    required this.greenTertiary,
    required this.greenAccent,
    required this.yellow,
    required this.blue,
    required this.red,
    required this.orange,
    required this.purple,
    required this.grey,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.pastelGreenPrimary,
    required this.pastelGreenSecondary,
    required this.pastelMint,
    required this.pastelSage,
  });

  @override
  ThemeExtension<CustomThemeExtension> copyWith({
    Color? bg,
    Color? appBar,
    Color? textColor,
    Color? shadow,
    Color? surface,
    Color? surfaceVariant,
    Color? greenPrimary,
    Color? greenSecondary,
    Color? greenTertiary,
    Color? greenAccent,
    Color? yellow,
    Color? blue,
    Color? red,
    Color? orange,
    Color? purple,
    Color? grey,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
    Color? pastelGreenPrimary,
    Color? pastelGreenSecondary,
    Color? pastelMint,
    Color? pastelSage,
  }) {
    return CustomThemeExtension(
      bg: bg ?? this.bg,
      appBar: appBar ?? this.appBar,
      textColor: textColor ?? this.textColor,
      shadow: shadow ?? this.shadow,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      greenPrimary: greenPrimary ?? this.greenPrimary,
      greenSecondary: greenSecondary ?? this.greenSecondary,
      greenTertiary: greenTertiary ?? this.greenTertiary,
      greenAccent: greenAccent ?? this.greenAccent,
      yellow: yellow ?? this.yellow,
      blue: blue ?? this.blue,
      red: red ?? this.red,
      orange: orange ?? this.orange,
      purple: purple ?? this.purple,
      grey: grey ?? this.grey,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
      pastelGreenPrimary: pastelGreenPrimary ?? this.pastelGreenPrimary,
      pastelGreenSecondary: pastelGreenSecondary ?? this.pastelGreenSecondary,
      pastelMint: pastelMint ?? this.pastelMint,
      pastelSage: pastelSage ?? this.pastelSage,
    );
  }

  @override
  ThemeExtension<CustomThemeExtension> lerp(
    ThemeExtension<CustomThemeExtension>? other,
    double t,
  ) {
    if (other is! CustomThemeExtension) {
      return this;
    }
    return CustomThemeExtension(
      bg: Color.lerp(bg, other.bg, t)!,
      appBar: Color.lerp(appBar, other.appBar, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      greenPrimary: Color.lerp(greenPrimary, other.greenPrimary, t)!,
      greenSecondary: Color.lerp(greenSecondary, other.greenSecondary, t)!,
      greenTertiary: Color.lerp(greenTertiary, other.greenTertiary, t)!,
      greenAccent: Color.lerp(greenAccent, other.greenAccent, t)!,
      yellow: Color.lerp(yellow, other.yellow, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      red: Color.lerp(red, other.red, t)!,
      orange: Color.lerp(orange, other.orange, t)!,
      purple: Color.lerp(purple, other.purple, t)!,
      grey: Color.lerp(grey, other.grey, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      info: Color.lerp(info, other.info, t)!,
      pastelGreenPrimary:
          Color.lerp(pastelGreenPrimary, other.pastelGreenPrimary, t)!,
      pastelGreenSecondary:
          Color.lerp(pastelGreenSecondary, other.pastelGreenSecondary, t)!,
      pastelMint: Color.lerp(pastelMint, other.pastelMint, t)!,
      pastelSage: Color.lerp(pastelSage, other.pastelSage, t)!,
    );
  }
}
