// 🐦 Flutter imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../news/presentation/pages/news_page.dart';
import 'icon_with_text_card.dart';

class NewsCard extends IconWithTextCard {
  NewsCard()
      : super(
    title: 'News',
    iconData: FontAwesomeIcons.newspaper,
    pushTo: NewsPage(),
  );
}
