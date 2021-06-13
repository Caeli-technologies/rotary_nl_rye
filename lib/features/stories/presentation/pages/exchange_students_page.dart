import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/image_list_tile.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/stories/models/country.dart';
import 'package:rotary_nl_rye/features/stories/models/exchange_student.dart';
import 'package:rotary_nl_rye/features/stories/presentation/pages/stories_display.dart';

class ExchangeStudentsPage extends StatelessWidget {
  final Country country;
  final List<ExchangeStudent> students;

  const ExchangeStudentsPage({required this.country, required this.students});

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
          country.name,
          textScaleFactor: 1.5,
          style: TextStyle(
              color: Palette.indigo, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  child: SvgPicture.asset(
                    country.imageUrl,
                    height: 60,
                    width: 60,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Palette.themeShadeColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                  ),
                  child: Text(
                    "Exchange Students",
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.5,
                    style: TextStyle(
                      color: Palette.indigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.70,
                  child: ListView.builder(
                    itemBuilder: (context, index) => ReboundsStudentsListTile(
                      item: students[index],
                      reboundsStudentsListPage: StoriesDisplay(
                        student: students[index],
                      ),
                    ),
                    itemCount: students.length,
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
