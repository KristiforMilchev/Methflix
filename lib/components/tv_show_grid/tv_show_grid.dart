import 'package:domain/models/movie.dart';
import 'package:domain/models/tv_show.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/movie_thumbnail/movie_thumbnail.dart';
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
      viewModelBuilder: () => TvShowGridViewModel(context, tvShow),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Column(
        children: viewModel.seasonsData.map((e) {
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
                    padding: i < 4 ? null : EdgeInsets.fromLTRB(0, 35, 0, 0),
                    child: Row(
                      children: season.movies.skip(i).take(4).map(
                        (movie) {
                          return MovieThumbnail(
                            selected: season.movies.indexOf(movie) ==
                                    globalColumnIndex &&
                                rowindex == globalRowIndex,
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
        }).toList(),
      ),
    );
  }
}
