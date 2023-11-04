import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/custom_button/custom_button.dart';
import 'package:presentation/components/movie_carousel/movie_carosuel.dart';
import 'package:presentation/components/tv_show_caraousel/tv_show_caraousel.dart';
import 'package:presentation/components/tv_show_grid/tv_show_grid.dart';
import 'package:presentation/views/dashboard/dashboard_viewmodel.dart';
import 'package:show_fps/show_fps.dart';
import 'package:stacked/stacked.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ThemeStyles.background100,
      child: ViewModelBuilder.reactive(
        viewModelBuilder: () => DashboardViewModel(context),
        onViewModelReady: (viewModel) => viewModel.ready(),
        builder: (context, viewModel, child) => SingleChildScrollView(
          controller: viewModel.scrollController,
          child: Stack(
            children: [
              RawKeyboardListener(
                focusNode: viewModel.focusNode,
                onKey: (value) => viewModel.onRowChanged(value),
                child: Column(
                  children: [
                    Container(
                      color: ThemeStyles.background200,
                      padding: EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            widget: Container(
                              padding: EdgeInsets.all(5),
                              decoration: viewModel.rowIndex == -1 &&
                                          viewModel.columnIndex == 0 ||
                                      viewModel.contentType
                                  ? BoxDecoration(
                                      color: ThemeStyles.background100,
                                      borderRadius: BorderRadius.circular(6),
                                    )
                                  : null,
                              child: Text(
                                "Movies",
                                style: ThemeStyles.regularParagraphOv(
                                  color: viewModel.contentType
                                      ? ThemeStyles.accent100
                                      : ThemeStyles.accent200,
                                ),
                              ),
                            ),
                            callback: () {},
                          ),
                          const SizedBox(width: 6),
                          CustomButton(
                            widget: Container(
                              padding: EdgeInsets.all(5),
                              decoration: viewModel.rowIndex == -1 &&
                                          viewModel.columnIndex == 1 ||
                                      !viewModel.contentType
                                  ? BoxDecoration(
                                      color: ThemeStyles.background100,
                                      borderRadius: BorderRadius.circular(6),
                                    )
                                  : null,
                              child: Text(
                                "Tv Shows",
                                style: ThemeStyles.regularParagraphOv(
                                  color: !viewModel.contentType
                                      ? ThemeStyles.accent100
                                      : ThemeStyles.accent200,
                                ),
                              ),
                            ),
                            callback: () {},
                          )
                        ],
                      ),
                    ),
                    if (!viewModel.seasonContentVisible)
                      ...viewModel.movieLists
                          .where(
                            (element) => viewModel.contentType
                                ? element.movies.isNotEmpty
                                : element.shows.isNotEmpty,
                          )
                          .map(
                            (e) => viewModel.contentType
                                ? MovieCarosuel(
                                    rowindex: viewModel.rowIndex,
                                    globalRowIndex:
                                        viewModel.movieLists.indexOf(e),
                                    category: e,
                                    globalColumnIndex: viewModel.columnIndex,
                                    horizontal: viewModel.horizontalController,
                                    vertical: viewModel.scrollController,
                                  )
                                : TvShowCaraousel(
                                    rowindex: viewModel.rowIndex,
                                    globalRowIndex:
                                        viewModel.movieLists.indexOf(e),
                                    category: e,
                                    globalColumnIndex: viewModel.columnIndex,
                                    horizontal: viewModel.horizontalController,
                                    vertical: viewModel.scrollController,
                                  ),
                          )
                          .toList(),
                    if (viewModel.seasonContentVisible)
                      TvShowGrid(
                        rowindex: viewModel.rowIndex,
                        globalRowIndex: 0,
                        tvShow: viewModel.tvShow,
                        globalColumnIndex: viewModel.columnIndex,
                        horizontal: viewModel.horizontalController,
                        vertical: viewModel.scrollController,
                      )
                  ],
                ),
              ),
              ShowFPS(
                alignment: Alignment.topRight,
                visible: true,
                showChart: false,
                borderRadius: BorderRadius.all(Radius.circular(11)),
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
