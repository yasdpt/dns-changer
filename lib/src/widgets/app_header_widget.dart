import 'package:dns_changer/src/util/app_colors.dart';
import 'package:dns_changer/src/util/app_consts.dart';
import 'package:dns_changer/src/util/app_sizes.dart';
import 'package:dns_changer/src/util/text_styles.dart';
import 'package:dns_changer/src/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class AppHeaderWidget extends StatelessWidget {
  const AppHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                        AppConsts.appName,
                        style: TextStyles.large.white,
                      ),
                      gapW4,
                      Text(
                        AppConsts.appVersion,
                        style: TextStyles.small.white,
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
                        await WindowManager.instance.close();
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
            decoration: const BoxDecoration(
              color: AppColors.dividerDark,
            ),
          )
        ],
      ),
    );
  }
}
