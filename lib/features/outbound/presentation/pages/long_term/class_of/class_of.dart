// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/outbound/data/outbound_list.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';
import 'package:rotary_nl_rye/features/widgets/list_tiles.dart';
import 'class_of_details_page.dart';

class ClassOfPage extends StatefulWidget {
  @override
  _ClassOfPageState createState() => _ClassOfPageState();

  ClassOfPage({Key? key}) : super(key: key);
}

class _ClassOfPageState extends State<ClassOfPage> {
  @override
  void initState() {
    super.initState();

    outboundList.sort((a, b) => a.name.compareTo(b.name));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: MediaQuery.of(context).platformBrightness,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: UniformBackButton(),
        title: Text(
          'Class Of 2023-24',
          textScaler: TextScaler.linear(1.2),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: false,
        itemBuilder: (context, index) => OutboundStudentListTile(
          item: outboundList[index],
          classOfDetailsPage: ClassOfDetails(person: outboundList[index]),
        ),
        itemCount: outboundList.length,
      ),
    );
  }
}
