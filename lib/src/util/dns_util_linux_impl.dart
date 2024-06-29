import 'dart:io';

import 'package:dns_changer/src/models/network_interface_model.dart';
import 'package:dns_changer/src/util/dns_util.dart';

class DNSUtilLinuxImpl implements DNSUtil {
  // Get network interfaces string
  @override
  Future<String> getNetworkInterfacesRaw() async => "";

  // Extract list of network interfaces
  @override
  Future<List<NetworkInterfaceModel>> getNetworkInterfacesList() async => [];

  @override
  Future<List<String?>> getCurrentDNSServers({String interface = ""}) async {
    final result = await Process.run(
      'grep',
      ['nameserver', '/etc/resolv.conf', '|', 'awk', "'{print", "\$2}'"],
    );

    if ((result.stdout as String).isEmpty) {
      return [];
    }

    final ipPattern = RegExp(r'\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b');
    final ipMatches = ipPattern.allMatches(result.stdout);
    final ips = ipMatches.map((match) => match.group(0)).toList();

    return ips;
  }

  @override
  Future<void> setDNS(
    String interface,
    String primary,
    String secondary,
  ) async {
    await Process.run(
      'sudo',
      [
        'sh',
        '-c',
        '''echo "nameserver $primary
nameserver $secondary" > /etc/resolv.conf'''
      ],
    );

    await Process.run('systemctl', ['restart', 'systemd-networkd']);
  }

  // Delete dns records
  @override
  Future<void> clearDNS(String interface) async => await setDNS(
        interface,
        "8.8.8.8",
        "8.8.4.4",
      );

  // Flush dns
  @override
  Future<void> flushDNS() async => await Process.run('ipconfig', ['/flushdns']);

  @override
  Future<String> ping(String server) async {
    final result = await Process.run('ping', [server, '-c', '1']);

    if (result.stdout != "") {
      final regExp = RegExp(r"time=(?:(\d+) ms)|(?:(\d+\.\d+) ms)");
      final match = regExp.firstMatch(result.stdout);

      return match?.group(1) ?? match?.group(2) ?? "-1";
    }

    return "-1";
  }
}
