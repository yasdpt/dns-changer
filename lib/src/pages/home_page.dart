import 'package:dns_changer/src/util/app_consts.dart';
import 'package:dns_changer/src/widgets/app_header_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppConsts.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const AppHeaderWidget(),
            Expanded(
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
