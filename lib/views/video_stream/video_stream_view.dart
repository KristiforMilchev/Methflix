import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:presentation/views/video_stream/video_stream_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class VideoStreamView extends StatelessWidget {
  final String name;
  const VideoStreamView({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => VideoStreamViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(name),
      builder: (context, viewModel, child) => Material(
        color: Color.fromARGB(255, 16, 32, 61),
        child: Container(
          child: SafeArea(
            child: viewModel.videoPlayerController != null
                ? VlcPlayer(
                    controller: viewModel.videoPlayerController,
                    aspectRatio: 16 / 9,
                    placeholder: Center(child: CircularProgressIndicator()),
                  )
                : CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
