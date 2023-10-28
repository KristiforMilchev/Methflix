import 'package:domain/models/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:infrastructure/interfaces/iconfiguration.dart';
import 'package:infrastructure/interfaces/ivideo_stream_service.dart';
import 'package:presentation/page_view_model.dart';
import 'package:video_player/video_player.dart';

class VideoStreamViewModel extends PageViewModel {
  late IVideoStreamService _videoStreamService;
  late AppConfig _config;
  Widget _activeScreen = Placeholder();

  VideoStreamViewModel(super.context);
  Widget get activeScreen => _activeScreen;

  late VideoPlayerController _controller;
  VideoPlayerController? get controller => _controller;
  late VlcPlayerController _videoPlayerController;

  get videoPlayerController => _videoPlayerController;

  ready(String name) async {
    var configuration = getIt.get<IConfiguration>();
    _config = await configuration.getConfig();
    _videoStreamService = getIt.get<IVideoStreamService>();

    _initializeController();
  }

  void _initializeController() async {
    var url = Uri.parse("${_config.apiEndpoint}/api/v1/Video/stream/3");

    _videoPlayerController = VlcPlayerController.network(
      "${_config.apiEndpoint}/api/v1/Video/stream/3",
      hwAcc: HwAcc.auto,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );

    await _videoPlayerController.play();
    await _videoPlayerController.setVolume(100);
    notifyListeners();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
