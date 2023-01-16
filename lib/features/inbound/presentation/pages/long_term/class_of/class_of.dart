// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/widgets/image_list_tile.dart';
import 'package:rotary_nl_rye/features/inbound/data/inbound_list.dart';
import '../../../../../../core/presentation/uniform_widgets/rotary_scaffold.dart';
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
    return RotaryScaffold(
      title: 'Class Of 2022-23',
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
