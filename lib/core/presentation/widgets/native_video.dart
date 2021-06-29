import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class NativeVideo extends StatefulWidget {
  final String url;

  NativeVideo({required this.url});

  @override
  _NativeVideoState createState() => _NativeVideoState();
}

class _NativeVideoState extends State<NativeVideo> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  double _aspectRatio = 16 / 9;
  bool isSwitchedFT = false;

  Future<void> _loadPrefs() async {
    loadSharedPreferencesAndSwitchState().then((_) {
      loadVideo();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  void loadVideo() async {
    _videoPlayerController = VideoPlayerController.network(widget.url);
    await Future.wait([
      // _videoPlayerController.initialize(),
    ]);
    _chewieController = ChewieController(
      allowedScreenSleep: false,
      allowFullScreen: true,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
      videoPlayerController: _videoPlayerController,
      aspectRatio: _aspectRatio,
      autoInitialize: isSwitchedFT,
      autoPlay: false,
      showControls: true,
    );
    _chewieController!.addListener(() {
      if (_chewieController!.isFullScreen) {
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
    setState(() {});
  }

  Future<void> loadSharedPreferencesAndSwitchState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSwitchedFT = prefs.getBool("autoInitializeState") ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
      height: 220,
      child: _chewieController != null
          ? Chewie(
              controller: _chewieController!,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
              ],
            ),
    );
  }
}
