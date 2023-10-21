import 'package:collection/collection.dart';
import 'package:stacked/stacked.dart';

class PersistentViewModels {
  static List<(String, BaseViewModel)> _viewmodels = [];

  static dynamic getModel<T>(String name, BaseViewModel model) {
    var modelData =
        _viewmodels.firstWhereOrNull((element) => element.$1 == name);
    if (modelData != null) return modelData.$2;

    return null;
  }

  static dynamic setModel<T>(String name, BaseViewModel model) {
    _viewmodels.add((name, model));
    return model;
  }

  static updateStae(String name, BaseViewModel model) {
    _viewmodels.removeWhere((element) => element.$1 == name);
    _viewmodels.add((name, model));
  }
}
