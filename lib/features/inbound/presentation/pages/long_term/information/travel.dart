// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  @override
  initState() {
    super.initState();
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
          'Travel',
          textScaler: TextScaler.linear(1),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        children: <Widget>[
          buildContentText(
            'The rules of Rotary Youth Exchange do not allow travelling outside the scope of the Rotary program. However, you may travel with your host family or members of your host club or other Rotarians, or other authorized persons (for instance on a school trip), but not alone. This rule applies for both travelling inside the Netherlands as well as abroad.',
          ),
          buildContentText(
            'Visits to family or friends abroad are not permitted!',
            isBold: true,
          ),
          buildContentText(
            'One of your host families might suggest to participate in a holiday somewhere abroad. This is usually OK when you will have a written approval from your parents.',
          ),
          buildRotaryImage(),
          buildUpdateText(),
          SizedBox(height: 60),
        ],
      ),
    );
  }

  Padding buildContentText(String text, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
      ),
    );
  }

  Padding buildRotaryImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Center(
        child: Image.asset(
          'assets/image/rotary_blue.png',
          height: 55.0,
        ),
      ),
    );
  }

  Padding buildUpdateText() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Center(
        child: Text(
          'Update: 31 May 2021',
          style: TextStyle(color: Color(0xFF777777)),
        ),
      ),
    );
  }
}
