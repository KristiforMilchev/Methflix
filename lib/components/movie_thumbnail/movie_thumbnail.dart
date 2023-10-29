import 'package:domain/models/movie.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/movie_thumbnail/movie_thumbnail_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MovieThumbnail extends StatelessWidget {
  final Movie movie;
  final bool selected;
  final double? size;
  const MovieThumbnail(
      {super.key, required this.movie, this.selected = false, this.size});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MovieThumbnailViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(movie, selected),
      builder: (context, viewModel, child) => Visibility(
          visible: selected && viewModel.shouldPlay,
          replacement: Container(
            decoration: selected
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: ThemeStyles.secondaryColor,
                      style: BorderStyle.solid,
                      width: 5,
                    ),
                  )
                : null,
            margin: selected ? EdgeInsets.all(5) : null,
            width: size,
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(12), // Match the border radius
              clipBehavior: Clip.hardEdge,
              child: Stack(
                children: [
                  Image.memory(
                    viewModel.thumbnail,
                    fit: BoxFit.fill,
                    width: ThemeStyles.height,
                    height: ThemeStyles.height,
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: ThemeStyles.darkBtnSolid,
                      child: Text(
                        movie.name,
                        style: TextStyle(
                          color: ThemeStyles.secondAccent,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          child: Placeholder()),
    );
  }
}
