import 'package:flutter/material.dart';
import 'package:presentation/views/video_stream/video_stream_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class VideoStreamView extends StatelessWidget {
  const VideoStreamView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => VideoStreamViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Material(
        color: Color.fromARGB(255, 16, 32, 61),
        child: Container(
          child: SafeArea(
            child: viewModel.controller.value.isInitialized
                ? VideoPlayer(viewModel.controller)
                : CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
