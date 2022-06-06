// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/pages/inbounds_students_details_page.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/image_list_tile.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/inbound/presentation/models/students.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class StudentsListPage extends StatelessWidget {
  final List<Students> students;
  final int districtnumber;
  final String district;
  final String year;

  const StudentsListPage(
      {required this.students,
      required this.districtnumber,
      required this.district,
      required this.year});

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
          '$districtnumber - $district',
          textScaleFactor: 0.9,
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          //height: Device.height - 277,
          margin: EdgeInsets.only(left: 5, right: 5),
          child: students.length == 0
              ? Center(
                  child: Text(
                    'No Students Here',
                    textAlign: TextAlign.center,
                    textScaleFactor: 1,
                    style: TextStyle(
                      color: Palette.indigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: false,
                  itemBuilder: (context, index) => InboundsStudentsListTile(
                      item: students[index],
                      inboundsStudentsListPage: InboundsDetails(
                          person: students[index],
                          year: year,
                          districtnumber: districtnumber)),
                  itemCount: students.length,
                )),
    );
  }
}
