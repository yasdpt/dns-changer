import 'package:dns_changer/src/controllers/page_controller.dart';
import 'package:dns_changer/src/util/app_consts.dart';
import 'package:dns_changer/src/styles/app_sizes.dart';
import 'package:dns_changer/src/util/app_util.dart';
import 'package:dns_changer/src/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SideBarWidget extends ConsumerWidget {
  const SideBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(pageControllerProvider);

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
                    isSelected: currentPage == 0,
                    onTap: () =>
                        ref.read(pageControllerProvider.notifier).setPage(0),
                  ),
                  gapH8,
                  IconWidget(
                    icon: AppConsts.settingsIcon,
                    isSelected: currentPage == 1,
                    onTap: () =>
                        ref.read(pageControllerProvider.notifier).setPage(1),
                  ),
                  gapH8,
                  IconWidget(
                    icon: AppConsts.infoIcon,
                    isSelected: currentPage == 2,
                    onTap: () =>
                        ref.read(pageControllerProvider.notifier).setPage(2),
                  ),
                ],
              ),
            ),
            IconWidget(
              icon: AppConsts.githubIcon,
              color: Theme.of(context).textTheme.bodySmall?.color,
              onTap: () => AppUtil.launchGithubUrl(),
            ),
            gapH8,
          ],
        ),
        gapW8,
        Container(
          width: 1,
          height: 653,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
