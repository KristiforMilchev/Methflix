import 'package:domain/exceptions/base_exception.dart';
import 'package:flutter/widgets.dart';

class UndefinedNameException implements BaseException {
  @override
  BuildContext context;

  @override
  String? message = "The field name is required";

  @override
  StackTrace? stackTrace;

  @override
  String? title = "Validation error";

  UndefinedNameException({required this.context});
}
