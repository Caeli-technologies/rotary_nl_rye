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
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class StoriesDisplay extends StatelessWidget {
  final ExchangeStudent student;

  StoriesDisplay({required this.student});

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
          style: TextStyle(
              color: Palette.indigo, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        children: [
          _buildStudentHeader(context),
          const SizedBox(height: 20),
          _buildSectionTitle('About me'),
          const Divider(height: 15, thickness: 2),
          const SizedBox(height: 5),
          Text(student.bio, style: TextStyle(fontSize: 16.0)),
          if (student.video != null) ...[
            const SizedBox(height: 40),
            _buildSectionTitle('Dutchie'),
            const SizedBox(height: 10),
            NativeVideo(url: student.video!),
          ],
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildStudentHeader(BuildContext context) {
    return Row(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(60),
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) =>
                  FullScreenImage(url: student.imageUrl),
            ));
          },
          child: CachedNetworkImage(
            height: 60,
            width: 60,
            imageUrl: student.imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              student.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(student.from,
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[600])),
                const SizedBox(width: 2),
                SvgPicture.asset('assets/icons/flags/${student.fromFlag}.svg',
                    height: 15),
                const SizedBox(width: 5),
                FaIcon(FontAwesomeIcons.arrowRightLong, color: Colors.grey),
                const SizedBox(width: 5),
                Text(student.to,
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[600])),
                const SizedBox(width: 2),
                SvgPicture.asset('assets/icons/flags/${student.toFlag}.svg',
                    height: 15),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.grey[600], fontSize: 18.0, fontWeight: FontWeight.bold),
    );
  }
}
