import 'package:domain/models/movie.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/components/movie_thumbnail/movie_thumbnail_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MovieThumbnail extends StatelessWidget {
  final Movie movie;
  final bool selected;
  final double? size;

  const MovieThumbnail({
    super.key,
    required this.movie,
    this.selected = false,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MovieThumbnailViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(movie, selected),
      builder: (context, viewModel, child) {
        return Visibility(
          visible: selected && viewModel.shouldPlay,
          replacement: Container(
            margin: selected
                ? EdgeInsets.fromLTRB(5, 0, 45, 0)
                : EdgeInsets.fromLTRB(5, 0, 0, 0),
            width: size,
            child: Container(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOutBack,
                transform: Matrix4.identity()..scale(selected ? 1.2 : 1.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      Visibility(
                        visible: !viewModel.missingImage,
                        child: Container(
                          child: Image.memory(
                            viewModel.thumbnail,
                            fit: BoxFit.fill,
                            width: ThemeStyles.height,
                            height: ThemeStyles.height,
                          ),
                        ),
                        replacement: Container(
                          width: ThemeStyles.width! / 4.5,
                          color: ThemeStyles.background300,
                          padding: EdgeInsets.all(60),
                          child: Center(
                            child: SvgPicture.asset(
                              "packages/domain/assets/images/${movie.thumbnail}.svg",
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          color: ThemeStyles.background200,
                          child: Text(
                            movie.name,
                            style: TextStyle(
                              color: selected
                                  ? ThemeStyles.accent100
                                  : ThemeStyles.text200,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          child: Placeholder(),
        );
      },
    );
  }
}
