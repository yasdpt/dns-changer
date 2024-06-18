import 'package:flutter/material.dart';

import 'package:dns_changer/src/util/app_consts.dart';
import 'package:dns_changer/src/widgets/app_header_widget.dart';
import 'package:dns_changer/src/util/dns_util.dart';
import 'package:dns_changer/src/widgets/custom_dropdown_button.dart';
import 'package:dns_changer/src/util/app_sizes.dart';
import 'package:dns_changer/src/util/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _adapters = [""];

  String _selectedAdapter = "";

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      _populateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          image: const DecorationImage(
            image: AssetImage(AppConsts.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const AppHeaderWidget(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 8.0),
                    child: Text(
                      "Select network adapter",
                      style: TextStyles.large.white.bold,
                    ),
                  ),
                  gapH8,
                  CustomDropdownButton(
                    value: _selectedAdapter,
                    items: _adapters,
                    onChanged: (value) {
                      setState(() {
                        _selectedAdapter = value ?? "";
                      });
                    },
                  ),
                  gapH16,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _populateData() async {
    final adapters = await DNSUtil.getInterfaceNames();

    setState(() {
      _adapters.clear();
      _adapters.addAll(adapters);
      _selectedAdapter = _adapters.first;
    });
  }
}
