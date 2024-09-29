// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/pages/contributors_details_page.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/settings/presentation/pages/models/contributor.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';
import 'package:rotary_nl_rye/features/widgets/list_tiles.dart';

class ContributorsPage extends StatefulWidget {
  @override
  _ContributorsPageState createState() => _ContributorsPageState();
}

class _ContributorsPageState extends State<ContributorsPage> {
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
          'Contributors',
          style: TextStyle(
              color: Palette.indigo, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemBuilder: (context, index) => ContributorsListTile(
            item: contributors[index],
            contributorsDetailsPage:
                ContributorsDetails(person: contributors[index]),
          ),
          itemCount: contributors.length,
        ),
      ),
    );
  }
}

final List<Contributor> contributors = [
  Contributor(
    name: 'Ruben Talstra',
    description: 'Flutter Dev',
    place: 'Netherlands',
    bio:
        'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.',
    imageUrl:
        'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/test/1.PNG',
    githubUrl: '',
    instagramUrl: '',
    websiteUrl: '',
    linkedinUrl: '',
    email: 'ruben@example.com',
    phoneNumber: '888 444 7676',
  ),
  Contributor(
    name: '_Bnkn_',
    description: 'Flutter Dev',
    place: 'Germany',
    bio:
        'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.',
    imageUrl:
        'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/test/2.PNG',
    githubUrl: '',
    instagramUrl: '',
    websiteUrl: '',
    linkedinUrl: '',
    email: 'bnkn@example.com',
    phoneNumber: '888 444 7676',
  ),
  Contributor(
    name: 'Believer',
    description: 'Flutter Dev',
    place: 'India',
    bio:
        'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.',
    imageUrl:
        'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/test/3.PNG',
    githubUrl: '',
    instagramUrl: '',
    websiteUrl: '',
    linkedinUrl: '',
    email: 'believer@example.com',
    phoneNumber: '888 444 7676',
  ),
  Contributor(
    name: 'Frosted Fox',
    description: 'Flutter Dev',
    place: 'Netherlands',
    bio:
        'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.',
    imageUrl:
        'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/test/1.PNG',
    githubUrl: '',
    instagramUrl: '',
    websiteUrl: '',
    linkedinUrl: '',
    email: 'frostedfox@example.com',
    phoneNumber: '888 444 7676',
  ),
];
