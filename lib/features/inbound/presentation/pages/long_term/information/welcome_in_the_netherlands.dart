// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class WelcomeInTheNetherlandsPage extends StatefulWidget {
  @override
  _WelcomeInTheNetherlandsPageState createState() =>
      _WelcomeInTheNetherlandsPageState();
}

class _WelcomeInTheNetherlandsPageState
    extends State<WelcomeInTheNetherlandsPage> {
  @override
  void initState() {
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
          'Welcome to the Netherlands!',
          textScaler: TextScaler.linear(1),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        children: <Widget>[
          buildContentText(
            'Welcome to the Netherlands!',
            isBold: true,
          ),
          buildContentText(
            'We are very excited about your upcoming stay with us and looking forward to meeting you. We hope and believe that you will enjoy your stay with us. We have an exciting and active Rotary International Youth Exchange Program with approx. 35-50 exchange students arriving in our country. You will make friends from all over the world, in addition to making many Dutch friends in your school and Rotary.',
          ),
          buildContentText(
            'An exchange year is one of the best years of your life, a wonderful experience in a new culture, with a new language but also with some rules to make sure that your stay will be both enjoyable for you and us alike. These rules are consistent with the International Rotary rules.',
          ),
          buildContentText(
            'Please remember that under all circumstances you are an ambassador of Rotary and will have to behave accordingly. Our motto: Be grateful, be on purpose, be of service, be here now, be first, be curious! Also you will be an ambassador of your country. Both functions will be with you at all times and you will be regarded and judged as such at all times during your exchange!',
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
