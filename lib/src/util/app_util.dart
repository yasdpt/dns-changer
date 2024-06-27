import 'package:dns_changer/src/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:launch_at_startup/launch_at_startup.dart';

class AppUtil {
  static final _whitespaceRE = RegExp(r"\s+");
  static String cleanupWhitespace(String input) =>
      input.replaceAll(_whitespaceRE, " ");

  static Color getLatencyColor(num latency) {
    if (latency < 0) return AppColors.red;
    if (latency <= 70) return AppColors.green;
    if (latency <= 200) return AppColors.orange;

    return AppColors.red;
  }

  static Future<void> changeStartup(bool isEnabled) async {
    if (isEnabled) {
      await launchAtStartup.enable();
      return;
    }

    await launchAtStartup.disable();
  }
}

extension CapitalizeExtension on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}
