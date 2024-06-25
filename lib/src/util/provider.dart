import 'dart:io';

import 'package:dns_changer/src/util/dns_util.dart';
import 'package:dns_changer/src/util/dns_util_linux_impl.dart';
import 'package:dns_changer/src/util/dns_util_windows_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'provider.g.dart';

@riverpod
DNSUtil myDNSUtil(MyDNSUtilRef _) {
  if (Platform.isLinux) return DNSUtilLinuxImpl();

  return DNSUtilWindowsImpl();
}

@Riverpod(keepAlive: true)
Future<SharedPreferences> prefs(PrefsRef _) {
  return SharedPreferences.getInstance();
}
