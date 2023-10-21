abstract class IObserver {
  subscribe<T>(String callbackLocation, Function fn, {T? data});
  void getObserver(String callbackName, dynamic data);
  dispose(String callbackLocation);
  disposeAll();
}
