import 'package:dns_changer/src/localization/language_constraints.dart';
import 'package:dns_changer/src/styles/app_colors.dart';
import 'package:dns_changer/src/styles/app_sizes.dart';
import 'package:dns_changer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';

class DNSConfigButtonsWidget extends StatelessWidget {
  const DNSConfigButtonsWidget({
    super.key,
    required this.onSetDNS,
    required this.onClearDNS,
    required this.onFlushDNS,
    this.setDNSLoading = false,
  });

  final VoidCallback onSetDNS;
  final VoidCallback onClearDNS;
  final VoidCallback onFlushDNS;
  final bool setDNSLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onSetDNS,
              style: ButtonStyle(
                fixedSize: WidgetStateProperty.all(
                  const Size(156, 42),
                ),
                backgroundColor: WidgetStateProperty.resolveWith(
                    (states) => Theme.of(context).colorScheme.secondary),
                side: WidgetStateProperty.resolveWith(
                  (states) => BorderSide(
                      color: Theme.of(context).textTheme.bodySmall?.color ??
                          Colors.white),
                ),
              ),
              child: setDNSLoading
                  ? SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                        strokeWidth: 2.0,
                      ),
                    )
                  : Text(
                      translate('setDNS', context),
                      style: Theme.of(context).textTheme.bodyMedium?.bold,
                    ),
            ),
            gapW12,
            ElevatedButton(
              onPressed: onClearDNS,
              style: ButtonStyle(
                fixedSize: WidgetStateProperty.all(
                  const Size(156, 42),
                ),
                backgroundColor:
                    WidgetStateProperty.resolveWith((states) => AppColors.red),
                side: WidgetStateProperty.resolveWith(
                  (states) => BorderSide(
                    color: Theme.of(context).textTheme.bodySmall?.color ??
                        Colors.white,
                  ),
                ),
              ),
              child: Text(
                translate('clearDNS', context),
                style: TextStyles.medium.white.bold,
              ),
            ),
          ],
        ),
        gapH12,
        ElevatedButton(
          onPressed: onFlushDNS,
          style: ButtonStyle(
            fixedSize: WidgetStateProperty.all(
              const Size(324, 42),
            ),
            backgroundColor: WidgetStateProperty.resolveWith((states) =>
                Theme.of(context).textTheme.bodySmall?.color ?? Colors.white),
          ),
          child: Text(
            translate('flushDNS', context),
            style: Theme.of(context).textTheme.bodyMedium?.bold.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
        ),
      ],
    );
  }
}
