import 'package:flutter/material.dart';
import 'package:rotary_nl_rye/core/prop.dart';

class UniformBackButton extends StatelessWidget {
  const UniformBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back),
      color: Palette.indigo,
    );
  }
}
