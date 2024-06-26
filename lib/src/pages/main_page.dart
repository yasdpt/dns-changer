import 'package:dns_changer/src/controllers/page_controller.dart';
import 'package:dns_changer/src/controllers/tray_controller.dart';
import 'package:dns_changer/src/pages/about_page.dart';
import 'package:dns_changer/src/pages/dns_page.dart';
import 'package:dns_changer/src/pages/settings_page.dart';
import 'package:dns_changer/src/styles/app_sizes.dart';
import 'package:dns_changer/src/util/app_consts.dart';
import 'package:dns_changer/src/widgets/app_header_widget.dart';
import 'package:dns_changer/src/widgets/side_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tray_manager/tray_manager.dart';

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

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppConsts.appBorderRadius),
          border: Border.all(color: Colors.white, width: 0.5),
        ),
        child: Column(
          children: [
            const AppHeaderWidget(),
            Expanded(
              child: Row(
                children: [
                  const SideBarWidget(),
                  gapW12,
                  switch (page) {
                    0 => const DNSPage(),
                    1 => const SettingsPage(),
                    2 => const AboutPage(),
                    _ => const SizedBox.shrink(),
                  }
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
