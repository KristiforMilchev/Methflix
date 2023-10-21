import 'package:flutter/material.dart';
import 'package:presentation/page_view_model.dart';
import 'package:video_player/video_player.dart';

class VideoStreamViewModel extends PageViewModel {
  Widget _activeScreen = Placeholder();
  Widget get activeScreen => _activeScreen;

  String _videoUrl = "http://localhost:5107/dwad";
  String get videoUrl => _videoUrl;

  late VideoPlayerController _controller;
  VideoPlayerController get controller => _controller;
  VideoStreamViewModel(super.context);

  ready() async {
    var uri = Uri(
      scheme: "http",
      host: "192.168.0.108",
      path: "dwad",
      port: 5000,
    );

    _controller = VideoPlayerController.networkUrl(uri)
      ..initialize().then((_) async {
        await _controller.play();
        await _controller.setVolume(1);
        notifyListeners();
      });
  }
}
