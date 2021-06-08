import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

const APP_STORE_URL =
    'https://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=1567096118&mt=8';
const PLAY_STORE_URL =
    'https://play.google.com/store/apps/details?id=com.caelitechnologies.rotary_nl_rye';

versionCheck(context) async {
  //Get Current installed version of app
  final PackageInfo info = await PackageInfo.fromPlatform();
  double currentVersion = double.parse(info.version.trim().replaceAll(".", "") +
      info.buildNumber.trim().replaceAll(".", ""));

  //Get Latest version info from firebase config
  final RemoteConfig remoteConfig = await RemoteConfig.instance;

  try {
    // Using default duration to force fetching from remote server.
    await remoteConfig.fetchAndActivate();
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 0),
      minimumFetchInterval: Duration(hours: 1), // caches fetch for 1 hour
    ));
    // Version + build
    String forceUpdateCurrentVersion =
        remoteConfig.getString('force_update_current_version');
    // print("forceUpdateCurrentVersion: $forceUpdateCurrentVersion");
    String forceUpdateCurrentBuild =
        remoteConfig.getString('force_update_current_build');
    // print("forceUpdateCurrentBuild: $forceUpdateCurrentBuild");

    double newVersion = double.parse(
        forceUpdateCurrentVersion.trim().replaceAll(".", "") +
            forceUpdateCurrentBuild.trim().replaceAll(".", ""));

    print("Firebase Version: $newVersion - currentVersion: $currentVersion");

    // print("newVersion: $newVersion");
    if (newVersion > currentVersion) {
      _showVersionDialog(context);
    }
  } on PlatformException catch (exception) {
    // Fetch throttled.
    print(exception);
  } catch (exception) {
    print('EXCEPTION: $exception');
    print('Unable to fetch remote config. Cached or default values will be '
        'used');
  }
}

//Show Dialog to force user to update
_showVersionDialog(context) async {
  await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      String title = "New Update Available";
      String message =
          "There is a newer version of app available please update it now.";
      String btnLabel = "Update Now";
      String btnLabelCancel = "Later";
      return Platform.isIOS
          ? new CupertinoAlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  child: Text(btnLabel),
                  onPressed: () => _launchURL(APP_STORE_URL),
                ),
                TextButton(
                  child: Text(btnLabelCancel),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            )
          : new AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  child: Text(btnLabel),
                  onPressed: () => _launchURL(PLAY_STORE_URL),
                ),
                TextButton(
                  child: Text(btnLabelCancel),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
    },
  );
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
