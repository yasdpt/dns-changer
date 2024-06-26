import 'package:dns_changer/src/util/app_consts.dart';
import 'package:dns_changer/src/util/provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_controller.g.dart';

@riverpod
class ThemeController extends _$ThemeController {
  late SharedPreferences _prefs;

  @override
  ThemeMode? build() {
    _updateTheme();

    return ThemeMode.light;
  }

  Future<void> _updateTheme() async {
    _prefs = await ref.read(prefsProvider.future);
    final theme = _prefs.getString(AppConsts.prefsThemeKey);

    _setThemeByString(theme);
  }

  void setAppTheme(String? theme) {
    _prefs.setString(
      AppConsts.prefsThemeKey,
      theme ?? "system",
    );

    _setThemeByString(theme);
  }

  void _setThemeByString(String? theme) {
    switch (theme) {
      case "light":
        state = ThemeMode.light;
        break;
      case "dark":
        state = ThemeMode.dark;
        break;
      default:
        state = ThemeMode.system;
    }
  }
}
