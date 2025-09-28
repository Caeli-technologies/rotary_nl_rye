// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/contact/presentation/models/organization.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/uniform_circle_avatar.dart';

class ContactListTile extends StatelessWidget {
  final Widget contactDetailsPage;
  final Organization item;

  const ContactListTile({
    required this.contactDetailsPage,
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
            MaterialPageRoute(builder: (context) => contactDetailsPage),
          );
        },
        contentPadding: EdgeInsets.all(0),
        leading: UniformCircleAvatar(imageUrl: item.imageUrl),
        title: Text(
          item.name,
          style: TextStyle(
            color: Palette.indigo,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          item.functions[0],
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
