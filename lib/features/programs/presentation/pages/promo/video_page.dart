// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/widgets/native_video.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
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
          "Promo Video's",
          textScaler: TextScaler.linear(1),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        children: <Widget>[
          NativeVideo(
            url:
                'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/videos/promo/5th-avenue-jeugd.mp4',
          ),
          SizedBox(height: 30),
          Text(
            'Waarom doen we dit?',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          buildInfoText('- Het opbouwen van goede relaties met andere landen'),
          buildInfoText('- Het houdt de club jong'),
          buildInfoText(
              '- De jongere ontwikkelt zichzelf en zijn/haar omgeving'),
          SizedBox(height: 30),
          Center(
            child: Image.asset(
              'assets/image/rotary_blue.png',
              height: 55.0,
            ),
          ),
          SizedBox(height: 15),
          Center(
            child: Text(
              'Update: 27 mei 2021',
              style: TextStyle(color: Color(0xFF777777)),
            ),
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget buildInfoText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.0),
      ),
    );
  }
}
