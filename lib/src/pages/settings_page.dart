import 'package:dns_changer/src/controllers/theme_controller.dart';
import 'package:dns_changer/src/controllers/tray_controller.dart';
import 'package:dns_changer/src/styles/app_sizes.dart';
import 'package:dns_changer/src/styles/text_styles.dart';
import 'package:dns_changer/src/util/app_consts.dart';
import 'package:dns_changer/src/util/app_util.dart';
import 'package:dns_changer/src/widgets/custom_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launch_at_startup/launch_at_startup.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool _startUpEnabled = false;

  @override
  void initState() {
    super.initState();

    _setupData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeControllerProvider);
    final systemTrayEnabled = ref.watch(trayControllerProvider);

    return Column(
      children: [
        gapH12,
        Container(
          width: 322.0,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(AppConsts.borderRadius),
          ),
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Theme",
                    style: Theme.of(context).textTheme.bodyMedium?.bold,
                  ),
                  CustomDropdownButton(
                    value: (theme?.name ?? "system").capitalize(),
                    items: const ["System", "Light", "Dark"],
                    width: 108.0,
                    onChanged: (value) {
                      ref
                          .read(themeControllerProvider.notifier)
                          .setAppTheme(value?.toLowerCase());
                    },
                  ),
                ],
              ),
              gapH12,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Auto startup",
                    style: Theme.of(context).textTheme.bodyMedium?.bold,
                  ),
                  Switch(
                    value: _startUpEnabled,
                    activeColor: const Color.fromARGB(255, 133, 147, 253),
                    onChanged: (isEnabled) async {
                      await AppUtil.changeStartup(isEnabled);
                      setState(() {
                        _startUpEnabled = isEnabled;
                      });
                    },
                  )
                ],
              ),
              gapH12,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Minimize to tray",
                    style: Theme.of(context).textTheme.bodyMedium?.bold,
                  ),
                  Switch(
                    value: systemTrayEnabled,
                    activeColor: const Color.fromARGB(255, 133, 147, 253),
                    onChanged: (isEnabled) {
                      ref
                          .read(trayControllerProvider.notifier)
                          .setSystemTrayState(isEnabled);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  void _setupData() {
    Future.delayed(Duration.zero, () {
      launchAtStartup.isEnabled().then((isEnabled) {
        setState(() {
          _startUpEnabled = isEnabled;
        });
      });
    });
  }
}
