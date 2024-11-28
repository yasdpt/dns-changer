import 'package:dns_changer/src/controllers/dns_provider_controller.dart';
import 'package:dns_changer/src/controllers/interface_controller.dart';
import 'package:dns_changer/src/localization/language_constraints.dart';
import 'package:dns_changer/src/styles/app_sizes.dart';
import 'package:dns_changer/src/util/app_util.dart';
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
  bool _setDNSLoading = false;

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
          onSetDNS: () async => await _setDNS(configuredThroughDHCPText),
          onClearDNS: () async => await _clearDNS(configuredThroughDHCPText),
          onFlushDNS: () async => await _flushDNS(),
          setDNSLoading: _setDNSLoading,
        ),
      ],
    );
  }

  Future<void> _setDNS(String configuredThroughDHCPText) async {
    setState(() {
      _setDNSLoading = true;
    });
    final currentNetworkInterface = ref.read(interfaceControllerProvider);
    final currentDNSProvider = ref.read(dNSProviderControllerProvider);

    // Set DNS
    await _dnsUtil?.setDNS(
      currentNetworkInterface.name,
      currentDNSProvider.primary,
      currentDNSProvider.secondary,
    );

    final dnsServers = await _dnsUtil?.getCurrentDNSServers(
        interface: currentNetworkInterface.name);

    setState(() {
      _setDNSLoading = false;
    });
    // Update current interface with new dns
    ref.read(interfaceControllerProvider.notifier).setCurrentInterface(
          currentNetworkInterface.copyWith(
            dnsServers:
                dnsServers?.join(", ").trim() ?? configuredThroughDHCPText,
            ipv6Enabled: currentNetworkInterface.ipv6Enabled,
          ),
        );

    // ignore: use_build_context_synchronously
    AppUtil.showSnackBar(context, message: "DNS Successfuly set");
  }

  Future<void> _clearDNS(String configuredThroughDHCPText) async {
    final currentNetworkInterface = ref.read(interfaceControllerProvider);

    await _dnsUtil?.clearDNS(ref.read(interfaceControllerProvider).name);

    // Update current interface with new dns
    ref.read(interfaceControllerProvider.notifier).setCurrentInterface(
          currentNetworkInterface.copyWith(
            dnsServers: configuredThroughDHCPText,
            ipv6Enabled: currentNetworkInterface.ipv6Enabled,
          ),
        );
    // ignore: use_build_context_synchronously
    AppUtil.showSnackBar(context, message: "DNS Successfuly cleared");
  }

  Future<void> _flushDNS() async {
    await _dnsUtil?.flushDNS();

    // ignore: use_build_context_synchronously
    AppUtil.showSnackBar(context, message: "DNS Successfuly flushed");
  }
}
