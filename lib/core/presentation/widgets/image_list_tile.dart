import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/contact/presentation/models/organization.dart';
import 'package:rotary_nl_rye/features/inbound/presentation/models/district.dart';
import 'package:rotary_nl_rye/features/inbound/presentation/models/year.dart';
import 'package:rotary_nl_rye/features/stories/models/exchange_student.dart';

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
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => descriptionPage),
          );
        },
        contentPadding: EdgeInsets.all(0),
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
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: ListTile(
        onTap: () {
          print(item.name);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => descriptionPage),
          );
        },
        contentPadding: EdgeInsets.all(0),
        leading: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(40)),
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
  final Organization item;

  const ContactListTile({
    this.contactDetailsPage,
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: ListTile(
        onTap: () {
          print(item.name);
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
              fontWeight: FontWeight.w600,
            )),
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

class RotexContactListTile extends StatelessWidget {
  final rotexContactDetailsPage;
  final item;
  const RotexContactListTile({
    this.rotexContactDetailsPage,
    this.item,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: ListTile(
        onTap: () {
          print(item.name);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => rotexContactDetailsPage),
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

class InboundYearListTile extends StatelessWidget {
  final districtListPage;
  final YearList item;

  const InboundYearListTile({
    this.districtListPage,
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
      child: ListTile(
        leading: Padding(
          padding: EdgeInsets.zero,
          child: Container(
            child: FaIcon(
              item.icon,
              color: Palette.lightIndigo,
              size: 32,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: Device.width - 120,
              child: Text(item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 15,
                    color: Palette.grey,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Palette.grey,
            ),
          ],
        ),
        onTap: () {
          print(item.year);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => districtListPage),
          );
        },
      ),
    ));
  }
}

class InboundDistrictListTile extends StatelessWidget {
  final studentsListPage;
  final DistrictList item;

  const InboundDistrictListTile({
    required this.studentsListPage,
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
      child: ListTile(
        leading: Padding(
          padding: EdgeInsets.zero,
          child: Container(
            child: FaIcon(
              item.icon,
              color: Palette.lightIndigo,
              size: 40,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: Device.width - 150,
              child: Text("${item.number} - ${item.districtName}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 15,
                    color: Palette.grey,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Palette.grey,
            ),
          ],
        ),
        onTap: () {
          print(item.number);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => studentsListPage),
          );
        },
      ),
    ));
  }
}

class InboundsStudentsListTile extends StatelessWidget {
  final inboundsStudentsListPage;
  final item;

  const InboundsStudentsListTile({
    this.inboundsStudentsListPage,
    this.item,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: ListTile(
        onTap: () {
          print(item.name);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => inboundsStudentsListPage),
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
              fontWeight: FontWeight.w600,
            )),
        subtitle: Text(
          "From: ${item.place}",
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

class ReboundsStudentsListTile extends StatelessWidget {
  final reboundsStudentsListPage;
  final ExchangeStudent item;

  const ReboundsStudentsListTile({
    this.reboundsStudentsListPage,
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: ListTile(
        onTap: () {
          print(item.name);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => reboundsStudentsListPage),
          );
        },
        contentPadding: EdgeInsets.all(0),
        leading: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          child: CachedNetworkImage(
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
        ),
        title: Text(item.name,
            style: TextStyle(
              color: Palette.indigo,
              fontWeight: FontWeight.w600,
            )),
        subtitle: Text(
          item.description,
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

class CounselorListTile extends StatelessWidget {
  final counselorDetailsPage;
  final item;
  const CounselorListTile({
    this.counselorDetailsPage,
    this.item,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: ListTile(
        onTap: () {
          print(item.name);
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
        title: Text(item.name,
            style: TextStyle(
              color: Palette.indigo,
              fontWeight: FontWeight.w600,
            )),
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
