// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';

class InfoListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget page;

  const InfoListTile({
    required this.title,
    required this.icon,
    required this.page,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: FaIcon(icon, color: Palette.lightIndigo),
          title: Text(title, style: TextStyle(color: Palette.grey)),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Palette.grey),
        ),
        Divider(height: 20, thickness: 2),
      ],
    );
  }
}
