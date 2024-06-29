import 'package:dns_changer/src/styles/app_colors.dart';
import 'package:dns_changer/src/util/app_consts.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static const TextStyle small = TextStyle(
    fontSize: 12,
    fontFamily: AppConsts.fontFamily,
  );

  static const TextStyle medium = TextStyle(
    fontSize: 14,
    fontFamily: AppConsts.fontFamily,
  );

  static const TextStyle large = TextStyle(
    fontSize: 16,
    fontFamily: AppConsts.fontFamily,
  );

  static const TextStyle header = TextStyle(
    fontSize: 24,
    fontFamily: AppConsts.fontFamily,
  );
}

// Add extension on [TextStyle] to easily change configuration
// Example: TextStyles.regular.white (changes color to white)
extension TextStyleExtesino on TextStyle {
  TextStyle get black => copyWith(color: AppColors.black);
  TextStyle get white => copyWith(color: Colors.white);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
}
