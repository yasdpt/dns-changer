class AppUtil {
  static final _whitespaceRE = RegExp(r"\s+");
  static String cleanupWhitespace(String input) =>
      input.replaceAll(_whitespaceRE, " ");
}
