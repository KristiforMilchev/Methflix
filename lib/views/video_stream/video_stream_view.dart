import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:presentation/views/video_stream/video_stream_viewmodel.dart';
import 'package:show_fps/show_fps.dart';
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
                ? Stack(
                    children: [
                      RawKeyboardListener(
                          focusNode: viewModel.node,
                          child: Container(),
                          onKey: viewModel.onKeypressed),
                      if (viewModel.videoPlayerController != null)
                        VlcPlayer(
                          controller: viewModel.videoPlayerController,
                          aspectRatio: 16 / 9,
                          virtualDisplay: true,
                        ),
                      Positioned(
                        top: 0,
                        child: ShowFPS(
                          alignment: Alignment.topRight,
                          visible: true,
                          showChart: false,
                          borderRadius: BorderRadius.all(Radius.circular(11)),
                          child: Container(),
                        ),
                      )
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: ThemeStyles.accent100,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
