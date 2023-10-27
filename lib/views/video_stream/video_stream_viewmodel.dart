import 'package:domain/models/app_config.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/interfaces/iconfiguration.dart';
import 'package:infrastructure/interfaces/ivideo_stream_service.dart';
import 'package:presentation/page_view_model.dart';
import 'package:video_player/video_player.dart';

class VideoStreamViewModel extends PageViewModel {
  late IVideoStreamService _videoStreamService;
  late AppConfig _config;
  Widget _activeScreen = Placeholder();
  Widget get activeScreen => _activeScreen;

  String _videoUrl = "http://localhost:5107/dwad";
  String get videoUrl => _videoUrl;

  late VideoPlayerController _controller;
  VideoPlayerController get controller => _controller;
  VideoStreamViewModel(super.context);

  ready(String name) async {
    _videoStreamService = getIt.get<IVideoStreamService>();
    var configuration = getIt.get<IConfiguration>();
    _config = await configuration.getConfig();

    if (name.isEmpty) {
      name = router.getPageBindingData() as String;
    }

    // Initial video URL
    var initialUri = Uri(
      scheme: _config.schema,
      host: _config.ip,
      path: "/v1/video/download/",
      port: _config.port,
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
      scheme: _config.schema,
      host: _config.ip,
      path: "next_chunk", // Replace with the correct path for the next chunk
      port: _config.port,
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
