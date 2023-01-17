// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import '../../../home/presentation/widgets/icon_with_text_card.dart';
import '../pages/events_page.dart';

class CalendarCard extends IconWithTextCard {
  CalendarCard()
      : super(
    title: 'Calendar',
    iconData: FontAwesomeIcons.calendarDays,
    pushTo: CalendarPage(),
  );
}
