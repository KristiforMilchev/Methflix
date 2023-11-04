import 'dart:convert';
import 'dart:typed_data';

import 'package:domain/models/movie.dart';
import 'package:presentation/page_view_model.dart';

class MovieThumbnailViewModel extends PageViewModel {
  late Movie _movie;

  bool _isSelected = false;
  bool get isSelected => _isSelected;

  MovieThumbnailViewModel(super.context);

  bool _shouldPlay = false;
  bool get shouldPlay => _shouldPlay;

  Uint8List _thumbnail = Uint8List(2);
  Uint8List get thumbnail => _thumbnail;
  bool _missingImage = false;
  bool get missingImage => _missingImage;

  ready(Movie movie, bool initialSelected) {
    _missingImage = movie.thumbnail == "movie" ? true : false;
    _missingImage = movie.thumbnail == "season" ? true : _missingImage;

    _isSelected = initialSelected;
    if (!_missingImage) _thumbnail = loadImage(movie);
    observer.subscribe("on_movie_selected", movieSelected);
    _movie = movie;
  }

  movieSelected(Movie current) {
    var newState = _isSelected;
    if (current.id == _movie.id) {
      newState = true;

      // Future.delayed(
      //   Duration(seconds: 3),
      //   () {
      //     _shouldPlay = _isSelected;
      //     notifyListeners();
      //   },
      // );
    } else {
      newState = false;
    }

    if (_isSelected != newState) {
      _isSelected = newState;
      notifyListeners();
    }
  }

  Uint8List loadImage(Movie movie) {
    return base64.decode(movie.thumbnail);
  }
}
