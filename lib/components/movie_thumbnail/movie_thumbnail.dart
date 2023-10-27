import 'package:domain/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/movie_thumbnail/movie_thumbnail_viewmodel.dart';
import 'package:presentation/views/video_stream/video_stream_view.dart';
import 'package:stacked/stacked.dart';

class MovieThumbnail extends StatelessWidget {
  final Movie movie;
  final bool selected;
  const MovieThumbnail({super.key, required this.movie, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MovieThumbnailViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(movie, selected),
      builder: (context, viewModel, child) => Visibility(
        visible: !viewModel.isSelected,
        child: Stack(
          children: [
            Image.memory(viewModel.movieThumnail),
          ],
        ),
        replacement: VideoStreamView(
          name: movie.name,
        ),
      ),
    );
  }
}
