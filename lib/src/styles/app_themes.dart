import 'package:dns_changer/src/styles/app_colors.dart';
import 'package:dns_changer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.backgroundLight,
      surface: AppColors.backgroundLight,
      onSurface: AppColors.dividerLight,
      primary: Colors.white,
      onPrimary: AppColors.hoverLight,
      secondary: AppColors.cardLight,
      onSecondary: AppColors.black,
      onSecondaryContainer: Colors.white,
    ),
    textTheme: TextTheme(
      bodySmall: TextStyles.small.black,
      bodyMedium: TextStyles.medium.black,
      bodyLarge: TextStyles.large.black,
      titleSmall: TextStyles.medium.black,
      titleMedium: TextStyles.large.black,
      titleLarge: TextStyles.header.black,
      labelMedium: TextStyles.medium
          .copyWith(color: AppColors.secondary), // Used for secondary text
    ),
    useMaterial3: false,
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.black,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.backgroundDark,
      surface: AppColors.backgroundDark,
      onSurface: AppColors.dividerDark,
      primary: AppColors.black,
      onPrimary: AppColors.hoverDark,
      secondary: AppColors.cardDark,
      onSecondary: Colors.white,
      onSecondaryContainer: Colors.black,
    ),
    textTheme: TextTheme(
      bodySmall: TextStyles.small.white,
      bodyMedium: TextStyles.medium.white,
      bodyLarge: TextStyles.large.white,
      titleSmall: TextStyles.medium.white,
      titleMedium: TextStyles.large.white,
      titleLarge: TextStyles.header.white,
      labelMedium: TextStyles.medium
          .copyWith(color: AppColors.secondary), // Used for secondary text
    ),
    useMaterial3: false,
  );
}
