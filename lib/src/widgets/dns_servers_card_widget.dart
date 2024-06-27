import 'package:clipboard/clipboard.dart';
import 'package:dns_changer/src/controllers/dns_provider_controller.dart';
import 'package:dns_changer/src/models/dns_provider_model.dart';
import 'package:dns_changer/src/styles/app_sizes.dart';
import 'package:dns_changer/src/styles/text_styles.dart';
import 'package:dns_changer/src/util/app_consts.dart';
import 'package:dns_changer/src/util/dns_util.dart';
import 'package:dns_changer/src/util/provider.dart';
import 'package:dns_changer/src/widgets/custom_dropdown_button.dart';
import 'package:dns_changer/src/widgets/icon_widget.dart';
import 'package:dns_changer/src/widgets/latency_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DNSServersCardWidget extends ConsumerStatefulWidget {
  const DNSServersCardWidget({super.key});

  @override
  ConsumerState<DNSServersCardWidget> createState() =>
      _DNSServersCardWidgetState();
}

class _DNSServersCardWidgetState extends ConsumerState<DNSServersCardWidget> {
  DNSUtil? dnsUtil;

  String _currentPing = "-1";

  @override
  void initState() {
    super.initState();

    dnsUtil = ref.read(myDNSUtilProvider);

    Future.delayed(Duration.zero, () {
      _populateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedDNSProvider = ref.watch(dNSProviderControllerProvider);

    return Container(
      width: 322.0,
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
              "Select DNS Server",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          gapH8,
          CustomDropdownButton(
            value: selectedDNSProvider.name,
            items: AppConsts.myDNSProviders
                .map((element) => element.name)
                .toList(),
            onChanged: (value) {
              ref
                  .read(dNSProviderControllerProvider.notifier)
                  .setCurrentDNSProvider(AppConsts.myDNSProviders.firstWhere(
                    (inteface) => inteface.name == value,
                  ));

              _populateData(selectedDNSProvider: selectedDNSProvider);
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
                      "Provider name:",
                      style: Theme.of(context).textTheme.bodyMedium?.medium,
                    ),
                    gapW8,
                    Text(
                      selectedDNSProvider.name,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                gapH8,
                Row(
                  children: [
                    const SizedBox(width: 45),
                    Text(
                      "Latency:",
                      style: Theme.of(context).textTheme.bodyMedium?.medium,
                    ),
                    gapW8,
                    LatencyIndicatorWidget(latency: num.parse(_currentPing)),
                    gapW8,
                    Text("$_currentPing ms"),
                    gapW4,
                    IconWidget(
                      icon: AppConsts.updateIcon,
                      size: 24.0,
                      onTap: () => _populateData(
                        selectedDNSProvider: selectedDNSProvider,
                      ),
                    ),
                  ],
                ),
                gapH8,
                Row(
                  children: [
                    const SizedBox(width: 3),
                    Text(
                      "DNS Server #1:",
                      style: Theme.of(context).textTheme.bodyMedium?.medium,
                    ),
                    gapW8,
                    Text(
                      selectedDNSProvider.primary,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    gapW4,
                    IconWidget(
                      icon: AppConsts.copyIcon,
                      size: 24.0,
                      onTap: () async {
                        await FlutterClipboard.copy(
                          selectedDNSProvider.primary,
                        );
                      },
                    ),
                  ],
                ),
                gapH8,
                Row(
                  children: [
                    const SizedBox(width: 3),
                    Text(
                      "DNS Server #2:",
                      style: Theme.of(context).textTheme.bodyMedium?.medium,
                    ),
                    gapW8,
                    Text(
                      selectedDNSProvider.secondary,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    gapW4,
                    IconWidget(
                      icon: AppConsts.copyIcon,
                      size: 24.0,
                      onTap: () async {
                        await FlutterClipboard.copy(
                          selectedDNSProvider.secondary,
                        );
                      },
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

  void _populateData({DNSProviderModel? selectedDNSProvider}) async {
    final ping = await dnsUtil?.ping(
      selectedDNSProvider?.primary ?? AppConsts.myDNSProviders.first.primary,
    );

    setState(() {
      _currentPing = ping ?? "N/A";
    });
  }
}
