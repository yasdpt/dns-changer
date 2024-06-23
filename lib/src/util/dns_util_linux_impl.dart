import 'dart:io';

import 'package:dns_changer/src/models/network_interface_model.dart';
import 'package:dns_changer/src/util/dns_util.dart';

class DNSUtilLinuxImpl implements DNSUtil {
  // Get network interfaces string
  @override
  Future<String> getNetworkInterfacesRaw() async {
    final result =
        await Process.run('netsh', ['interface', 'show', 'interface']);

    return result.stdout;
  }

  // Extract list of network interfaces
  @override
  Future<List<NetworkInterfaceModel>> getNetworkInterfacesList() async => [];

  @override
  Future<List<String?>> getCurrentDNSServers({String interface = ""}) async {
    final result = await Process.run(
        'netsh', ['interface', 'ip', 'show', 'dnsserver', '"$interface"']);

    if ((result.stdout as String)
        .contains("DNS servers configured through DHCP")) {
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
    // Set primary DNS
    await Process.run('netsh', [
      'interface',
      'ipv4',
      'add',
      'dns',
      '"$interface"',
      primary,
    ]);

    // Set secondary DNS
    await Process.run('netsh', [
      'interface',
      'ipv4',
      'add',
      'dns',
      '"$interface"',
      secondary,
      'index=2'
    ]);
  }

  // Delete dns records
  @override
  Future<void> clearDNS(String interface) async => await Process.run(
      'netsh', ['interface', 'ip', 'set', 'dns', '"$interface"', 'dhcp']);

  // Flush dns
  @override
  Future<void> flushDNS() async => await Process.run('ipconfig', ['/flushdns']);
}
