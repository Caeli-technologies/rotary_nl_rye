// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/domain/entities/news.dart';
import 'package:rotary_nl_rye/core/domain/news.dart';
import 'package:rotary_nl_rye/core/presentation/pages/pdf_viewer_share.dart';
import 'package:rotary_nl_rye/features/news/presentation/pages/non_pdf_news.dart';
import 'package:rotary_nl_rye/features/news/presentation/widgets/pdf_viewer.dart';
import 'package:rotary_nl_rye/features/settings/presentation/pages/SocialPage.dart';

Future<void> initDynamicLinks(BuildContext context) async {
  NewsBloc _repo = NewsBloc();
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  //  "onLink" is when the app is open and on the homescreen.

  dynamicLinks.onLink.listen((dynamicLinkData) async {
    // Navigator.pushNamed(context, dynamicLinkData.link.path);

    final Uri deepLink = dynamicLinkData.link;

    // if (deepLink != null) {
    final uri = deepLink.path;
    print('deepLink.path: $uri ');
    if (deepLink.path == '/helloworld') {
      // final id = deepLink.queryParameters["id"];
      // final name = deepLink.queryParameters["name"];
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SocialPage()));
    }
    if (deepLink.path == '/stories') {
      // final id = deepLink.queryParameters["id"];
      // final name = deepLink.queryParameters["name"];
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SocialPage()));
    }
    if (deepLink.path == '/pdfUrl') {
      String? pdfUrl = deepLink.queryParameters['url'];
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PDFPageWithShare(
                  pdfUrl: pdfUrl!,
                )),
      );
    }

    if (deepLink.path == '/news') {
      String? id = deepLink.queryParameters['id'];
      print('news id $id');
      List<News> _newsList = await _repo.getNewsData();
      print('news fetched ${_newsList[int.parse(id!)].toString()}');
      _newsList[int.parse(id)].isPdf
          ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PDFPage(
                        pdfUrl: _newsList[int.parse(id)].pdf!,
                        data: _newsList[int.parse(id)],
                      )),
            )
          : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NonPDFPage(data: _newsList[int.parse(id)])));
    }
    // still need some work
    Navigator.pushNamed(context, '${deepLink.path}');
    // }
  }).onError((error) {
    print('onLink error');
    Navigator.pushNamed(context, '/error');
  });

//  "getInitialLink" is when the app is closed.
  final PendingDynamicLinkData? data =
      await FirebaseDynamicLinks.instance.getInitialLink();
  final Uri? deepLink = data?.link;

  final uri = deepLink?.path;

  print('deepLink.path: $uri ');
  if (deepLink?.path == '/helloworld') {
    // final id = deepLink?.queryParameters["id"];
    // final name = deepLink?.queryParameters["name"];
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SocialPage()));
  }
  if (deepLink?.path == '/stories') {
    // final id = deepLink?.queryParameters["id"];
    // final name = deepLink?.queryParameters["name"];
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SocialPage()));
  }
  if (deepLink?.path == '/pdfUrl') {
    String? pdfUrl = deepLink?.queryParameters['url'];
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PDFPageWithShare(
                pdfUrl: pdfUrl!,
              )),
    );
  }
  if (deepLink?.path == '/news') {
    String? id = deepLink?.queryParameters['id'];
    List<News> _newsList = await _repo.getNewsData();

    _newsList[int.parse(id!)].isPdf
        ? Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PDFPage(
                    pdfUrl: _newsList[int.parse(id)].pdf!,
                    data: _newsList[int.parse(id)])),
          )
        : Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    NonPDFPage(data: _newsList[int.parse(id)])));
  }
  // still need some work
  // Navigator.pushNamed(context, '${deepLink?.path}');
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

/// Don't delete this under here. some usefull code <3

// class DynamicLinks extends StatefulWidget {
//   @override
//   _DynamicLinksState createState() => _DynamicLinksState();
// }

// class _DynamicLinksState extends State<DynamicLinks>
//     with WidgetsBindingObserver {
//   String? _linkMessage;
//   bool _isCreatingLink = false;
//   late String pathName, id, name;

//   @override
//   void initState() {
//     super.initState();
//     // this._initDynamicLinks();
//     // this._createDynamicLink(id, name);
//   }

