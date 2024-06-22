import 'package:dns_changer/src/models/network_interface_model.dart';
import 'package:dns_changer/src/util/app_consts.dart';
import 'package:dns_changer/src/styles/app_sizes.dart';
import 'package:dns_changer/src/util/dns_util.dart';
import 'package:dns_changer/src/styles/text_styles.dart';
import 'package:dns_changer/src/widgets/custom_dropdown_button.dart';
import 'package:flutter/material.dart';

class NetworkInterfacesCardWidget extends StatefulWidget {
  const NetworkInterfacesCardWidget({super.key});

  @override
  State<NetworkInterfacesCardWidget> createState() =>
      _NetworkInterfacesCardWidgetState();
}

class _NetworkInterfacesCardWidgetState
    extends State<NetworkInterfacesCardWidget> {
  final List<NetworkInterfaceModel> _interfaces = [NetworkInterfaceModel()];

  NetworkInterfaceModel _selectedInterface = NetworkInterfaceModel();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      _populateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(AppConsts.borderRadius),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 8.0),
            child: Text(
              "Select network interface",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          gapH8,
          CustomDropdownButton(
            value: _selectedInterface.name,
            items: _interfaces.map((element) => element.name).toList(),
            onChanged: (value) {
              setState(() {
                _selectedInterface = _interfaces.firstWhere(
                  (inteface) => inteface.name == value,
                );
              });
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
                    gapW2,
                    Text(
                      "Admin state:",
                      style: Theme.of(context).textTheme.bodyMedium?.medium,
                    ),
                    gapW8,
                    Text(
                      _selectedInterface.adminState,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                gapH8,
                Row(
                  children: [
                    const SizedBox(width: 45),
                    Text(
                      "State:",
                      style: Theme.of(context).textTheme.bodyMedium?.medium,
                    ),
                    gapW8,
                    Text(
                      _selectedInterface.state,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                gapH8,
                Row(
                  children: [
                    const SizedBox(width: 48),
                    Text(
                      "Type:",
                      style: Theme.of(context).textTheme.bodyMedium?.medium,
                    ),
                    gapW8,
                    Text(
                      _selectedInterface.type,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                gapH8,
                Row(
                  children: [
                    Text(
                      "DNS Servers:",
                      style: Theme.of(context).textTheme.bodyMedium?.medium,
                    ),
                    gapW8,
                    Text(
                      _selectedInterface.dnsServers,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                gapH8,
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _populateData() async {
    final interfaces = await DNSUtil.getInterfaceNames();

    setState(() {
      _interfaces.clear();
      _interfaces.addAll(interfaces);
      _selectedInterface = _interfaces.first;
    });
  }
}
