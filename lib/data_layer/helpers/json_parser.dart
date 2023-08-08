/// Convenience class for handling JSONs
class JsonParser {
  /// Parses a [String] into a [double].
  static double? parseDouble(String? value) => double.tryParse(value ?? '');

  /// Parses a [String] into an [int].
  static int? parseInt(String? value) => int.tryParse(value ?? '');

  /// Parses a [String] into a [DateTime].
  static DateTime? parseDate(String? value) => DateTime.tryParse(value ?? '');
}
