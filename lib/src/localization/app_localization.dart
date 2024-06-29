import 'dart:convert';

import 'package:dns_changer/src/localization/language_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Language loader and delegator
class AppLocalization {
  AppLocalization({
    required this.locale,
  });

  final Locale locale;

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  late Map<String, String> _localizedValues;

  Future<void> load() async {
    final String jsonStringValues = await rootBundle
        .loadString('assets/language/${locale.languageCode}.json');
    final Map<String, dynamic> mappedJson =
        json.decode(jsonStringValues) as Map<String, dynamic>;
    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String? translate(String key) {
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      _DemoLocalizationsDelegate();
}

class _DemoLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalization> {
  const _DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final List<String?> languageString = [];
    for (final language in LanguageConfig.appLanguages) {
      languageString.add(language.languageCode);
    }
    return languageString.contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    final AppLocalization localization = AppLocalization(locale: locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
