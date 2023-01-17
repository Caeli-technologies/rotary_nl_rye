// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/pages/contributors_details_page.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/image_list_tile.dart';
import '../../../../core/presentation/uniform_widgets/rotary_list_view.dart';
import '../../../../core/presentation/uniform_widgets/rotary_scaffold.dart';
import '../data/contributors.dart';

class ContributorsPage extends StatefulWidget {
  @override
  _ContributorsPageState createState() => _ContributorsPageState();
}

class _ContributorsPageState extends State<ContributorsPage> {
  List<ContributorsListTile> createListTiles() {
    return contributors.map(
      (e) => ContributorsListTile(
        item: e,
        contributorsDetailsPage: ContributorsDetails(person: e),
      ),
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return RotaryScaffold(
      title: 'Contributors',
      body: RotaryListView(
        listTiles: createListTiles(),
      ),
    );
  }
}
