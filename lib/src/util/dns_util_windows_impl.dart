import 'dart:io';

import 'package:dns_changer/src/models/network_interface_model.dart';
import 'package:dns_changer/src/util/app_util.dart';
import 'package:dns_changer/src/util/dns_util.dart';
import 'package:process_run/process_run.dart';

class DNSUtilWindowsImpl implements DNSUtil {
  // Get network interfaces string
  @override
  Future<String> getNetworkInterfacesRaw() async {
    final result =
        await Process.run('netsh', ['interface', 'show', 'interface']);

    return result.stdout;
  }

  // Extract list of network interfaces
  @override
  Future<List<NetworkInterfaceModel>> getNetworkInterfacesList() async {
    final networkInterfacesRaw = await getNetworkInterfacesRaw();

    final List<NetworkInterfaceModel> networkInterfaces = [];
    final List<String> lines = networkInterfacesRaw.trim().split('\n');

    for (var i = 2; i < lines.length; i++) {
      final line = AppUtil.cleanupWhitespace(lines[i]).trim().split(" ");

      final interfaceName = line.getRange(3, line.length).join(" ").trim();

      final dnsServers = await getCurrentDNSServers(interface: interfaceName);

      final networkInterface = NetworkInterfaceModel(
        name: interfaceName,
        adminState: line[0],
        state: line[1],
        type: line[2],
        dnsServers: dnsServers.join(", ").trim(),
      );

      networkInterfaces.add(networkInterface);
    }

    return networkInterfaces;
  }

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
    // Clear any DNS first
    await clearDNS(interface);

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

  @override
  Future<String> ping(String server) async {
    final result = await Process.run('ping', [server, '-n', '1']);

    if (result.stdout != "") {
      final regExp = RegExp(r"time=(\d+)ms");
      final match = regExp.firstMatch(result.stdout);

      return match?.group(1) ?? "-1";
    }

    return "-1";
  }

  @override
  Future<bool> isIPV6Enabled(String interface) async {
    final shell = Shell();
    final ipv6Status = await shell.run(
        "powershell -command 'Get-NetAdapterBinding -ComponentID ms_tcpip6'");

    bool isIPV6Enabled = false;

    if (ipv6Status.first.outText != "") {
      final String ipv6List = ipv6Status.first.outText;
      final List<String> lines = ipv6List.trim().split('\n');

      for (var line in lines) {
        if (line.contains(interface)) {
          line = AppUtil.cleanupWhitespace(line).trim();
          isIPV6Enabled = line.substring(line.length - 4) == "True";
        }
      }
    }

    return isIPV6Enabled;
  }

  @override
  Future<void> changeIPV6Status(String interface, bool enabled) async {
    final shell = Shell();

    await shell.run(
        "powershell -command '${enabled ? "Enable" : "Disable"}-NetAdapterBinding -Name '$interface' -ComponentID ms_tcpip6'");
  }
}
