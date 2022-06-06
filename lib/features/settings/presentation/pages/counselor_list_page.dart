// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/pages/counselor_details_page.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/image_list_tile.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/settings/data/counselor_list.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class CounselorListPage extends StatelessWidget {
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
        leading: UniformBackButton(),
        title: Text(
          'Counselors',
          textScaleFactor: 1,
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        //height: Device.height - 277,
        margin: EdgeInsets.only(left: 5, right: 5),
        child: ListView.builder(
          shrinkWrap: false,
          itemBuilder: (context, index) => CounselorListTile(
              item: counselors[index],
              counselorDetailsPage:
                  CounselorDetails(person: counselors[index])),
          itemCount: counselors.length,
        ),
      ),
    );
  }
}
