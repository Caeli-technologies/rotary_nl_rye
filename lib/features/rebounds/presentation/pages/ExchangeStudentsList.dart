import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotary_nl_rye/core/domain/entities/exchange_student.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/rebounds/models/country.dart';
import 'package:rotary_nl_rye/features/rebounds/presentation/pages/ExchangeStudentsDetails.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';
import 'package:rotary_nl_rye/features/widgets/list_tiles.dart';

class ExchangeStudentsList extends StatelessWidget {
  final Country country;
  final List<ExchangeStudent> students;

  ExchangeStudentsList({required this.country, required this.students}) {
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
          style: TextStyle(
            color: Palette.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SvgPicture.asset(
              country.imageUrl,
              height: 30,
              width: 30,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return ReboundsStudentsListTile(
            item: students[index],
            reboundsStudentsListPage: StoriesDisplay(student: students[index]),
          );
        },
      ),
    );
  }
}
