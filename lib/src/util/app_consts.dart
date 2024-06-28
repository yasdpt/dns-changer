import 'dart:io';

import 'package:dns_changer/src/models/dns_provider_model.dart';

class AppConsts {
  static const String appName = "DNS Changer";
  static const String appVersion = "1.0.0";
  static const String appGithubUrl = "https://github.com/yasdpt/dns-changer";
  static const String fontFamily = "Vazirmatn";
  static const double borderRadius = 12.0;

  static double appBorderRadius = Platform.isLinux ? 0.0 : 24.0;

  static const prefsThemeKey = "theme";
  static const prefsSystemTrayKey = "systemTrayEnabled";

  // Assets
  static const String icons = "assets/icons";
  static const String images = "assets/images";
  static const String copyIcon = "$icons/copy.png";
  static const String dnsIcon = "$icons/dns.png";
  static const String githubIcon = "$icons/github.png";
  static const String infoIcon = "$icons/info.png";
  static const String settingsIcon = "$icons/settings.png";
  static const String updateIcon = "$icons/update.png";
  static const String closeIcon = "$icons/close.png";
  static const String minimizeIcon = "$icons/minimize.png";
  static const String logoICO = "$images/logo.ico";
  static const String logoPNG = "$images/logo.png";

  static List<DNSProviderModel> myDNSProviders = [
    DNSProviderModel(
      name: "Electro",
      primary: "78.157.42.100",
      secondary: "78.157.42.101",
    ),
    DNSProviderModel(
      name: "403.online",
      primary: "10.202.10.202",
      secondary: "10.202.10.102",
    ),
    DNSProviderModel(
      name: "Radar game",
      primary: "10.202.10.10",
      secondary: "10.202.10.11",
    ),
    DNSProviderModel(
      name: "Shecan",
      primary: "178.22.122.100",
      secondary: "185.51.200.2",
    ),
    DNSProviderModel(
      name: "Google",
      primary: "8.8.8.8",
      secondary: "8.8.4.4",
    ),
    DNSProviderModel(
      name: "Cloudflare",
      primary: "1.1.1.1",
      secondary: "1.0.0.1",
    ),
  ];
}
