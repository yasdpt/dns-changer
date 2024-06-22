import 'package:dns_changer/src/util/app_consts.dart';
import 'package:flutter/material.dart';

// Custom UI for [DropdownButton] by wrapping it with [Container]
class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });
  final String value;
  final List<String> items;
  final Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConsts.borderRadius),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.arrow_drop_down_rounded),
          elevation: 0,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontFamily: AppConsts.fontFamily,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(
            AppConsts.borderRadius,
          ),
          dropdownColor: Theme.of(context).colorScheme.surface,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: AppConsts.fontFamily,
                  color: Colors.black,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
