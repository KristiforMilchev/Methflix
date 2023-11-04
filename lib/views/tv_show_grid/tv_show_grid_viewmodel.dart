import 'package:domain/models/season_data.dart';
import 'package:domain/models/tv_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infrastructure/interfaces/ivideo_stream_service.dart';
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

  int movieRow = 1;

  ready() async {
    _streamService = getIt.get<IVideoStreamService>();
    _tvShow = router.getPageBindingData() as TvShow;
    var tvSeason = await _streamService.getSeasonData(_tvShow.id);
    if (tvSeason == null) return;

    _seasonData = tvSeason.seasons;
    notifyListeners();
  }

  onRowChanged(RawKeyEvent value) {
    if (value is RawKeyDownEvent) return;

    if (value.logicalKey.keyLabel == "Arrow Down" ||
        value.logicalKey.keyLabel == "Arrow Up") {
      _columnIndex = 0;
      onMoveVertical(value.logicalKey.keyLabel);
      if (_rowIndex != -1) onMoveHorizontal("Arrow Left");

      return;
    }

    if (_rowIndex == -1 && value.logicalKey.keyLabel == "Arrow Right") {
      _columnIndex++;
      notifyListeners();
      return;
    }

    if (_rowIndex == -1 && value.logicalKey.keyLabel == "Arrow Left") {
      _columnIndex--;
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
    } else if (_rowIndex + 1 < _seasonData.length && keyLabel == "Arrow Down")
      _rowIndex++;
  }

  void onMoveHorizontal(String keyLabel) {
    if (keyLabel == "Arrow Left") {
      if (_columnIndex > 0) {
        _columnIndex--;
      }
    } else if (keyLabel == "Arrow Right") {
      if (_columnIndex < _seasonData[_rowIndex].movies.length - 1) {
        _columnIndex++;
      }
    }
  }
}
