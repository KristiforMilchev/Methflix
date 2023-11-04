import 'package:domain/models/categorie.dart';
import 'package:domain/models/movie.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/movie_thumbnail/movie_thumbnail.dart';
import 'package:presentation/components/tv_show_caraousel/tv_show_caraousel_viewmodel.dart';
import 'package:stacked/stacked.dart';

class TvShowCaraousel extends StatelessWidget {
  final int rowindex;
  final int globalRowIndex;
  final int globalColumnIndex;
  final Category category;
  final ScrollController horizontal;
  final ScrollController vertical;

  const TvShowCaraousel({
    super.key,
    required this.rowindex,
    required this.globalRowIndex,
    required this.category,
    required this.globalColumnIndex,
    required this.horizontal,
    required this.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => TvShowCaraouselViewModel(context),
      builder: (context, viewModel, child) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(rowindex.toString()),
            Text(globalRowIndex.toString()),
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                category.name,
                style: ThemeStyles.regularHeading,
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3.5,
              child: Container(
                child: ListView.builder(
                  itemCount: category.shows.length,
                  scrollDirection: Axis.horizontal,
                  controller: horizontal,
                  itemBuilder: (context, index) => MovieThumbnail(
                    selected: index == globalColumnIndex &&
                        rowindex == globalRowIndex,
                    movie: Movie(
                      id: -1,
                      thumbnail: category.shows[index].thumbnail.isEmpty
                          ? "season"
                          : category.shows[index].thumbnail,
                      name: category.shows[index].name,
                      length: Duration(),
                    ),
                    size: MediaQuery.of(context).size.width / 4.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
