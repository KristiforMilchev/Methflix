import 'dart:async';

import 'package:domain/models/app_config.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:infrastructure/interfaces/iconfiguration.dart';
import 'package:infrastructure/interfaces/ivideo_stream_service.dart';
import 'package:presentation/page_view_model.dart';
import 'package:video_player/video_player.dart';

class VideoStreamViewModel extends PageViewModel {
  late IVideoStreamService _videoStreamService;
  late AppConfig _config;
  Widget _activeScreen = Placeholder();
  FocusNode _pageNode = FocusNode();
  FocusNode get node => _pageNode;
  VideoStreamViewModel(super.context);
  Widget get activeScreen => _activeScreen;

  late VideoPlayerController _controller;
  VideoPlayerController? get controller => _controller;
  VlcPlayerController? _videoPlayerController;

  get videoPlayerController => _videoPlayerController;

  ready(String name) async {
    var configuration = getIt.get<IConfiguration>();
    _config = await configuration.getConfig();
    _videoStreamService = getIt.get<IVideoStreamService>();
    var data = router.getPageBindingData() as int;
    _initializeController(data);
  }

  void _initializeController(int id) async {
    Timer.periodic(Duration(seconds: 1), (timer) {
      _pageNode.requestFocus();
    });
    _videoPlayerController = VlcPlayerController.network(
      "${_config.apiEndpoint}/api/v1/Video/stream/${id}",
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(
          video: VlcVideoOptions(["--drop-late-frames"]),
          rtp: VlcRtpOptions(["--rtsp-tcp"])),
    );
    await _videoPlayerController?.setVolume(100);
    await _videoPlayerController?.play();
    notifyListeners();
  }

  void onKeypressed(RawKeyEvent value) {
    if (value is RawKeyDownEvent) return;

    if (value.logicalKey.keyLabel == "Go Back") {
      router.changePage(
        "/dashboard",
        pageContext,
        TransitionData(next: PageTransition.slideBack),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
