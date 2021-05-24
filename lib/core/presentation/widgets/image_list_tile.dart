import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rotary_nl_rye/core/prop.dart';

class SVGListTile extends StatelessWidget {
  final descriptionPage;
  final item;
  const SVGListTile({
    this.descriptionPage,
    this.item,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => descriptionPage),
          );
        },
        contentPadding: EdgeInsets.zero,
        leading: ClipRRect(
          child: Container(
            height: 55,
            width: 55,
            child: SvgPicture.asset(
              item.imageUrl,
              height: 50,
              width: 50,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(item.name,
            style: TextStyle(
              color: Palette.indigo,
            )),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 30,
          color: Palette.indigo,
        ),
      ),
    );
  }
}

class ImageListTile extends StatelessWidget {
  final descriptionPage;
  final item;
  const ImageListTile({
    this.descriptionPage,
    this.item,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: ListTile(
        onTap: () {
          debugPrint(item.name);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => descriptionPage),
          );
        },
        contentPadding: EdgeInsets.zero,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Palette
                  .imageBackgroundColor, //fill the image still needs to chagnge
            ),
            child: Image.asset(
              item.imageUrl,
              height: 50,
              width: 50,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(item.name,
            style: TextStyle(
              color: Palette.indigo,
            )),
        subtitle: Text(
          item.description,
          style: TextStyle(
            color: Palette.indigo,
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

class ContactListTile extends StatelessWidget {
  final contactDetailsPage;
  final item;
  const ContactListTile({
    this.contactDetailsPage,
    this.item,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: ListTile(
        onTap: () {
          debugPrint(item.name);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => contactDetailsPage),
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
        title: Text(item.name,
            style: TextStyle(
              color: Palette.indigo,
            )),
        subtitle: Text(
          item.role,
          style: TextStyle(
            color: Palette.indigo,
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
