import 'package:dns_changer/src/controllers/tray_controller.dart';
import 'package:dns_changer/src/localization/language_constraints.dart';
import 'package:dns_changer/src/util/app_consts.dart';
import 'package:dns_changer/src/styles/app_sizes.dart';
import 'package:dns_changer/src/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

class AppHeaderWidget extends ConsumerWidget {
  const AppHeaderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DragToMoveArea(
      child: Column(
        children: [
          SizedBox(
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Row(
                    children: [
                      gapW16,
                      Text(
                        translate('appName', context),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconWidget(
                      onTap: () async {
                        await WindowManager.instance.minimize();
                      },
                      icon: AppConsts.minimizeIcon,
                      size: 28.0,
                    ),
                    IconWidget(
                      onTap: () async {
                        final isMinizeToTrayEnabled =
                            ref.read(trayControllerProvider);

                        if (isMinizeToTrayEnabled) {
                          await WindowManager.instance.hide();
                        } else {
                          await WindowManager.instance.close();
                        }
                      },
                      icon: AppConsts.closeIcon,
                      size: 28.0,
                    ),
                    gapW8,
                  ],
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          )
        ],
      ),
    );
  }
}
