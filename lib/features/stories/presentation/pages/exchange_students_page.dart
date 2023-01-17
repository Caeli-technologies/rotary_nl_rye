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
import 'package:rotary_nl_rye/features/stories/presentation/pages/stories_display.dart';
import '../../../../core/presentation/uniform_widgets/rotary_scaffold.dart';

class ExchangeStudentsPage extends StatelessWidget {
  final Country country;
  final List<ExchangeStudent> students;

  const ExchangeStudentsPage({required this.country, required this.students});

  @override
  Widget build(BuildContext context) {
    return RotaryScaffold(
      title: country.name,
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
                    'Exchange Students',
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
                    child: students.length == 0
                        ? Center(
                            child: Text(
                              'No Students Yet',
                              textAlign: TextAlign.center,
                              textScaleFactor: 1,
                              style: TextStyle(
                                color: Palette.indigo,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) =>
                                ReboundsStudentsListTile(
                              item: students[index],
                              reboundsStudentsListPage: StoriesDisplay(
                                student: students[index],
                                country: country.name,
                              ),
                            ),
                            itemCount: students.length,
                          ))
              ]),
        ),
      ),
    );
  }
}
