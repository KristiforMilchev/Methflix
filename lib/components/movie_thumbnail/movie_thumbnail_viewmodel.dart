import 'dart:convert';
import 'dart:typed_data';

import 'package:domain/models/movie.dart';
import 'package:presentation/page_view_model.dart';

class MovieThumbnailViewModel extends PageViewModel {
  late Movie _movie;

  bool _isSelected = false;
  bool get isSelected => _isSelected;

  Uint8List _movieThumbnail = Uint8List(2);
  Uint8List get movieThumnail => _movieThumbnail;
  MovieThumbnailViewModel(super.context);
  ready(Movie movie, bool initialSelected) {
    _isSelected = initialSelected;

    observer.subscribe("on_movie_selected", movieSelected);
    _movie = movie;
    _movieThumbnail = Uint8List.fromList(base64.decode(movie.thumbnail));
  }

  movieSelected() {
    _isSelected = true;
    notifyListeners();
  }
}
