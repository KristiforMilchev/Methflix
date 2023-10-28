import 'dart:async';

import 'package:domain/models/categorie.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:domain/exceptions/failed_initialization.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infrastructure/interfaces/ivideo_stream_service.dart';
import 'package:presentation/page_view_model.dart';

class DashboardViewModel extends PageViewModel {
  late IVideoStreamService _videoStreamService;
  List<Category> _movieLists = [];
  List<Category> get movieLists => _movieLists;

  (Category? e, int movie) _previousSelection = (null, 0);
  int _rowIndex = 0;
  int get rowIndex => _rowIndex;

  int _columnIndex = 0;
  int get columnIndex => _columnIndex;

  DashboardViewModel(super.context);

  FocusNode _node = FocusNode();
  get focusNode => _node;

  ScrollController _scrollController = ScrollController();
  get scrollController => _scrollController;

  ScrollController _horizontalController = ScrollController();
  get horizontalController => _horizontalController;

  ready() async {
    try {
      _node.requestFocus();
      _videoStreamService = getIt.get<IVideoStreamService>();
      _movieLists = await _videoStreamService.getAllCategories();
      Timer.periodic(Duration(seconds: 1), (timer) async {
        _node.requestFocus();
      });

      notifyListeners();
    } catch (ex) {
      var res = ex as Exception;
      throw FailedInitialization(context: pageContext, message: res.toString());
    }
  }

  onRowChanged(Category e, RawKeyEvent value) {
    if (value is RawKeyDownEvent) return;

    if (value.logicalKey.keyLabel == "Arrow Down" ||
        value.logicalKey.keyLabel == "Arrow Up") {
      _columnIndex = 1;
      onMoveVertical(e, value.logicalKey.keyLabel);

      return;
    }

    if (value.logicalKey.keyLabel == "Arrow Right" ||
        value.logicalKey.keyLabel == "Arrow Left") {
      onMoveHorizontal(e, value.logicalKey.keyLabel);
    }

    if (value.logicalKey.keyLabel == "Select") {
      playMovie();
    }
  }

  onMoveVertical(Category e, String value) {
    if (value == "Arrow Up" && _rowIndex - 1 >= 0)
      _rowIndex--;
    else if (_rowIndex + 1 < _movieLists.length && value == "Arrow Down")
      _rowIndex++;
    notifyListeners();

    _node = FocusNode();
    _node.requestFocus();
    int selectedIndex = _movieLists.indexOf(e);
    double itemHeight = ThemeStyles.height! / 3; // Height of each item

// Calculate the vertical scroll position to keep the selected row visible
    double viewportHeight = MediaQuery.of(pageContext).size.height;
    double scrollPosition = selectedIndex * itemHeight - (viewportHeight / 3);

// Ensure the scroll position doesn't go below 0
    scrollPosition =
        scrollPosition.clamp(0.0, (itemHeight * (_movieLists.length - 1)));

// You may want to round to an integer value
    _scrollController.animateTo(
      scrollPosition, // Vertical position
      duration: Duration(milliseconds: 600), // Animation duration
      curve: Curves.easeInOut, // Animation curve
    );
  }

  void onMoveHorizontal(Category e, String value) {
    if (value == "Arrow Left") {
      if (_columnIndex > 0) {
        _columnIndex--;
      }
    } else if (value == "Arrow Right") {
      if (_columnIndex < e.movies.length - 1) {
        _columnIndex++;
      }
    }

    double itemWidth = ThemeStyles.width! / 3; // Width of each item
    double scrollPosition = itemWidth * _columnIndex;

    _horizontalController.animateTo(
      scrollPosition,
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );

    observer.getObserver("on_movie_selected", e.movies[_columnIndex]);

    notifyListeners();
  }

  void playMovie() {
    router.changePage(
      "/video-player",
      pageContext,
      TransitionData(next: PageTransition.easeInAndOut),
      bindingData: _movieLists[_rowIndex].movies[_columnIndex].id,
    );
  }
}
