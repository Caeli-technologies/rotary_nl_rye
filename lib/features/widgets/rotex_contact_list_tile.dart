import 'package:flutter/material.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/contact/presentation/models/rotex.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/uniform_circle_avatar.dart';

class RotexContactListTile extends StatelessWidget {
  final Widget rotexContactDetailsPage;
  final Rotex item;

  const RotexContactListTile({
    required this.rotexContactDetailsPage,
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
            MaterialPageRoute(builder: (context) => rotexContactDetailsPage),
          );
        },
        contentPadding: EdgeInsets.all(0),
        leading: UniformCircleAvatar(imageUrl: item.imageUrl),
        title: Text(item.name,
            style: TextStyle(
              color: Palette.indigo,
              fontWeight: FontWeight.w600,
            )),
        subtitle: Text(
          item.role,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Palette.grey,
          ),
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
