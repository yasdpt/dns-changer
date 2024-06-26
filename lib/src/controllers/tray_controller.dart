import 'dart:io';

import 'package:dns_changer/src/util/app_consts.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:dns_changer/src/util/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

part 'tray_controller.g.dart';

@riverpod
class TrayController extends _$TrayController {
  late SharedPreferences _prefs;

  @override
  bool build() {
    _updateTrayState();

    return false;
  }

  Future<void> _updateTrayState() async {
    _prefs = await ref.read(prefsProvider.future);
    final isEnabled = _prefs.getBool(AppConsts.prefsSystemTrayKey);

    _setupSystemTray(isEnabled ?? false);
  }

  void setSystemTrayState(bool isEnabled) {
    _prefs.setBool(
      AppConsts.prefsSystemTrayKey,
      isEnabled,
    );

    _setupSystemTray(isEnabled);
  }

  Future<void> _setupSystemTray(bool isEnabled) async {
    state = isEnabled;

    if (isEnabled) {
      await trayManager.setIcon(
        Platform.isWindows ? AppConsts.logoICO : AppConsts.logoPNG,
      );
      Menu menu = Menu(
        items: [
          MenuItem(
            key: 'open',
            label: 'Open DNS Manager',
            onClick: (item) async {
              await windowManager.show();
            },
          ),
          MenuItem.separator(),
          MenuItem(
            key: 'exit',
            label: 'Exit',
            onClick: (item) async {
              await windowManager.close();
            },
          ),
        ],
      );
      await trayManager.setContextMenu(menu);

      return;
    }

    await trayManager.destroy();
  }
}
