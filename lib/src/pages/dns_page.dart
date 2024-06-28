import 'package:dns_changer/src/controllers/dns_provider_controller.dart';
import 'package:dns_changer/src/controllers/interface_controller.dart';
import 'package:dns_changer/src/localization/language_constraints.dart';
import 'package:dns_changer/src/styles/app_sizes.dart';
import 'package:dns_changer/src/util/dns_util.dart';
import 'package:dns_changer/src/util/provider.dart';
import 'package:dns_changer/src/widgets/dns_config_buttons_widget.dart';
import 'package:dns_changer/src/widgets/dns_servers_card_widget.dart';
import 'package:dns_changer/src/widgets/network_interfaces_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DNSPage extends ConsumerStatefulWidget {
  const DNSPage({super.key});

  @override
  ConsumerState<DNSPage> createState() => _DNSPageState();
}

class _DNSPageState extends ConsumerState<DNSPage> {
  DNSUtil? _dnsUtil;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      _dnsUtil = ref.read(myDNSUtilProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final configuredThroughDHCPText =
        translate("configuredThroughDHCP", context);

    return Column(
      children: [
        gapH12,
        const NetworkInterfacesCardWidget(),
        gapH12,
        const DNSServersCardWidget(),
        gapH12,
        DNSConfigButtonsWidget(
          onSetDNS: () async {
            final currentNetworkInterface =
                ref.read(interfaceControllerProvider);
            final currentDNSProvider = ref.read(dNSProviderControllerProvider);

            // Set DNS
            await _dnsUtil?.setDNS(
              currentNetworkInterface.name,
              currentDNSProvider.primary,
              currentDNSProvider.secondary,
            );

            final dnsServers = await _dnsUtil?.getCurrentDNSServers();

            // Update current interface with new dns
            ref.read(interfaceControllerProvider.notifier).setCurrentInterface(
                  currentNetworkInterface.copyWith(
                    dnsServers: dnsServers?.join(", ").trim() ??
                        configuredThroughDHCPText,
                  ),
                );
          },
          onClearDNS: () =>
              _dnsUtil?.clearDNS(ref.read(interfaceControllerProvider).name),
          onFlushDNS: () => _dnsUtil?.flushDNS(),
        ),
      ],
    );
  }
}
