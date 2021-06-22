import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/stories/models/story.dart';

import 'package:video_player/video_player.dart';

class StoryDutchie extends StatefulWidget {
  final Story story;

  StoryDutchie({required this.story});

  @override
  _StoryDutchieState createState() => _StoryDutchieState(story: story);
}

class _StoryDutchieState extends State<StoryDutchie> {
  final Story story;
  _StoryDutchieState({required this.story});

  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  double _aspectRatio = 16 / 9;
  @override
  initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(story.videoUrl);
    _chewieController = ChewieController(
      allowedScreenSleep: false,
      allowFullScreen: true,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Container(
          margin: EdgeInsets.only(left: 10, top: 5),
          width: 40,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
          child: RawMaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: new Icon(
              Icons.arrow_back,
              color: Palette.accentColor,
              size: 30.0,
            ),
            shape: new CircleBorder(),
            elevation: 2.0,
            fillColor: Palette.themeShadeColor,
            padding: const EdgeInsets.all(5.0),
          ),
        ),
        title: Text(
          "Dutchie",
          textScaleFactor: 1,
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 16, top: 15, right: 16),
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                //margin: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                height: 220,
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }
}
