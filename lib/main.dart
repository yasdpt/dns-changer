import 'dart:io';

import 'package:dns_changer/src/controllers/theme_controller.dart';
import 'package:dns_changer/src/localization/language_config.dart';
import 'package:dns_changer/src/pages/main_page.dart';
import 'package:dns_changer/src/styles/app_themes.dart';
import 'package:dns_changer/src/util/app_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _setupStartup();
  await _setupWindow();

  // Set sudo permissions for Linux app
  if (Platform.isLinux) {
    await Process.run('pkexec', ['env']);
  }

  runApp(const ProviderScope(child: MainApp()));
}

void _setupStartup() {
  launchAtStartup.setup(
    appName: AppConsts.appName,
    appPath: Platform.resolvedExecutable,
    packageName: 'dev.yasdpt.dnschanger',
  );
}

Future<void> _setupWindow() async {
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(402, 680),
    minimumSize: Size(402, 680),
    maximumSize: Size(402, 680),
    center: true,
    backgroundColor: Colors.transparent,
    titleBarStyle: TitleBarStyle.hidden,
    skipTaskbar: false,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAsFrameless();
    await windowManager.show();
    await windowManager.focus();
  });
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeControllerProvider);

    return MaterialApp(
      title: AppConsts.appName,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: LanguageConfig.localizationDelegates,
      supportedLocales: LanguageConfig.appLocales,
      locale: LanguageConfig.appLocales.first,
      themeMode: theme,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      home: const MainPage(),
    );
  }
}
