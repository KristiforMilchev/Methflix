import 'package:domain/exceptions/base_exception.dart';
import 'package:flutter/material.dart';

class WrongInputException implements BaseException {
  @override
  String? title = "Page validation error";

  @override
  String? message = "Wrong input.";

  @override
  StackTrace? stackTrace;

  @override
  BuildContext context;

  WrongInputException({required this.context});
}
