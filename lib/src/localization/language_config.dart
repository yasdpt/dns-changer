import 'package:dns_changer/src/localization/app_localization.dart';
import 'package:dns_changer/src/models/language_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// List of language in app
// change [appLocales] and [appLanguages] to add a new one.
class LanguageConfig {
  static const Iterable<LocalizationsDelegate<dynamic>> localizationDelegates =
      [
    AppLocalization.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  // Change this list when adding new languages
  static const Iterable<Locale> appLocales = [
    Locale("en"),
  ];

  // Change this list when adding new languages
  static List<LanguageModel> appLanguages = [
    LanguageModel(
      languageName: 'English',
      countryCode: 'US',
      languageCode: 'en',
    ),
  ];
}
