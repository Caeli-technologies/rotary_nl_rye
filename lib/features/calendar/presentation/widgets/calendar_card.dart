// 🐦 Flutter imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../pages/events_page.dart';
import '../../../home/presentation/widgets/icon_with_text_card.dart';

class CalendarCard extends IconWithTextCard {
  CalendarCard()
      : super(
    title: 'Calendar',
    iconData: FontAwesomeIcons.calendarDays,
    pushTo: CalendarPage(),
  );
}
