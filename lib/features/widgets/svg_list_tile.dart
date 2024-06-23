// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';

class SVGListTile extends StatelessWidget {
  final Widget descriptionPage;
  final dynamic item;

  const SVGListTile({
    required this.descriptionPage,
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => descriptionPage),
          );
        },
        contentPadding: EdgeInsets.all(0),
        leading: SvgPicture.asset(
          item.imageUrl,
          height: 55,
          width: 55,
          fit: BoxFit.contain,
        ),
        title: Text(
          item.name,
          style: TextStyle(color: Palette.indigo),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 30,
          color: Palette.indigo,
        ),
      ),
    );
  }
}
