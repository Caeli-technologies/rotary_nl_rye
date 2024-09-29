// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/rebounds/models/country.dart';
import 'package:rotary_nl_rye/features/rebounds/presentation/pages/ExchangeStudentsList.dart';

class CountryListTile extends StatelessWidget {
  final ExchangeStudentsList descriptionPage;
  final Country country;

  const CountryListTile({
    required this.descriptionPage,
    required this.country,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => descriptionPage),
          );
        },
        contentPadding: EdgeInsets.all(0),
        leading: SvgPicture.asset(
          country.imageUrl,
          // height: 55,
          width: 65,
          fit: BoxFit.contain,
        ),
        title: Text(
          country.name,
          style: TextStyle(color: Palette.indigo),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 30,
          color: Palette.indigo,
        ),
      ),
    );
  }
}
