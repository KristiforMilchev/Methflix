import 'package:flutter/widgets.dart';

class BaseException implements Exception {
  String? title;
  String? message;
  StackTrace? stackTrace;
  BuildContext context;

  BaseException({
    this.title,
    this.message,
    this.stackTrace,
    required this.context,
  });
}
