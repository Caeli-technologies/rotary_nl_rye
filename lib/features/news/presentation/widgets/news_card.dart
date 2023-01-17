// 🐦 Flutter imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../pages/news_page.dart';
import '../../../home/presentation/widgets/icon_with_text_card.dart';

class NewsCard extends IconWithTextCard {
  NewsCard()
      : super(
    title: 'News',
    iconData: FontAwesomeIcons.newspaper,
    pushTo: NewsPage(),
  );
}
