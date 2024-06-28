import 'package:dns_changer/src/styles/app_colors.dart';
import 'package:dns_changer/src/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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

  static void showSnackBar(
    BuildContext context, {
    required String message,
    bool isError = false,
    bool persistent = false,
  }) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar(message: message, isError: isError), // Custom Widget
      padding: const EdgeInsets.only(bottom: 48.0),
      snackBarPosition: SnackBarPosition.bottom,
      animationDuration: const Duration(milliseconds: 300),
      curve: Curves.ease,
      persistent: persistent,
    );
  }
}

extension CapitalizeExtension on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}
