import 'package:dns_changer/src/util/dns_util.dart';
import 'package:dns_changer/src/widgets/custom_dropdown_button.dart';
import 'package:flutter/material.dart';

import 'package:dns_changer/src/util/app_consts.dart';
import 'package:dns_changer/src/widgets/app_header_widget.dart';

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
                children: [
                  CustomDropdownButton(
                    value: _selectedAdapter,
                    items: _adapters,
                    onChanged: (value) {
                      setState(() {
                        _selectedAdapter = value ?? "";
                      });
                    },
                  ),
                  const SizedBox(height: 18.0),
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
