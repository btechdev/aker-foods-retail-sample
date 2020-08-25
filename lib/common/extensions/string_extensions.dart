extension StringExtensions on String {
  bool get hasOnlyWhitespaces => trim().isEmpty && isNotEmpty;

  bool get isNullOrEmpty {
    if (this == null) {
      return true;
    }
    return trim().isEmpty;
  }

  bool get isNotNullAndEmpty => this != null && trim().isNotEmpty;

  String toSpaceSeparated() {
    final value =
        replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ');
    return value;
  }

  String capitalizeToFirst() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String splitLongStringForLogging() {
    return splitMapJoin(
      RegExp('.{1000}'),
      onMatch: (match) => '${match.group(0)}',
      onNonMatch: (last) => '\n$last',
    );
  }
}
