import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  ChewieController? chewieController;
  final String url;
  var isLoading = true.obs;

  VideoController(this.url) {
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      final videoPlayerController = VideoPlayerController.network(
        url,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      await videoPlayerController.initialize();
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoInitialize: true,
        showControlsOnInitialize: false,
        autoPlay: true,
        aspectRatio: videoPlayerController.value.aspectRatio,
        allowFullScreen: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.tealAccent,
          handleColor: Colors.white,
          backgroundColor: Colors.grey.withOpacity(0.3),
          bufferedColor: Colors.white54,
        ),
        customControls: const MaterialControls(),
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
        errorBuilder: (context, errorMessage) => Center(
          child: Icon(
            Icons.error_outline,
            color: Colors.white.withOpacity(0.7),
            size: 48,
          ),
        ),
      );
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
    }
  }

  @override
  void onClose() {
    chewieController?.videoPlayerController.dispose();
    chewieController?.dispose();
    super.onClose();
  }
}
