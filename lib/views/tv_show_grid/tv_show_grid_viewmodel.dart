import 'package:domain/models/movie.dart';
import 'package:domain/models/season_data.dart';
import 'package:domain/models/tv_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infrastructure/interfaces/ivideo_stream_service.dart';
import 'package:presentation/components/movie_thumbnail/movie_thumbnail.dart';
import 'package:presentation/page_view_model.dart';

class TvShowGridViewModel extends PageViewModel {
  late TvShow _tvShow;
  late IVideoStreamService _streamService;
  List<SeasonData> _seasonData = [];
  List<SeasonData> get seasonsData => _seasonData;

  int _rowIndex = 0;
  int get rowIndex => _rowIndex;

  int _columnIndex = 0;
  int get columnIndex => _columnIndex;

  FocusNode _node = FocusNode();
  get focusNode => _node;

  ScrollController _scrollController = ScrollController();
  get scrollController => _scrollController;

  ScrollController _horizontalController = ScrollController();
  get horizontalController => _horizontalController;

  TvShowGridViewModel(super.context);

  int _movieRows = 0;
  int get movieRows => _movieRows;

  int _activeRow = 0;
  int get activeRow => _activeRow;

  ready() async {
    _streamService = getIt.get<IVideoStreamService>();
    _tvShow = router.getPageBindingData() as TvShow;
    var tvSeason = await _streamService.getSeasonData(_tvShow.id);
    if (tvSeason == null) return;
    _node.requestFocus();
    _seasonData = tvSeason.seasons;
    _seasonData.map((e) {
      for (int i = 0; i < e.movies.length; i += 4) {
        _movieRows++;
      }
    }).toList();

    notifyListeners();
  }

  onRowChanged(RawKeyEvent value) {
    if (value is RawKeyDownEvent) return;

    if (value.logicalKey.keyLabel == "Arrow Down" ||
        value.logicalKey.keyLabel == "Arrow Up") {
      _columnIndex = 0;
      onMoveVertical(value.logicalKey.keyLabel);
      if (_rowIndex != -1) onMoveHorizontal("Arrow Left");
      notifyListeners();
      return;
    }

    if (value.logicalKey.keyLabel == "Arrow Right" ||
        value.logicalKey.keyLabel == "Arrow Left") {
      //print(_columnIndex);

      onMoveHorizontal(value.logicalKey.keyLabel);
      notifyListeners();
    }

    if (value.logicalKey.keyLabel == "Select") {
      notifyListeners();
    }
  }

  void onMoveVertical(String keyLabel) {
    if (keyLabel == "Arrow Up" && _rowIndex - 1 >= -1) {
      _rowIndex--;
    } else if (_rowIndex + 1 < _movieRows && keyLabel == "Arrow Down")
      _rowIndex++;

    var current = _rowIndex;
  }

  void onMoveHorizontal(String keyLabel) {
    if (keyLabel == "Arrow Left") {
      if (_columnIndex > 0) {
        _columnIndex--;
      }
    } else if (keyLabel == "Arrow Right") {
      if (_columnIndex <= 4) {
        _columnIndex++;
      }

      if (_columnIndex >= 4) {
        _columnIndex = 0;
      }
    }
  }

  getMovie(SeasonData e) {
    var movies = [];
    var totalInSeason = e.movies.length;
    var currentRows = [];
    var current = 0;
    for (var i = 0; i < totalInSeason; i = i + 4) {
      currentRows.add(current);

      print("Row Index ${rowIndex} this row ${current} ");

      movies.add(Container(
        padding: null,
        child: Row(children: [
          ...e.movies.skip(i).take(4).map((m) {
            var rowSelected = rowIndex == current;

            print(rowSelected);
            return MovieThumbnail(
              selected: rowSelected && columnIndex == e.movies.indexOf(m),
              movie: Movie(
                id: m.id,
                thumbnail: "movie",
                name: m.name,
                length: Duration(),
              ),
            );
          })
        ]),
      ));
      current++;
    }

    return movies;
  }
}
