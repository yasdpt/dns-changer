import 'package:dns_changer/src/styles/app_sizes.dart';
import 'package:dns_changer/src/styles/text_styles.dart';
import 'package:dns_changer/src/util/app_consts.dart';
import 'package:dns_changer/src/widgets/icon_widget.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        gapH16,
        Image.asset(
          AppConsts.logoPNG,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
        gapH16,
        Text(
          "Open-Source multiplatform DNS Changer",
          style: Theme.of(context).textTheme.bodyMedium?.bold,
        ),
        gapH8,
        Text(
          "Version ${AppConsts.appVersion}",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        gapH8,
        IconWidget(
          icon: AppConsts.githubIcon,
          color: Theme.of(context).textTheme.bodySmall?.color,
          onTap: () {},
        ),
      ],
    );
  }
}
