// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:flutter_svg/svg.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/domain/entities/exchange_student.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/image_list_tile.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/stories/models/country.dart';
import 'package:rotary_nl_rye/features/stories/presentation/pages/student_details.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class ExchangeStudentsPage extends StatelessWidget {
  final Country country;
  final List<ExchangeStudent> students;

  ExchangeStudentsPage({required this.country, required this.students}) {
    students.sort((a, b) {
      final yearRegExp = RegExp(r'\b\d{4}-\d{4}\b');
      final aYear = yearRegExp.firstMatch(a.description)?.group(0) ?? '';
      final bYear = yearRegExp.firstMatch(b.description)?.group(0) ?? '';
      return bYear.compareTo(aYear);
    });
  }

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
          country.name,
          textScaleFactor: 1.5,
          style: TextStyle(
            color: Palette.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: SvgPicture.asset(
              country.imageUrl,
              height: 30,
              width: 30,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        shrinkWrap: false,
        itemBuilder: (context, index) => ReboundsStudentsListTile(
          item: students[index],
          reboundsStudentsListPage: StoriesDisplay(student: students[index]),
        ),
        itemCount: students.length,
      ),
    );
  }
}
