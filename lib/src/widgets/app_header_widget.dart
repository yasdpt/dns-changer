import 'package:dns_changer/src/util/app_consts.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class AppHeaderWidget extends StatelessWidget {
  const AppHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: AppBar(
          title: const Text(
            AppConsts.appName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: AppConsts.fontFamily,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () async {
                await WindowManager.instance.close();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
