// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/widgets/image_list_tile.dart';
import 'package:rotary_nl_rye/features/outbound/data/outbound_list.dart';
import '../../../../../../core/presentation/uniform_widgets/rotary_scaffold.dart';
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
    return RotaryScaffold(
      title: 'Class Of 2022-23',
      body: ListView.builder(
        shrinkWrap: false,
        itemBuilder: (context, index) => OutboundStudentListTile(
            item: outboundList[index],
            classOfDetailsPage: ClassOfDetails(person: outboundList[index])),
        itemCount: outboundList.length,
      ),
    );
  }
}
