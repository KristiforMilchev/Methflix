import 'dart:async';

import 'package:domain/models/categorie.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presentation/page_view_model.dart';

class DashboardViewModel extends PageViewModel {
  List<Category> _movieLists = [];
  List<Category> get movieLists => _movieLists;

  (Category? e, int movie) _previousSelection = (null, 0);
  int _rowIndex = 0;
  int get rowIndex => _rowIndex;

  DashboardViewModel(super.context);

  FocusNode _node = FocusNode();
  get focusNode => _node;

  ScrollController _scrollController = ScrollController();
  get scrollController => _scrollController;

  ready() {
    _node.requestFocus();
    _movieLists.add(Category(id: 1, name: "Recent", movies: [
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
    ]));
    _movieLists.add(Category(id: 2, name: "Favorite", movies: [
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
    ]));
    _movieLists.add(Category(id: 2, name: "Newly added", movies: [
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
    ]));
    _movieLists.add(Category(id: 2, name: "Newly added", movies: [
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
    ]));
    _movieLists.add(Category(id: 2, name: "Newly added", movies: [
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
    ]));
    Timer.periodic(Duration(seconds: 500), (timer) {
      _node.requestFocus();
      notifyListeners();
    });
    notifyListeners();
  }

  onKeySelected(Category e, int index) {
    if (_previousSelection.$1 == null) {
      _movieLists.firstWhere((element) => element == e).movies[index] = true;
      _previousSelection = (e, index);
      notifyListeners();
    }

    _movieLists
        .firstWhere((element) => element == _previousSelection.$1)
        .movies[_previousSelection.$2] = false;
    _movieLists.firstWhere((element) => element == e).movies[index] = true;
    _previousSelection = (e, index);
    notifyListeners();
  }

  onRowChanged(Category e, RawKeyEvent value) {
    if (value is RawKeyDownEvent) return;

    if (value.logicalKey.keyLabel == "Arrow Down" ||
        value.logicalKey.keyLabel == "Arrow Up") {
      onMoveVertical(e, value.logicalKey.keyLabel);

      return;
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
}
