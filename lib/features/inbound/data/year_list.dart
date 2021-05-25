import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/features/inbound/presentation/models/year.dart';

import 'students/2018_2019.dart';
import 'students/2019_2020.dart';
import 'students/2020_2021.dart';
import 'students/2021_2022.dart';

List<YearList> yearList = [
  // Exchange Year 2021-2022
  YearList(
    title: "Exchange Year 2021-2022",
    year: "2021-2022",
    list: studentsList_2021_2022,
    icon: FontAwesomeIcons.passport,
  ),
  // Exchange Year 2020-2021
  YearList(
    title: "Exchange Year 2020-2021",
    year: "2020-2021",
    list: studentsList_2020_2021,
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
