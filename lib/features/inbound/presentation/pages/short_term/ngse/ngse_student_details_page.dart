// 🐦 Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/full_screen_image.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StudentDetailPage extends StatelessWidget {
  final String name;
  final String country;
  final String combinedText;
  final String imagePath;

  StudentDetailPage({
    required this.name,
    required this.country,
    required this.combinedText,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: BackButton(),
        title: Text(
          name,
          style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Country: $country',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              buildRichTextWithLinks(combinedText), // Combined bio + details
              SizedBox(height: 20),
              buildProfileImage(
                  context), // Use your buildProfileImage method here
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileImage(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) =>
                FullScreenImage(url: imagePath)));
      },
      child: CachedNetworkImage(
        imageUrl: imagePath,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit
                  .contain, // Ensures the entire image is visible without cropping
            ),
          ),
          constraints: BoxConstraints(
            maxHeight: 200, // Define max height for the image
            maxWidth:
                MediaQuery.of(context).size.width, // Use the full screen width
          ),
        ),
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Widget buildRichTextWithLinks(String text) {
    final RegExp emailRegex = RegExp(
        r'([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})'); // Regex for email
    final RegExp urlRegex =
        RegExp(r'(https?:\/\/[^\s]+)'); // Regex for URLs (HTTP/HTTPS)

    List<TextSpan> spans = [];
    int start = 0;

    // Find all matches for both email and URL
    final matches = [
      ...emailRegex.allMatches(text),
      ...urlRegex.allMatches(text),
    ]..sort(
        (a, b) => a.start.compareTo(b.start)); // Sort matches by start index

    for (final match in matches) {
      if (match.start > start) {
        spans.add(TextSpan(
          text: text.substring(start, match.start), // Text before the link
          style: TextStyle(color: Colors.black),
        ));
      }

      final matchedText = match.group(0);
      if (matchedText != null) {
        if (emailRegex.hasMatch(matchedText)) {
          spans.add(TextSpan(
            text: matchedText,
            style: TextStyle(
                color: Colors.blue, decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () => launchUrlString('mailto:$matchedText'),
          ));
        } else if (urlRegex.hasMatch(matchedText)) {
          spans.add(TextSpan(
            text: matchedText,
            style: TextStyle(
                color: Colors.blue, decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () => launchUrlString(matchedText),
          ));
        }
      }
      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start), // Remaining text after last link
        style: TextStyle(color: Colors.black),
      ));
    }

    return RichText(
      text: TextSpan(
        children: spans,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
