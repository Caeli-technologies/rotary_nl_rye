// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';

class ImageListTile extends StatelessWidget {
  final Widget descriptionPage;
  final dynamic item;

  const ImageListTile({
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
        leading: Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Palette.imageBackgroundColor,
          ),
          child: Image.asset(
            item.imageUrl,
            height: 50,
            width: 50,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          item.name,
          style: TextStyle(color: Palette.indigo),
        ),
        subtitle: Text(
          item.description,
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
