import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/video_player_cntroller.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String url;

  const VideoPlayerScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VideoController controller = Get.put(VideoController(url));

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 28.0,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: GetBuilder<VideoController>(
        builder: (_) {
          if (_.chewieController != null &&
              _.chewieController!.videoPlayerController.value.isInitialized) {
            // Get the video's aspect ratio
            final videoAspectRatio =
                _.chewieController!.videoPlayerController.value.aspectRatio;

            return Center(
              child: AspectRatio(
                aspectRatio: videoAspectRatio,
                child: Chewie(controller: _.chewieController!),
              ),
            );
          } else {
            return const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.tealAccent),
                  strokeWidth: 4,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
