import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  ChewieController? _chewieController;
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        "https://cph-p2p-msl.akamaized.net/hls/live/2000341/test/master.m3u8"));

    _setupController(startAt: Duration.zero);

    super.initState();
  }

  _setupController({required Duration startAt}) async {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      startAt: startAt,
      autoPlay: false,
      autoInitialize: true,
      looping: false,
      fullScreenByDefault: false,
      allowFullScreen: true,
      hideControlsTimer: const Duration(seconds: 1),
      showControls: true,
      allowedScreenSleep: false,
      zoomAndPan: true,
      isLive: true,
      errorBuilder: (context, errorMessage) {
        return const Icon(Icons.error);
      },
    );
  }

  @override
  void dispose() {
    _chewieController?.videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Chewie(
            controller: _chewieController!,
          )),
    );
  }
}
