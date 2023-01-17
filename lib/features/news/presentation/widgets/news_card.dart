// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import '../../../home/presentation/widgets/icon_with_text_card.dart';
import '../pages/news_page.dart';

class NewsCard extends IconWithTextCard {
  NewsCard({int? notificationCount})
      : super(
          title: 'News',
          iconData: FontAwesomeIcons.newspaper,
          pushTo: NewsPage(),
          notificationCount: notificationCount,
        );
}
