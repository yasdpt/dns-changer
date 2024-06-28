import 'package:dns_changer/src/localization/app_localization.dart';
import 'package:flutter/material.dart';

// Main translation function used
// returns "No word" if translation does not exist
String translate(String key, BuildContext context) {
  try {
    final text = AppLocalization.of(context)?.translate(key);
    if (text == null) return "No word";
    return text;
  } catch (e) {
    debugPrint(e.toString());
    return "Error";
  }
}
