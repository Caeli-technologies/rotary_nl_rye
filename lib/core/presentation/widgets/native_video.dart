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
  //TODO this needs to be fixed
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  double _aspectRatio = 16 / 9;
  bool isSwitchedFT = false;

  bool _loading = true;

  Future<void> _loadPrefs() async {
    loadSharedPreferencesAndSwitchState().then((_) {
      loadVideo();
    });
    setState(() => _loading = false);
  }

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
    _loading = true;
  }

  loadVideo() {
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
        autoInitialize: isSwitchedFT,
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

  loadSharedPreferencesAndSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSwitchedFT = prefs.getBool("autoInitializeState")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading == true
        ? CircularProgressIndicator()
        : Container(
            //margin: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            height: 220,
            child: Chewie(
              controller: _chewieController,
            ),
          );
  }
}
