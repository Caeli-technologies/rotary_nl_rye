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

// Future<void> _createDynamicLink(
//     String pathName, String id, String name) async {
//   final DynamicLinkParameters parameters = DynamicLinkParameters(
//     uriPrefix: 'https://rotarytestnl.page.link',
//     link: Uri.parse(
//         'https://rotarytestnl.page.link/$pathName?id=$id&name=$name'), //change this to the url in the main.dart
//     androidParameters: AndroidParameters(
//       packageName: 'com.caelitechnologies.rotary_nl_rye',
//       minimumVersion: 1,
//     ),
//     iosParameters: IosParameters(
//       bundleId: 'com.caelitechnologies.rotary-nl-rye',
//       minimumVersion: '1',
//       appStoreId: '1567096118',
//     ),
//     socialMetaTagParameters: SocialMetaTagParameters(
//       title: 'Example of a Dynamic Link',
//       description: 'This link works whether app is installed or not!',
//       imageUrl: Uri.parse(
//           'https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/6e/21/e4/6e21e45b-49cb-fa52-83c2-bb56ab288b49/AppIcon-0-0-1x_U007emarketing-0-0-0-4-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.jpeg/1200x630wa.png'),
//     ),
//   );

//   Uri url;
//   final ShortDynamicLink shortLink = await parameters.buildShortLink();
//   url = shortLink.shortUrl;

//   setState(() {
//     _linkMessage = url.toString();
//   });
// }

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

//   onLongPress: () {
//   Clipboard.setData(ClipboardData(text: _linkMessage));
//   ScaffoldMessenger.of(context).showSnackBar(
//     const SnackBar(content: Text('Copied Link!')),
//   );
// },
