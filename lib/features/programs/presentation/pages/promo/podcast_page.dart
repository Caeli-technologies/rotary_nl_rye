// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class PodcastPage extends StatefulWidget {
  @override
  _PodcastPageState createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage> {
  AudioPlayer audioPlayer = AudioPlayer();
  int? currentlyPlayingIndex;

  List<Podcast> podcasts = [
    Podcast(
      title: 'Episode 1: Rotary Sharon en Michel Teunissen',
      duration: '23:04',
      audioUrl:
          'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/podcast/rotary-sharon-en-michel-teunissen.mp3',
    ),
    Podcast(
      title: 'Episode 2: Rotary Ellen en Steven Stolp',
      duration: '26:03',
      audioUrl:
          'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/podcast/rotary-ellen-en-steven-stolp.mp3',
    ),
  ];

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            MediaQuery.of(context).platformBrightness == Brightness.light
                ? SystemUiOverlayStyle.dark
                : SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: UniformBackButton(),
        title: Text(
          'Promo Podcast',
          textScaler: TextScaler.linear(1),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        children: <Widget>[
          Text(
            'Podcast - wat zijn de ervaringen van een tweetal gastouders?',
            style: TextStyle(
                color: Palette.bodyText,
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              'Hoe is het nou om een paar maanden ouders te zijn van een exchange student? Hoe leuk (of niet) is dat nou? Wat brengt het jullie en wat voor invloed heeft het? Luister naar de ervaringen van deze gastouders die in 2022-2023 een exchange student in huis hebben gehad.',
              style: TextStyle(color: Palette.bodyText, fontSize: 14.0),
            ),
          ),
          _buildPodcastList(),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              'Let op: deze podcasts worden gestreamed dan kan het zijn dat jouw provider je hiervoor kosten in rekening brengt.',
              style:
                  TextStyle(fontStyle: FontStyle.italic, color: Palette.grey),
            ),
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildPodcastList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: podcasts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: IconButton(
            icon: Icon(
              currentlyPlayingIndex == index
                  ? Icons.pause_circle_filled
                  : Icons.play_circle_fill,
            ),
            onPressed: () => _onPlayPauseButtonPressed(index),
          ),
          title: Text(podcasts[index].title),
          subtitle: Text(podcasts[index].duration),
          trailing: Icon(Icons.more_vert),
          onTap: null,
        );
      },
    );
  }

  Future<void> _onPlayPauseButtonPressed(int index) async {
    if (currentlyPlayingIndex == index) {
      await audioPlayer.pause();
      setState(() {
        currentlyPlayingIndex = null;
      });
    } else {
      await audioPlayer.play(
        UrlSource(podcasts[index].audioUrl),
        mode: PlayerMode.mediaPlayer,
      );
      setState(() {
        currentlyPlayingIndex = index;
      });
    }
  }
}

class Podcast {
  final String title;
  final String duration;
  final String audioUrl;

  Podcast({
    required this.title,
    required this.duration,
    required this.audioUrl,
  });
}
