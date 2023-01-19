// 🎯 Dart imports:
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/lang/languages.dart';
import 'package:rotary_nl_rye/core/presentation/uniform_widgets/rotary_list_view.dart';
import 'package:rotary_nl_rye/core/presentation/uniform_widgets/share_widget.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/photo_gallery/gallery_view.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/settings/presentation/pages/contributors_page.dart';
import 'package:rotary_nl_rye/features/settings/presentation/pages/social.dart';
import 'package:rotary_nl_rye/features/settings/presentation/widgets/settings_option.dart';
import 'package:rotary_nl_rye/features/settings/presentation/widgets/settings_section.dart';
import 'package:rotary_nl_rye/injection_container.dart';
import '../../../../core/presentation/uniform_widgets/footer_note.dart';
import '../../../../core/presentation/uniform_widgets/rotary_scaffold.dart';
import '../widgets/settings_footer_link.dart';
import '../widgets/settings_switch.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return RotaryScaffold(
      title: DemoLocalizations.of(context)!.trans('settingsTitle'),
      returnButtonShown: false,
      actions: <Widget>[
        ShareWidget(
          text: Platform.isIOS
              ? 'https://apps.apple.com/app/rotary-youth-exchange-nl/id1567096118'
              : 'https://play.google.com/store/apps/details?id=com.caelitechnologies.rotary_nl_rye',
          subject: 'Checkout this nice app :)',
        )
      ],
      body: RotaryListView(
        listTiles: [
          SettingsSection(
            title: 'Account',
            options: [
              SettingsOption(
                title: 'Pictures',
                leadingIcon: FontAwesomeIcons.images,
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Palette.grey,
                ),
                action: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GalleryViewPage()),
                ),
              ),
              SettingsOption(
                title: DemoLocalizations.of(context)!.trans('social'),
                leadingIcon: FontAwesomeIcons.hashtag,
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Palette.grey,
                ),
                action: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SocialPage()),
                ),
              ),
              // TODO persist state of switch
              SettingsOption(
                title: 'Auto load video\'s',
                leadingIcon: FontAwesomeIcons.wifi,
                trailing: SettingsSwitch(
                  defaultValue: false,
                ),
              ),
            ],
          ),
          SettingsSection(
            title: 'Development',
            options: [
              SettingsOption(
                title: 'Contributors',
                leadingIcon: FontAwesomeIcons.code,
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Palette.grey,
                ),
                action: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContributorsPage()),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SettingsFooterLink(
                title: 'Privacy Policy',
                path: '/yep/yep-app/privacy-policy.html',
              ),
              SettingsFooterLink(
                title: 'Terms & Conditions',
                path: '/yep/yep-app/terms-and-conditions.html',
              ),
            ],
          ),
          FooterNote(
            text:
                'App version: ${packageInfo.version} (${packageInfo.buildNumber})',
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
