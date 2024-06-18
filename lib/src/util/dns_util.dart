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
}
