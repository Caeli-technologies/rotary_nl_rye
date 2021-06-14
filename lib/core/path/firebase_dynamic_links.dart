import 'dart:async';
import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/settings/presentation/pages/social.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DynamicLinks extends StatefulWidget {
  @override
  _DynamicLinksState createState() => _DynamicLinksState();
}

class _DynamicLinksState extends State<DynamicLinks>
    with WidgetsBindingObserver {
  String? _linkMessage;
  bool _isCreatingLink = false;
  late String pathName, id, name;

  @override
  void initState() {
    super.initState();
    // this._initDynamicLinks();
    // this._createDynamicLink(id, name);
  }

//   Future<void> _initDynamicLinks() async {
//     FirebaseDynamicLinks.instance.onLink(
//         onSuccess: (PendingDynamicLinkData? dynamicLink) async {
//       final Uri? deepLink = dynamicLink?.link;

//       if (deepLink != null) {
//         Navigator.pushNamed(context, deepLink.path);
// // ignore: unnecessary_statements

//         if (deepLink.queryParameters.containsKey('id')) {
//           String? id = deepLink.queryParameters['id'];
//           String? name = deepLink.queryParameters['name'];
//           Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => SocialPage(id: id, name: name)));

//           // Navigator.pushNamed(BuildContext context) => SocialPage(id: id, name: name);
//         }
//       }
//     }, onError: (OnLinkErrorException e) async {
//       Navigator.pushNamed(context, '/error');
//     });

//     final PendingDynamicLinkData? data =
//         await FirebaseDynamicLinks.instance.getInitialLink();
//     final Uri? deepLink = data?.link;

//     if (deepLink != null) {
//       if (deepLink.queryParameters.containsKey('name')) {
//         String? id = deepLink.queryParameters['id'];
//         String? name = deepLink.queryParameters['name'];
//         Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => SocialPage(id: id, name: name)));

//         // Navigator.pushNamed(BuildContext context) => SocialPage(id: id, name: name);
//       }
//     }
//   }

  Future<void> _createDynamicLink(
      String pathName, String id, String name) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://rotarytestnl.page.link',
      link: Uri.parse(
          'https://rotarytestnl.page.link/$pathName?id=$id&name=$name'), //change this to the url in the main.dart
      androidParameters: AndroidParameters(
        packageName: 'com.caelitechnologies.rotary_nl_rye',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.caelitechnologies.rotary-nl-rye',
        minimumVersion: '1',
        appStoreId: '1567096118',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'Example of a Dynamic Link',
        description: 'This link works whether app is installed or not!',
        imageUrl: Uri.parse(
            'https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/6e/21/e4/6e21e45b-49cb-fa52-83c2-bb56ab288b49/AppIcon-0-0-1x_U007emarketing-0-0-0-4-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.jpeg/1200x630wa.png'),
      ),
    );

    Uri url;
    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    url = shortLink.shortUrl;

    setState(() {
      _linkMessage = url.toString();
    });
  }

  @override
  void dispose() {
    // ignore: unnecessary_statements
    _linkMessage;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Links test page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              CupertinoIcons.share,
              color: Palette.indigo,
            ),
            onPressed: _createShareURL,
          )
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              // onTap: () async {
              //   if (_linkMessage != null) {
              //     await launch(_linkMessage!);
              //   }
              // },
              onLongPress: () {
                Clipboard.setData(ClipboardData(text: _linkMessage));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Copied Link!')),
                );
              },
              child: Text(
                _linkMessage ?? '',
                style: const TextStyle(color: Colors.blue),
              ),
            ),
            Text(_linkMessage == null ? '' : '')
            ////
          ],
        ),
      ),
    );
  }

  _createShareURL() async {
    _createDynamicLink(
        pathName = 'error', id = 'id_test_1', name = 'name_test_2');

    if (await canLaunch(_linkMessage!)) {
      await Share.share(
          Platform.isIOS
              ? 'Hier mot nog een leuk stukje komen. + de link naar de juiste pagina $_linkMessage' // iOS
              : 'Hier mot nog een leuk stukje komen. + de link naar de juiste pagina $_linkMessage', //android
          subject: 'look at this nice app :)');
    } else {
      throw 'Could not launch $_linkMessage';
    }
  }
}

class DynamicLinkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hello World DeepLink'),
        ),
        body: const Center(
          child: Text('Hello, World!'),
        ),
      ),
    );
  }
}

class HelloWorld extends StatelessWidget {
  String _linkData;

  HelloWorld(this._linkData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('$_linkData'),
      ),
    );
  }
}

class TutorialsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello World DeepLink'),
      ),
      body: const Center(
        child: const Text('Tutorials Page'),
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello World DeepLink error'),
      ),
      body: const Center(
        child: const Text('Error Page'),
      ),
    );
  }
}
