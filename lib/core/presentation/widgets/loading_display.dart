import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator()
    );
  }
}