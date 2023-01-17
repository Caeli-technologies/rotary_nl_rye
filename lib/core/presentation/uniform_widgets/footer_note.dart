// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class FooterNote extends StatelessWidget {
  final String text;

  const FooterNote({required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFF777777),
        ),
      ),
    );
  }
}
