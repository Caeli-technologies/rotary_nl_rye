import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class NativeVideo extends StatefulWidget {
  final String url;

  NativeVideo({required this.url});

  @override
  _NativeVideoState createState() => _NativeVideoState();
}

class _NativeVideoState extends State<NativeVideo> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  double _aspectRatio = 16 / 9;

  @override
  void initState() {
    super.initState();
    try {
      _videoPlayerController = VideoPlayerController.network(widget.url);
      _chewieController = ChewieController(
        allowedScreenSleep: false,
        allowFullScreen: true,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
        videoPlayerController: _videoPlayerController,
        aspectRatio: _aspectRatio,
        autoInitialize: true,
        autoPlay: false,
        showControls: true,
      );
      _chewieController.addListener(() {
        if (_chewieController.isFullScreen) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeRight,
            DeviceOrientation.landscapeLeft,
          ]);
        } else {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
        }
      });
    } catch (e) {}
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _videoPlayerController.dispose();
    _chewieController.dispose();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
      height: 220,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
}
