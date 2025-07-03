import 'package:flutter/material.dart';
import 'app_colors.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.greenDark,
    secondary: AppColors.greenDarkSecondary,
    tertiary: AppColors.greenDarkTertiary,
    surface: AppColors.surfaceDark,
    background: AppColors.bgDark,
    error: AppColors.errorDark,
  ),
  extensions: const <ThemeExtension<dynamic>>[CustomThemeExtension.darkMode],
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    primary: AppColors.greenPrimary,
    secondary: AppColors.greenSecondary,
    tertiary: AppColors.greenTertiary,
    surface: AppColors.surfaceLight,
    background: AppColors.bgLight,
    error: AppColors.errorLight,
  ),
  extensions: const <ThemeExtension<dynamic>>[CustomThemeExtension.lightMode],
);

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
    covariant ThemeExtension<CustomThemeExtension>? other,
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
