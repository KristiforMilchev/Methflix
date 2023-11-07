import 'dart:convert';

extension StringExtension on String {
  List<int> toByteList() {
    return utf8.encode(this);
  }
}
