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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
