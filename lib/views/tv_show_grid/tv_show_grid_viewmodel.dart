import 'package:domain/models/enums.dart';
import 'package:domain/models/movie.dart';
import 'package:domain/models/season_data.dart';
import 'package:domain/models/transition_data.dart';
import 'package:domain/models/tv_show.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infrastructure/interfaces/ivideo_stream_service.dart';
import 'package:presentation/components/movie_thumbnail/movie_thumbnail.dart';
import 'package:presentation/page_view_model.dart';

class TvShowGridViewModel extends PageViewModel {
  late TvShow _tvShow;
  TvShow get tvShow => _tvShow;
  late IVideoStreamService _streamService;
  List<SeasonData> _seasonData = [];
  List<SeasonData> get seasonsData => _seasonData;

  int _rowIndex = 0;
  int get rowIndex => _rowIndex;

  int _columnIndex = 1;
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

  int _selectedMovie = 0;

  bool _missingImage = false;
  bool get missingImage => _missingImage;
  Uint8List _thumbnail = Uint8List(1);
  Uint8List get thumbnail => _thumbnail;

  ready() async {
    _streamService = getIt.get<IVideoStreamService>();
    _tvShow = router.getPageBindingData() as TvShow;
    var tvSeason = await _streamService.getSeasonData(_tvShow.id);
    if (tvSeason == null) return;
    _seasonData = tvSeason.seasons;
    _selectedMovie = tvSeason.seasons.first.movies.first.id;

    _seasonData.map((e) {
      for (int i = 0; i < e.movies.length; i += 4) {
        _movieRows++;
      }
    }).toList();
    _node.requestFocus();

    notifyListeners();
  }

  onRowChanged(RawKeyEvent value) {
    if (value is RawKeyDownEvent) return;

    if (value.logicalKey.keyLabel == "Arrow Down" ||
        value.logicalKey.keyLabel == "Arrow Up") {
      onMoveVertical(value.logicalKey.keyLabel);
      scrollToNextRow(_activeRow);
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
      router.changePage(
        "/video-player",
        pageContext,
        TransitionData(next: PageTransition.easeInAndOut),
        bindingData: _selectedMovie,
      );
    }

    if (value.logicalKey.keyLabel == "Go Back") {
      router.backToPrevious(pageContext);
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

      if (_columnIndex >= 5) {
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
      var r = 0;
      var rowSelected = rowIndex == current;

      movies.add(Container(
        margin: rowSelected
            ? EdgeInsets.fromLTRB(0, 10, 0, 35)
            : EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Row(children: [
          ...e.movies.skip(i).take(4).map((m) {
            print(rowSelected);
            r = r + 1;
            _activeRow = r;
            var select = rowSelected && columnIndex == r;
            if (select) {
              _selectedMovie = m.id;
            }
            return MovieThumbnail(
              selected: select,
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

  void scrollToNextRow(int currentRowIndex) async {
    if (_rowIndex == -1) {
      // Scroll to the next row
      await _scrollController.animateTo(
        0,
        duration: Duration(seconds: 1),
        curve: Curves.ease,
      );
      return;
    }

    if (_rowIndex < _movieRows - 1) {
      // Calculate the Y-offset of the next row
      double nextRowOffset = currentRowIndex * (ThemeStyles.height!);

      // Scroll to the next row
      await _scrollController.animateTo(
        nextRowOffset + 40,
        duration: Duration(seconds: 1),
        curve: Curves.ease,
      );
    }
  }
}
