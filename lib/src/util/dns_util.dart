import 'dart:io';

class DNSUtil {
  // Get network adapters string
  static Future<String> getAdapters() async {
    final result =
        await Process.run('netsh', ['interface', 'show', 'interface']);

    return result.stdout;
  }

  // Extract list of network adapters
  static Future<List<String>> getInterfaceNames() async {
    final adapters = await getAdapters();

    final List<String> interfaceNames = [];
    final List<String> lines = adapters.trim().split('\n');

    for (var i = 2; i < lines.length; i++) {
      final line = cleanupWhitespace(lines[i]).split(" ");
      line.removeRange(0, 3);
      interfaceNames.add(line.join(" ").trim());
    }

    return interfaceNames;
  }

  static final _whitespaceRE = RegExp(r"\s+");
  static String cleanupWhitespace(String input) =>
      input.replaceAll(_whitespaceRE, " ");

  static Future<List<String?>> getCurrentDNSServers(String adapter) async {
    final result = await Process.run(
        'netsh', ['interface', 'ip', 'show', 'dnsserver', '"$adapter"']);

    if ((result.stdout as String)
        .contains("DNS servers configured through DHCP")) {
      return [];
    }

    final ipPattern = RegExp(r'\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b');
    final ipMatches = ipPattern.allMatches(result.stdout);
    final ips = ipMatches.map((match) => match.group(0)).toList();

    return ips;
  }

  static Future<void> setDNS(
    String adapter,
    String primary,
    String secondary,
  ) async {
    // Set primary DNS
    await Process.run('netsh', [
      'interface',
      'ipv4',
      'add',
      'dns',
      '"$adapter"',
      primary,
    ]);

    // Set secondary DNS
    await Process.run('netsh', [
      'interface',
      'ipv4',
      'add',
      'dns',
      '"$adapter"',
      secondary,
      'index=2'
    ]);

    // Flush dns
    await Process.run('ipconfig', ['/flushdns']);
  }

  // Delete dns records
  static Future<void> clearDns(String adapter) async => await Process.run(
      'netsh', ['interface', 'ip', 'set', 'dns', '"$adapter"', 'dhcp']);
}
