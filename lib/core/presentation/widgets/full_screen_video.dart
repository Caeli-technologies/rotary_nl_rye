import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/stories/models/story.dart';
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
  late ChewieController _chewieController;
  double _aspectRatio = 16 / 9;

  @override
  void initState() {
    super.initState();
    try {
      _videoPlayerController = VideoPlayerController.network(story.videoUrl);
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
    return Scaffold(
        backgroundColor: Colors.black12.withOpacity(0.8),
        appBar: AppBar(
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
              child: Chewie(
                controller: _chewieController,
              ),
            )));
  }
}
