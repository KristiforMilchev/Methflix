import 'enums.dart';

class TransitionData<T> {
  PageTransition next;
  T? data;
  String? caller;

  TransitionData({
    required this.next,
    this.data,
    this.caller,
  });
}
