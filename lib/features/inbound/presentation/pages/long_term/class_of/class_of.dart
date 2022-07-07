// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/widgets/image_list_tile.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/inbound/data/inbound_list.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';
import 'class_of_details_page.dart';

class ClassOfPageInbounds extends StatefulWidget {
  @override
  _ClassOfPageInboundsState createState() => _ClassOfPageInboundsState();

  ClassOfPageInbounds({Key? key}) : super(key: key);
}

class _ClassOfPageInboundsState extends State<ClassOfPageInbounds> {
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
          // centerTitle: false,
          leading: UniformBackButton(),
          title: Text(
            'Class Of 2022-23',
            textScaleFactor: 1.2,
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
