// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/inbound/data/inbound_list.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';
import 'package:rotary_nl_rye/features/widgets/list_tiles.dart';
import 'class_of_details_page.dart';

class ClassOfPageInbounds extends StatefulWidget {
  @override
  _ClassOfPageInboundsState createState() => _ClassOfPageInboundsState();

  ClassOfPageInbounds({Key? key}) : super(key: key);
}

class _ClassOfPageInboundsState extends State<ClassOfPageInbounds> {
  @override
  void initState() {
    super.initState();

    inboundList.sort((a, b) => a.name.compareTo(b.name));
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
          // centerTitle: false,
          leading: UniformBackButton(),
          title: Text(
            'Class Of 2024-25',
            textScaler: TextScaler.linear(1.2),
            style:
                TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
          )),
      body: ListView.builder(
        shrinkWrap: false,
        itemBuilder: (context, index) => InboundStudentListTile(
            item: inboundList[index],
            classOfDetailsPage:
                ClassOfDetailsInbounds(person: inboundList[index])),
        itemCount: inboundList.length,
      ),
    );
  }
}
