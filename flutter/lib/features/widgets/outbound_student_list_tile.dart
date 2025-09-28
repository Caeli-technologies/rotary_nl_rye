// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/outbound/presentation/models/ClassOf.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/uniform_circle_avatar.dart';

class OutboundStudentListTile extends StatelessWidget {
  final Widget classOfDetailsPage;
  final Outbounds item;

  const OutboundStudentListTile({
    required this.classOfDetailsPage,
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
            MaterialPageRoute(builder: (context) => classOfDetailsPage),
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
        subtitle: Row(
          children: [
            Text(
              item.from,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(width: 2),
            SvgPicture.asset(
              'assets/icons/flags/${item.fromFlag}.svg',
              height: 15,
            ),
            SizedBox(width: 5),
            FaIcon(
              FontAwesomeIcons.arrowRightLong,
              color: Colors.grey,
            ),
            SizedBox(width: 5),
            Text(
              item.to,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(width: 2),
            SvgPicture.asset(
              'assets/icons/flags/${item.toFlag}.svg',
              height: 15,
            ),
          ],
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
