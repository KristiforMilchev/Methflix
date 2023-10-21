import 'package:stacked/stacked.dart';

class CustomButtonViewModel extends BaseViewModel {
  double _opacity = 1;
  double get opacity => _opacity;
  onButtonPressed(Function callback) {
    _opacity = 0.5;
    notifyListeners();
    Future.delayed(
      Duration(milliseconds: 100),
      () {
        _opacity = 1;
        notifyListeners();
        callback.call();
      },
    );
  }
}
