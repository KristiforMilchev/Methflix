import 'package:domain/models/categorie.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/movie_carousel/movie_carosuel_viewmodel.dart';
import 'package:presentation/components/movie_thumbnail/movie_thumbnail.dart';
import 'package:stacked/stacked.dart';

class MovieCarosuel extends StatelessWidget {
  final int rowindex;
  final int globalRowIndex;
  final int globalColumnIndex;
  final Category category;
  final ScrollController horizontal;
  final ScrollController vertical;
  const MovieCarosuel({
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
    print("Row Selected ${rowindex} ${rowindex == globalRowIndex}");
    print("Global Column ${globalColumnIndex}");

    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MovieCarosuelViewModel(context),
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
                  itemCount: category.movies.length,
                  scrollDirection: Axis.horizontal,
                  controller: horizontal,
                  itemBuilder: (context, index) => MovieThumbnail(
                    selected: index == globalColumnIndex &&
                        rowindex == globalRowIndex,
                    movie: category.movies[index],
                    size: category.movies.length < 3
                        ? MediaQuery.of(context).size.width / 2
                        : MediaQuery.of(context).size.width / 4.2,
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
