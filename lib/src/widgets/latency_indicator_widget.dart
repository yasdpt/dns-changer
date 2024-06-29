import 'package:dns_changer/src/util/app_util.dart';
import 'package:flutter/material.dart';

class LatencyIndicatorWidget extends StatelessWidget {
  const LatencyIndicatorWidget({super.key, required this.latency});

  final num latency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 2,
            height: 6,
            color: AppUtil.getLatencyColor(latency),
          ),
          if (latency <= 200 && latency > 0)
            Container(
              width: 2,
              height: 8,
              color: AppUtil.getLatencyColor(latency),
              margin: const EdgeInsetsDirectional.only(start: 2),
            ),
          if (latency <= 70 && latency > 0)
            Container(
              width: 2,
              height: 10,
              margin: const EdgeInsetsDirectional.only(start: 2),
              color: AppUtil.getLatencyColor(latency),
            )
        ],
      ),
    );
  }
}
