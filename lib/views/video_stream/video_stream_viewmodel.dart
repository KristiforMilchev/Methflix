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
    // Initial video URL
    var initialUri = Uri(
      scheme: "http",
      host: "192.168.0.108",
      path: "dwad",
      port: 5000,
    );

    _controller = VideoPlayerController.networkUrl(initialUri);

    _controller.addListener(() {
      // Check if the video has reached the end.
      if (_controller.value.position >= _controller.value.duration) {
        // Load and play the next video chunk.
        loadNextChunk();
      }
    });

    // Initialize the video controller and start playing.
    await _controller.initialize();
    await _controller.setVolume(1);
    await _controller.play();

    notifyListeners();
  }

// Function to load and play the next video chunk.
  loadNextChunk() async {
    var nextChunkUri = Uri(
      scheme: "http",
      host: "192.168.0.108",
      path: "next_chunk", // Replace with the correct path for the next chunk
      port: 5000,
    );

    await _controller.pause();
    _controller = VideoPlayerController.networkUrl(nextChunkUri);
    await _controller.initialize();
    await _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
