import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/movie_thumbnail/movie_thumbnail.dart';
import 'package:presentation/views/dashboard/dashboard_viewmodel.dart';
import 'package:show_fps/show_fps.dart';
import 'package:stacked/stacked.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ThemeStyles.mainColor,
      child: ViewModelBuilder.reactive(
        viewModelBuilder: () => DashboardViewModel(context),
        onViewModelReady: (viewModel) => viewModel.ready(),
        builder: (context, viewModel, child) => SingleChildScrollView(
          controller: viewModel.scrollController,
          child: Stack(
            children: [
              Column(
                children: viewModel.movieLists
                    .map(
                      (e) => Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                e.name,
                                style: TextStyle(
                                  color: ThemeStyles.acentColor,
                                  fontSize: 30,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 2.5,
                              child: viewModel.rowIndex ==
                                      viewModel.movieLists.indexOf(e)
                                  ? Container(
                                      child: RawKeyboardListener(
                                        focusNode: viewModel.focusNode,
                                        onKey: (value) =>
                                            viewModel.onRowChanged(e, value),
                                        child: ListView.builder(
                                          itemCount: e.movies.length,
                                          scrollDirection: Axis.horizontal,
                                          controller:
                                              viewModel.horizontalController,
                                          itemBuilder: (context, index) =>
                                              MovieThumbnail(
                                            selected:
                                                index == viewModel.columnIndex,
                                            movie: e.movies[index],
                                            size: e.movies.length < 3
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.2,
                                          ),
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: e.movies.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          Placeholder(),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
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
