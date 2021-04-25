// @dart=2.9
import 'package:rotary_nl_rye/views/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(), // Provide light theme.
      darkTheme: ThemeData.dark(), // Provide dark theme.
      themeMode: ThemeMode.system,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
