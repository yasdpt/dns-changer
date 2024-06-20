import 'package:dns_changer/src/util/app_colors.dart';
import 'package:dns_changer/src/util/app_consts.dart';
import 'package:dns_changer/src/util/app_sizes.dart';
import 'package:dns_changer/src/util/text_styles.dart';
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
                    IconButton(
                      onPressed: () async {
                        await WindowManager.instance.minimize();
                      },
                      icon: const Icon(
                        Icons.horizontal_rule_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await WindowManager.instance.close();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            decoration: const BoxDecoration(
              color: AppColors.divider,
            ),
          )
        ],
      ),
    );
  }
}
