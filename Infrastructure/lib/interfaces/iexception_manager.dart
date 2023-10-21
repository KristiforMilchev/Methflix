import 'package:domain/exceptions/base_exception.dart';

abstract class IExceptionManager {
  Future raisePopup(BaseException exception);
  void logException(BaseException exception);
}