// //   Future<void> _initDynamicLinks() async {
// //     FirebaseDynamicLinks.instance.onLink(
// //         onSuccess: (PendingDynamicLinkData? dynamicLink) async {
// //       final Uri? deepLink = dynamicLink?.link;

// //       if (deepLink != null) {
// //         Navigator.pushNamed(context, deepLink.path);
// // // ignore: unnecessary_statements

// //         if (deepLink.queryParameters.containsKey('id')) {
// //           String? id = deepLink.queryParameters['id'];
// //           String? name = deepLink.queryParameters['name'];
// //           Navigator.of(context).push(MaterialPageRoute(
// //               builder: (context) => SocialPage(id: id, name: name)));

// //           // Navigator.pushNamed(BuildContext context) => SocialPage(id: id, name: name);
// //         }
// //       }
// //     }, onError: (OnLinkErrorException e) async {
// //       Navigator.pushNamed(context, '/error');
// //     });

// //     final PendingDynamicLinkData? data =
// //         await FirebaseDynamicLinks.instance.getInitialLink();
// //     final Uri? deepLink = data?.link;

// //     if (deepLink != null) {
// //       if (deepLink.queryParameters.containsKey('name')) {
// //         String? id = deepLink.queryParameters['id'];
// //         String? name = deepLink.queryParameters['name'];
// //         Navigator.of(context).push(MaterialPageRoute(
// //             builder: (context) => SocialPage(id: id, name: name)));

// //         // Navigator.pushNamed(BuildContext context) => SocialPage(id: id, name: name);
// //       }
// //     }
// //   }

//   Future<void> _createDynamicLink(
//       String pathName, String id, String name) async {
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: 'https://rotarynl.page.link',
//       link: Uri.parse(
//           'https://rotarytestnl.page.link/$pathName?id=$id&name=$name'), //change this to the url in the main.dart
//       androidParameters: AndroidParameters(
//         packageName: 'com.caelitechnologies.rotary_nl_rye',
//         minimumVersion: 1,
//       ),
//       iosParameters: IosParameters(
//         bundleId: 'com.caelitechnologies.rotary-nl-rye',
//         minimumVersion: '1',
//         appStoreId: '1567096118',
//       ),
//       socialMetaTagParameters: SocialMetaTagParameters(
//         title: 'Example of a Dynamic Link',
//         description: 'This link works whether app is installed or not!',
//         imageUrl: Uri.parse(
//             'https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/6e/21/e4/6e21e45b-49cb-fa52-83c2-bb56ab288b49/AppIcon-0-0-1x_U007emarketing-0-0-0-4-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.jpeg/1200x630wa.png'),
//       ),
//     );

//     Uri url;
//     final ShortDynamicLink shortLink = await parameters.buildShortLink();
//     url = shortLink.shortUrl;

//     setState(() {
//       _linkMessage = url.toString();
//     });
//   }

//   @override
//   void dispose() {
//     // ignore: unnecessary_statements
//     _linkMessage;
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dynamic Links test page'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(
//               CupertinoIcons.share,
//               color: Palette.indigo,
//             ),
//             onPressed: _createShareURL,
//           )
//         ],
//       ),
//       body: SizedBox(
//         width: double.infinity,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             InkWell(
//               // onTap: () async {
//               //   if (_linkMessage != null) {
//               //     await launch(_linkMessage!);
//               //   }
//               // },
//               onLongPress: () {
//                 Clipboard.setData(ClipboardData(text: _linkMessage));
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Copied Link!')),
//                 );
//               },
//               child: Text(
//                 _linkMessage ?? '',
//                 style: const TextStyle(color: Colors.blue),
//               ),
//             ),
//             Text(_linkMessage == null ? '' : '')
//             ////
//           ],
//         ),
//       ),
//     );
//   }

//   _createShareURL() async {
//     _createDynamicLink(
//         pathName = 'error', id = 'id_test_1', name = 'name_test_2');

//     if (await canLaunch(_linkMessage!)) {
//       await Share.share(
//           Platform.isIOS
//               ? 'Hier mot nog een leuk stukje komen. + de link naar de juiste pagina $_linkMessage' // iOS
//               : 'Hier mot nog een leuk stukje komen. + de link naar de juiste pagina $_linkMessage', //android
//           subject: 'look at this nice app :)');
//     } else {
//       throw 'Could not launch $_linkMessage';
//     }
//   }
// }
