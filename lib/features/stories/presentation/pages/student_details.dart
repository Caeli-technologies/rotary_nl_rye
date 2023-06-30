// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/domain/entities/exchange_student.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/full_screen_image.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/native_video.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';
import '../../../../core/prop.dart';

class StoriesDisplay extends StatefulWidget {
  final ExchangeStudent student;

  StoriesDisplay({required this.student});

  @override
  _StoriesDisplayState createState() => _StoriesDisplayState(student: student);
}

class _StoriesDisplayState extends State<StoriesDisplay> {
  _StoriesDisplayState({required this.student});

  final ExchangeStudent student;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            MediaQuery.of(context).platformBrightness == Brightness.light
                ? SystemUiOverlayStyle.dark
                : SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: UniformBackButton(),
        title: Text(
          'Rebounds',
          textScaleFactor: 1.4,
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 15,
                  bottom: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        InkWell(
                            borderRadius: BorderRadius.circular(60),
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (BuildContext context, _, __) =>
                                      FullScreenImage(url: student.imageUrl)));
                            },
                            child: CachedNetworkImage(
                              height: 60,
                              width: 60,
                              imageUrl: student.imageUrl,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: Device.width - 150,
                              child: Text(student.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                    inherit: true,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            SizedBox(
                              width: Device.width - 150,
                              child: Row(
                                children: [
                                  Text(student.from,
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
                                  SvgPicture.asset(
                                      'assets/icons/flags/${student.fromFlag}.svg',
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
                                  Text(student.to,
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
                                  SvgPicture.asset(
                                      'assets/icons/flags/${student.toFlag}.svg',
                                      height: 15)
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 30.0, bottom: 0.0),
                child: Text(
                  'About me',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, left: 30.0, bottom: 0.0, right: 300),
                child: Divider(
                  height: 15,
                  thickness: 2,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 5.0),
                child: Text(
                  student.bio,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),

              student.video == null
                  ? SizedBox.shrink()
                  : SizedBox(
                      height: 40,
                    ),

              student.video == null
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 30.0, bottom: 0.0),
                      child: Text(
                        'Dutchie',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

              //video Europa

              student.video == null
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: NativeVideo(url: student.video!),
                    ),

              SizedBox(
                height: 40,
              ),
            ],
          )
        ],
      ),
    );
  }
}
