import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class DynamicLinks extends StatefulWidget {
  @override
  _DynamicLinksState createState() => _DynamicLinksState();
}

class _DynamicLinksState extends State<DynamicLinks>
    with WidgetsBindingObserver {
  String? _linkMessage;
  bool _isCreatingLink = false;

  @override
  void initState() {
    super.initState();
    this._initDynamicLinks();
  }

  Future<void> _initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;

      if (deepLink != null) {
        Navigator.pushNamed(context, deepLink.path);
      }
    }, onError: (OnLinkErrorException e) async {
      Navigator.pushNamed(context, '/error');
    });

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      Navigator.pushNamed(context, deepLink.path);
    }
  }

  Future<void> _createDynamicLink() async {
    setState(() {
      _isCreatingLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://rotarytestnl.page.link',
      link: Uri.parse('https://rotarytestnl.page.link/helloworld'),
      androidParameters: AndroidParameters(
        packageName: 'com.caelitechnologies.rotary_nl_rye',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.caelitechnologies.rotary-nl-rye',
        minimumVersion: '1',
        appStoreId: '1567096118',
      ),
    );

    Uri url;
    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    url = shortLink.shortUrl;

    setState(() {
      _linkMessage = url.toString();
      _isCreatingLink = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Woolha.com Flutter Tutorial'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed:
                      !_isCreatingLink ? () => _createDynamicLink() : null,
                  child: const Text('Get Short Link'),
                ),
              ],
            ),
            InkWell(
              onTap: () async {
                if (_linkMessage != null) {
                  await launch(_linkMessage!);
                }
              },
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
