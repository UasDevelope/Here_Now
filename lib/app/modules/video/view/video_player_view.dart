import 'package:flutter/material.dart';
import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url;
  final String? title;

  const VideoPlayerScreen({
    super.key,
    required this.url,
    this.title,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late BetterPlayerController _betterPlayerController;
  bool _isFullscreen = false;
  bool _hasRequestedExit = false;
  bool _isVideoInitialized = false;
  bool _isPlaying = false;
  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  Future<void> _loadVideo() async {
    final file = await DefaultCacheManager().getSingleFile(widget.url);
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.file,
      file.path,
    );

    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: true,
        looping: true,
        fit: BoxFit.cover,
        fullScreenByDefault: true,
        expandToFill: true,
        autoDetectFullscreenDeviceOrientation: true,
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
        allowedScreenSleep: false,
        controlsConfiguration: const BetterPlayerControlsConfiguration(
          showControls: false,
        ),
        eventListener: (event) {
          if (event.betterPlayerEventType ==
              BetterPlayerEventType.openFullscreen) {
            _isFullscreen = true;
          } else if (event.betterPlayerEventType ==
              BetterPlayerEventType.progress) {
            _isFullscreen = false;
            if (_hasRequestedExit) {
              Get.back();
              _hasRequestedExit = false;
            }
          } else if (event.betterPlayerEventType ==
              BetterPlayerEventType.initialized) {
            setState(() {
              _isVideoInitialized = true;
              _isPlaying = true;
            });
            _betterPlayerController.play();
          }
        },
      ),
      betterPlayerDataSource: dataSource,
    );
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_isFullscreen) {
          _hasRequestedExit = true;
          _betterPlayerController.exitFullScreen();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: _isVideoInitialized
                    ? GestureDetector(
                        onTap: () {
                          if (_isPlaying) {
                            _betterPlayerController.pause();
                          } else {
                            _betterPlayerController.play();
                          }
                          setState(() {
                            _isPlaying = !_isPlaying;
                          });
                        },
                        child: BetterPlayer(
                          controller: _betterPlayerController,
                        ),
                      )
                    : _buildLoadingIndicator(),
              ),
              if (!_isPlaying && _isVideoInitialized) _buildCenterPlayButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0F2027),
            Color(0xFF203A43),
            Color(0xFF2C5364),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.2),
                blurRadius: 15,
                spreadRadius: 5,
              ),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(
              strokeWidth: 4,
              color: Colors.cyanAccent,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCenterPlayButton() {
    return Positioned.fill(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black45,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(
            Icons.play_arrow_rounded,
            size: 60,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
