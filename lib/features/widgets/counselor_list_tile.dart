// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';

class CounselorListTile extends StatelessWidget {
  final Widget counselorDetailsPage;
  final dynamic item;

  const CounselorListTile({
    required this.counselorDetailsPage,
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
            MaterialPageRoute(builder: (context) => counselorDetailsPage),
          );
        },
        contentPadding: EdgeInsets.all(0),
        leading: CachedNetworkImage(
          height: 55,
          width: 55,
          imageUrl: item.imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        title: Text(
          item.name,
          style: TextStyle(
            color: Palette.indigo,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          item.functions,
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
