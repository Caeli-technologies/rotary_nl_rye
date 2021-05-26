import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/features/inbound/presentation/models/year.dart';

import 'students/2022_2023.dart';
import 'students/2018_2019.dart';
import 'students/2019_2020.dart';

List<YearList> yearList = [
  // Exchange Year 2021-2022
  YearList(
    title: "Exchange Year 2022-2023",
    year: "2022-2023",
    list: studentsList_2022_2023,
    icon: FontAwesomeIcons.passport,
  ),
  // Exchange Year 2019-2020
  YearList(
    title: "Exchange Year 2019-2020",
    year: "2019-2020",
    list: studentsList_2019_2020,
    icon: FontAwesomeIcons.passport,
  ),
  // Exchange Year 2018-2019
  YearList(
    title: "Exchange Year 2018-2019",
    year: "2018-2019",
    list: studentsList_2018_2019,
    icon: FontAwesomeIcons.passport,
  ),
];
