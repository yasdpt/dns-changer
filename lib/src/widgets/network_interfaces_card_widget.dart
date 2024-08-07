import 'dart:io';

import 'package:dns_changer/src/controllers/interface_controller.dart';
import 'package:dns_changer/src/localization/language_constraints.dart';
import 'package:dns_changer/src/models/network_interface_model.dart';
import 'package:dns_changer/src/util/app_consts.dart';
import 'package:dns_changer/src/styles/app_sizes.dart';
import 'package:dns_changer/src/util/dns_util.dart';
import 'package:dns_changer/src/styles/text_styles.dart';
import 'package:dns_changer/src/util/provider.dart';
import 'package:dns_changer/src/widgets/custom_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NetworkInterfacesCardWidget extends ConsumerWidget {
  const NetworkInterfacesCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DNSUtil dnsUtil = ref.read(myDNSUtilProvider);

    return Container(
      width: 322.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(AppConsts.borderRadius),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Platform.isWindows ? _CardWindows(dnsUtil) : _CardLinux(dnsUtil),
    );
  }
}

class _CardWindows extends ConsumerStatefulWidget {
  const _CardWindows(this.dnsUtil);
  final DNSUtil dnsUtil;
  @override
  ConsumerState<_CardWindows> createState() => _CardWindowsState();
}

class _CardWindowsState extends ConsumerState<_CardWindows> {
  final List<NetworkInterfaceModel> _interfaces = [
    const NetworkInterfaceModel()
  ];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      _populateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedInterface = ref.watch(interfaceControllerProvider);

    ref.listen(interfaceControllerProvider, (prev, next) {
      _reloadListOfNetworkInterfaces();
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 8.0),
          child: Text(
            translate('selectNetworkInterface', context),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        gapH8,
        CustomDropdownButton(
          value: selectedInterface.name,
          items: _interfaces.map((element) => element.name).toList(),
          onChanged: (value) {
            ref
                .read(interfaceControllerProvider.notifier)
                .setCurrentInterface(_interfaces.firstWhere(
                  (inteface) => inteface.name == value,
                ));
          },
        ),
        gapH16,
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${translate('adminState', context)}:",
                        style: Theme.of(context).textTheme.bodyMedium?.medium,
                      ),
                      gapH8,
                      Text(
                        "${translate('state', context)}:",
                        style: Theme.of(context).textTheme.bodyMedium?.medium,
                      ),
                      gapH8,
                      Text(
                        "${translate('type', context)}:",
                        style: Theme.of(context).textTheme.bodyMedium?.medium,
                      ),
                      gapH8,
                      Text(
                        "${translate('dnsServers', context)}:",
                        style: Theme.of(context).textTheme.bodyMedium?.medium,
                      )
                    ],
                  ),
                  gapW8,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedInterface.adminState,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      gapH12,
                      Text(
                        selectedInterface.state,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      gapH12,
                      Text(
                        selectedInterface.type,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      gapH12,
                      Text(
                        selectedInterface.dnsServers.isEmpty
                            ? translate('configuredThroughDHCP', context)
                            : selectedInterface.dnsServers,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _populateData() async {
    final interfaces = await widget.dnsUtil.getNetworkInterfacesList();

    setState(() {
      _interfaces.clear();
      _interfaces.addAll(interfaces);
      ref
          .read(interfaceControllerProvider.notifier)
          .setCurrentInterface(_interfaces.first);
    });
  }

  Future<void> _reloadListOfNetworkInterfaces() async {
    final interfaces = await widget.dnsUtil.getNetworkInterfacesList();

    _interfaces.clear();
    _interfaces.addAll(interfaces);
  }
}

class _CardLinux extends ConsumerStatefulWidget {
  const _CardLinux(this.dnsUtil);

  final DNSUtil dnsUtil;

  @override
  ConsumerState<_CardLinux> createState() => _CardLinuxState();
}

class _CardLinuxState extends ConsumerState<_CardLinux> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      _populateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentNetworkInterface = ref.watch(interfaceControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 8.0),
          child: Text(
            translate('networkInfo', context),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 8.0),
          child: Column(
            children: [
              gapH12,
              Row(
                children: [
                  Text(
                    "${translate('dnsServers', context)}:",
                    style: Theme.of(context).textTheme.bodyMedium?.medium,
                  ),
                  gapW8,
                  Text(
                    currentNetworkInterface.dnsServers,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              gapH8,
            ],
          ),
        ),
      ],
    );
  }

  void _populateData() async {
    final configuredThroughDHCPText =
        translate('configuredThroughDHCP', context);

    final currentDNSServers = await widget.dnsUtil.getCurrentDNSServers();

    ref.read(interfaceControllerProvider.notifier).setCurrentInterface(
          NetworkInterfaceModel(
            dnsServers: currentDNSServers.isEmpty
                ? configuredThroughDHCPText
                : currentDNSServers.join(", ").trim(),
          ),
        );
  }
}
