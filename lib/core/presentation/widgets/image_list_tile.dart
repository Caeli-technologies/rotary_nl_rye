// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/domain/entities/exchange_student.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/contact/presentation/models/organization.dart';
import 'package:rotary_nl_rye/features/inbound/presentation/models/ClassOf.dart';
import 'package:rotary_nl_rye/features/outbound/presentation/models/ClassOf.dart';
import '../../../features/uniform_widgets/uniform_circle_avatar.dart';

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
        leading: UniformCircleAvatar(
          imageUrl: item.imageUrl,
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

class OutboundStudentListTile extends StatelessWidget {
  final classOfDetailsPage;
  final Outbounds item;
  const OutboundStudentListTile({
    this.classOfDetailsPage,
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
            MaterialPageRoute(builder: (context) => classOfDetailsPage),
          );
        },
        contentPadding: EdgeInsets.all(0),
        leading: UniformCircleAvatar(imageUrl: item.imageUrl),
        title: Text(item.name,
            style: TextStyle(
              color: Palette.indigo,
              fontWeight: FontWeight.w600,
            )),
        subtitle: Row(
          children: [
            Text(item.from,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  inherit: true,
                  fontSize: 14.0,
                  color: Colors.grey[600],
                )),
            SizedBox(
              width: 2,
            ),
            SvgPicture.asset('assets/icons/flags/${item.fromFlag}.svg',
                height: 15),
            SizedBox(
              width: 5,
            ),
            FaIcon(
              FontAwesomeIcons.arrowRightLong,
              color: Colors.grey,
            ),
            SizedBox(
              width: 5,
            ),
            Text(item.to,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  inherit: true,
                  fontSize: 14.0,
                  color: Colors.grey[600],
                )),
            SizedBox(
              width: 2,
            ),
            item.toFlag == null
                ? SizedBox.shrink()
                : SvgPicture.asset('assets/icons/flags/${item.toFlag}.svg',
                    height: 15)
          ],
        ),
        //                       Text(
        //   item.from,
        //   style: TextStyle(
        //     fontWeight: FontWeight.w500,
        //     color: Palette.grey,
        //   ),
        // ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 30,
          color: Palette.indigo,
        ),
      ),
    );
  }
}

class InboundStudentListTile extends StatelessWidget {
  final classOfDetailsPage;
  final Inbounds item;
  const InboundStudentListTile({
    this.classOfDetailsPage,
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
            MaterialPageRoute(builder: (context) => classOfDetailsPage),
          );
        },
        contentPadding: EdgeInsets.all(0),
        leading: UniformCircleAvatar(imageUrl: item.imageUrl),
        title: Text(item.name,
            style: TextStyle(
              color: Palette.indigo,
              fontWeight: FontWeight.w600,
            )),
        subtitle: Row(
          children: [
            Text(item.from,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  inherit: true,
                  fontSize: 14.0,
                  color: Colors.grey[600],
                )),
            SizedBox(
              width: 2,
            ),
            SvgPicture.asset('assets/icons/flags/${item.fromFlag}.svg',
                height: 15),
            SizedBox(
              width: 5,
            ),
            FaIcon(
              FontAwesomeIcons.arrowRightLong,
              color: Colors.grey,
            ),
            SizedBox(
              width: 5,
            ),
            Text(item.to,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  inherit: true,
                  fontSize: 14.0,
                  color: Colors.grey[600],
                )),
            SizedBox(
              width: 2,
            ),
            item.toFlag == null
                ? SizedBox.shrink()
                : SvgPicture.asset('assets/icons/flags/${item.toFlag}.svg',
                    height: 15)
          ],
        ),
        //                       Text(
        //   item.from,
        //   style: TextStyle(
        //     fontWeight: FontWeight.w500,
        //     color: Palette.grey,
        //   ),
        // ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 30,
          color: Palette.indigo,
        ),
      ),
    );
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
          'From: ${item.place}',
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

class ContributorsListTile extends StatelessWidget {
  final contributorsDetailsPage;
  final item;
  const ContributorsListTile({
    this.contributorsDetailsPage,
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
            MaterialPageRoute(builder: (context) => contributorsDetailsPage),
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
