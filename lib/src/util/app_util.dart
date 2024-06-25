import 'package:dns_changer/src/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppUtil {
  static final _whitespaceRE = RegExp(r"\s+");
  static String cleanupWhitespace(String input) =>
      input.replaceAll(_whitespaceRE, " ");

  static Color getLatencyColor(num latency) {
    if (latency <= 70) return AppColors.green;
    if (latency <= 200) return AppColors.orange;

    return AppColors.red;
  }
}
