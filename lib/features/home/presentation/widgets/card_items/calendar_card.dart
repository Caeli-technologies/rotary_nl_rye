// 🐦 Flutter imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../calendar/presentation/pages/events_page.dart';
import 'icon_with_text_card.dart';

class CalendarCard extends IconWithTextCard {
  CalendarCard()
      : super(
    title: 'Calendar',
    iconData: FontAwesomeIcons.calendarDays,
    pushTo: CalendarPage(),
  );
}
