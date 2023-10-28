import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:presentation/views/video_stream/video_stream_viewmodel.dart';
import 'package:show_fps/show_fps.dart';
import 'package:stacked/stacked.dart';

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
                      VlcPlayer(
                        controller: viewModel.videoPlayerController,
                        aspectRatio: 16 / 9,
                        virtualDisplay: true,
                        placeholder: Center(child: CircularProgressIndicator()),
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
                : CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
