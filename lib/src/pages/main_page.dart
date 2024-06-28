import 'dart:io';

import 'package:dns_changer/src/controllers/page_controller.dart';
import 'package:dns_changer/src/controllers/tray_controller.dart';
import 'package:dns_changer/src/localization/language_constraints.dart';
import 'package:dns_changer/src/pages/about_page.dart';
import 'package:dns_changer/src/pages/dns_page.dart';
import 'package:dns_changer/src/pages/settings_page.dart';
import 'package:dns_changer/src/util/app_consts.dart';
import 'package:dns_changer/src/widgets/app_header_widget.dart';
import 'package:dns_changer/src/widgets/side_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> with TrayListener {
  @override
  void initState() {
    trayManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    trayManager.removeListener(this);
    super.dispose();
  }

  @override
  void onTrayIconMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  Widget build(BuildContext context) {
    final page = ref.watch(pageControllerProvider);
    // Watch for state taking effect on startup
    ref.watch(trayControllerProvider);

    ref.listen(
      trayControllerProvider,
      _handleSystemTrayState,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppConsts.appBorderRadius),
        ),
        child: Column(
          children: [
            const AppHeaderWidget(),
            Expanded(
              child: Row(
                children: [
                  const SideBarWidget(),
                  Expanded(
                    child: switch (page) {
                      0 => const DNSPage(),
                      1 => const SettingsPage(),
                      2 => const AboutPage(),
                      _ => const SizedBox.shrink(),
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleSystemTrayState(bool? prev, bool next) async {
    final textOpen = translate('open', context);
    final textAppName = translate('appName', context);
    final textExit = translate('exit', context);

    if (next) {
      await trayManager.setIcon(
        Platform.isWindows ? AppConsts.logoICO : AppConsts.logoPNG,
      );

      Menu menu = Menu(
        items: [
          MenuItem(
            key: 'open',
            label: '$textOpen $textAppName',
            onClick: (item) async {
              await windowManager.show();
            },
          ),
          MenuItem.separator(),
          MenuItem(
            key: 'exit',
            label: textExit,
            onClick: (item) async {
              await windowManager.close();
            },
          ),
        ],
      );
      await trayManager.setContextMenu(menu);
    } else {
      await trayManager.destroy();
    }
  }
}
