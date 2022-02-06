import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rotary_nl_rye/core/domain/entities/story.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideo extends StatefulWidget {
  final Story story;

  FullScreenVideo({required this.story});
  @override
  _FullScreenVideoState createState() => _FullScreenVideoState(story: story);
}

class _FullScreenVideoState extends State<FullScreenVideo> {
  final Story story;

  _FullScreenVideoState({required this.story});

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
    _videoPlayerController = VideoPlayerController.network(story.video);
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
      isSwitchedFT = prefs.getBool('autoInitializeState') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12.withOpacity(0.8),
        appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: SizedBox.shrink(),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 10, top: 5),
                width: 40,
                height: 40,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
                child: RawMaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Icon(
                    Icons.close,
                    color: Palette.accentColor,
                    size: 30.0,
                  ),
                  shape: new CircleBorder(),
                  elevation: 2.0,
                  fillColor: Palette.themeShadeColor,
                  padding: const EdgeInsets.all(5.0),
                ),
              )
            ]),
        body: Center(
            heightFactor: 2.3,
            child: Container(
              margin: const EdgeInsets.all(5.0),
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.3,
              height: 235,
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
            )));
  }
}
