import 'package:dns_changer/src/util/app_colors.dart';
import 'package:dns_changer/src/util/app_consts.dart';
import 'package:dns_changer/src/util/app_sizes.dart';
import 'package:dns_changer/src/widgets/icon_widget.dart';
import 'package:flutter/material.dart';

class SideBarWidget extends StatelessWidget {
  const SideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        gapW8,
        Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  gapH8,
                  IconWidget(
                    icon: AppConsts.dnsIcon,
                    isSelected: true,
                    onTap: () {},
                  ),
                  gapH8,
                  IconWidget(
                    icon: AppConsts.settingsIcon,
                    isSelected: false,
                    onTap: () {},
                  ),
                  gapH8,
                  IconWidget(
                    icon: AppConsts.infoIcon,
                    isSelected: false,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            IconWidget(
              icon: AppConsts.githubIcon,
              onTap: () {},
            ),
            gapH8,
          ],
        ),
        gapW8,
        Container(
          width: 1,
          height: 626,
          decoration: const BoxDecoration(
            color: AppColors.dividerDark,
          ),
        ),
      ],
    );
  }
}
