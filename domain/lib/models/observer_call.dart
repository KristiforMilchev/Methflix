class ObserverCall<T> {
  String name;
  Function fn;
  T? data;

  ObserverCall({required this.name, required this.fn, this.data});
}
