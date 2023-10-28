import 'package:domain/exceptions/base_exception.dart';
import 'package:flutter/material.dart';

class FailedInitialization implements BaseException {
  @override
  BuildContext context;

  @override
  String? message;

  @override
  StackTrace? stackTrace;

  @override
  String? title;

  FailedInitialization({
    required this.context,
    this.message,
  });
}
