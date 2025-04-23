import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/video_player_cntroller.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String url;

  const VideoPlayerScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VideoController(url));

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: [
              Colors.teal.shade700,
              Colors.blueGrey.shade900,
              Colors.black,
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  _buildAppBar(context, controller),
                  Expanded(
                    child: Obx(
                      () => controller.isLoading.value
                          ? _buildLoadingIndicator()
                          : controller.chewieController != null
                              ? _buildVideoPlayer(controller)
                              : _buildErrorWidget(),
                    ),
                  ),
                ],
              ),
              _buildOverlayDecoration(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, VideoController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.tealAccent,
              size: 28,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.fullscreen,
              color: Colors.tealAccent,
              size: 28,
            ),
            onPressed: () {
              if (controller.chewieController != null) {
                controller.chewieController!.enterFullScreen();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.tealAccent),
          strokeWidth: 3,
        ),
      ),
    );
  }

  Widget _buildVideoPlayer(VideoController controller) {
    return AnimatedScale(
      scale: 1.0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withOpacity(0.4),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Chewie(controller: controller.chewieController!),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.error_outline,
          color: Colors.tealAccent.withOpacity(0.8),
          size: 56,
        ),
      ),
    );
  }

  Widget _buildOverlayDecoration() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topCenter,
              radius: 2.0,
              colors: [
                Colors.tealAccent.withOpacity(0.1),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
