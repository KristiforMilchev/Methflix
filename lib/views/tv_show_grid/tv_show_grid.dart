import 'package:domain/models/movie.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/movie_thumbnail/movie_thumbnail.dart';
import 'package:presentation/views/tv_show_grid/tv_show_grid_viewmodel.dart';
import 'package:stacked/stacked.dart';

class TvShowGrid extends StatelessWidget {
  const TvShowGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => TvShowGridViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Material(
        color: ThemeStyles.background100,
        child: SingleChildScrollView(
          child: RawKeyboardListener(
            focusNode: viewModel.focusNode,
            onKey: (value) => viewModel.onRowChanged(value),
            child: Column(
              children: viewModel.seasonsData.map(
                (e) {
                  var season = e;

                  return Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          "Season ${e.season}",
                          style: ThemeStyles.regularParagraphOv(
                            size: 18,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 6),
                        for (int i = 0; i < season.movies.length; i += 4)
                          Container(
                            padding:
                                i < 4 ? null : EdgeInsets.fromLTRB(0, 35, 0, 0),
                            child: Row(
                              children: season.movies.skip(i).take(4).map(
                                (movie) {
                                  return MovieThumbnail(
                                    selected: season.movies.indexOf(movie) ==
                                        viewModel.columnIndex,
                                    movie: Movie(
                                      id: movie.id,
                                      thumbnail: "movie",
                                      name: movie.name,
                                      length: Duration(),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
