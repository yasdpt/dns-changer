import 'package:dns_changer/src/styles/app_sizes.dart';
import 'package:dns_changer/src/widgets/dns_servers_card_widget.dart';
import 'package:dns_changer/src/widgets/network_interfaces_card_widget.dart';
import 'package:flutter/material.dart';

class DNSPage extends StatelessWidget {
  const DNSPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        gapH12,
        NetworkInterfacesCardWidget(),
        gapH12,
        DNSServersCardWidget(),
      ],
    );
  }
}
