// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'back_button.dart';

class RotaryScaffold extends StatelessWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget body;
  final bool returnButtonShown;

  const RotaryScaffold(
      {Key? key,
      this.title,
      this.actions,
      required this.body,
      this.returnButtonShown = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            MediaQuery.of(context).platformBrightness == Brightness.light
                ? SystemUiOverlayStyle.dark
                : SystemUiOverlayStyle.light,
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: returnButtonShown ? UniformBackButton() : null,
        title: title != null
            ? Text(
                title!,
                textScaleFactor: 1.3,
                style: TextStyle(
                    color: Palette.indigo, fontWeight: FontWeight.bold),
              )
            : null,
        actions: actions,
      ),
      body: body,
    );
  }
}
