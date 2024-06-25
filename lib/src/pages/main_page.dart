import 'package:dns_changer/src/styles/app_sizes.dart';
import 'package:dns_changer/src/widgets/app_header_widget.dart';
import 'package:dns_changer/src/widgets/dns_servers_card_widget.dart';
import 'package:dns_changer/src/widgets/network_interfaces_card_widget.dart';
import 'package:dns_changer/src/widgets/side_bar_widget.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white, width: 0.5),
        ),
        child: const Column(
          children: [
            AppHeaderWidget(),
            Expanded(
              child: Row(
                children: [
                  SideBarWidget(),
                  gapW12,
                  Column(
                    children: [
                      gapH12,
                      NetworkInterfacesCardWidget(),
                      gapH12,
                      DNSServersCardWidget(),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
