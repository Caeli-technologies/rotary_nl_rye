// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class InsurancePage extends StatefulWidget {
  @override
  _InsurancePageState createState() => _InsurancePageState();
}

class _InsurancePageState extends State<InsurancePage> {
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
          'Insurance',
          textScaler: TextScaler.linear(1),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        children: <Widget>[
          buildContentText(
              'The insurance policy from the Netherlands is compulsory. We will pre-insure you, so you will be fully insured as soon as you will land at Amsterdam Schiphol airport up until you are leaving at the airport again. A copy of the Insurance Policy will be sent to you a few days before you leave your home country.'),
          buildRotaryImage(),
          buildUpdateText(),
          SizedBox(height: 60),
        ],
      ),
    );
  }

  Padding buildContentText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
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
        ));
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
