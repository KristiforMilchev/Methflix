import 'package:domain/models/categorie.dart';
import 'package:domain/models/tv_show.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/tv_show_grid/tv_show_grid_viewmodel.dart';
import 'package:stacked/stacked.dart';

class TvShowGrid extends StatelessWidget {
  final int rowindex;
  final int globalRowIndex;
  final int globalColumnIndex;
  final TvShow tvShow;
  final ScrollController horizontal;
  final ScrollController vertical;
  const TvShowGrid({
    super.key,
    required this.rowindex,
    required this.globalRowIndex,
    required this.tvShow,
    required this.globalColumnIndex,
    required this.horizontal,
    required this.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => TvShowGridViewModel(context),
      builder: (context, viewModel, child) => Column(
        children: [],
      ),
    );
  }
}
