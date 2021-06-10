import 'package:flutter/material.dart';
import 'package:rotary_nl_rye/core/presentation/pages/inbounds_students_details_page.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/image_list_tile.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/inbound/presentation/models/students.dart';

class StudentsListPage extends StatelessWidget {
  final List<Students> students;
  final int districtnumber;
  final String district;
  const StudentsListPage(
      {required this.students,
      required this.districtnumber,
      required this.district});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Container(
          margin: EdgeInsets.only(left: 10, top: 5),
          width: 40,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
          child: RawMaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: new Icon(
              Icons.arrow_back,
              color: Palette.accentColor,
              size: 30.0,
            ),
            shape: new CircleBorder(),
            elevation: 2.0,
            fillColor: Palette.themeShadeColor,
            padding: const EdgeInsets.all(5.0),
          ),
        ),
        title: Text(
          "$districtnumber - $district",
          textScaleFactor: 0.9,
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        //height: Device.height - 277,
        margin: EdgeInsets.only(left: 5, right: 5),
        child: ListView.builder(
          shrinkWrap: false,
          itemBuilder: (context, index) => InboundsStudentsListTile(
              item: students[index],
              inboundsStudentsListPage: InboundsDetails(
                  person: students[index], districtnumber: districtnumber)),
          itemCount: students.length,
        ),
      ),
    );
  }
}
