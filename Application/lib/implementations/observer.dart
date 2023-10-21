import 'package:domain/models/observer_call.dart';
import 'package:infrastructure/interfaces/iobserver.dart';

class Observer implements IObserver {
  late List<ObserverCall> _observers;

  Observer() {
    _observers = [];
  }

  @override
  subscribe<T>(String callbackLocation, Function fn, {T? data}) {
    _observers.add(ObserverCall(name: callbackLocation, fn: fn, data: data));
  }

  @override
  dispose(String callbackLocation) {
    var exits = _observers.any((element) => element.name == callbackLocation);
    if (exits) {
      var getObserver = _observers
          .where((element) => element.name == callbackLocation)
          .toList();
      getObserver.forEach((element) {
        _observers.remove(element);
      });
    }
  }

  @override
  void getObserver(String callbackName, dynamic data) {
    _observers
        .where((element) => element.name == callbackName)
        .forEach((element) {
      if (data != null) {
        element.fn.call(data);
      } else {
        element.fn.call();
      }
    });
  }

  @override
  disposeAll() {
    _observers.clear();
  }
}
