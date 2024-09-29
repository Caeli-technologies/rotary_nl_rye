// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/domain/StudentsBloc.dart';
import 'package:rotary_nl_rye/core/domain/entities/exchange_student.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/rebounds/models/country.dart';
import 'package:rotary_nl_rye/features/rebounds/presentation/pages/ExchangeStudentsList.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';
import 'package:rotary_nl_rye/features/widgets/list_tiles.dart';

class CountriesPage extends StatefulWidget {
  @override
  _CountriesPageState createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  final studentBloc = StudentsBloc();

  @override
  void initState() {
    super.initState();
    studentBloc.getExchangeStudentList();
  }

  @override
  void dispose() {
    studentBloc.dispose();
    super.dispose();
  }

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
          'Countries',
          style: TextStyle(
              color: Palette.indigo, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: StreamBuilder<List<ExchangeStudent>>(
        stream: studentBloc.studentList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            final sortedCountries = countries
              ..sort((a, b) => a.name.compareTo(b.name));
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: sortedCountries.length,
              itemBuilder: (context, index) {
                final country = sortedCountries[index];
                final students = snapshot.data!
                    .where((student) => student.to == country.name)
                    .toList();
                return CountryListTile(
                  country: country,
                  descriptionPage: ExchangeStudentsList(
                      country: country, students: students),
                );
              },
            );
          }
        },
      ),
    );
  }
}

final List<Country> countries = [
  Country(
      name: 'Argentina',
      imageUrl: 'assets/icons/flags/ar.svg',
      description: ''),
  Country(
      name: 'Australia',
      imageUrl: 'assets/icons/flags/au.svg',
      description: ''),
  Country(
      name: 'Brazil', imageUrl: 'assets/icons/flags/br.svg', description: ''),
  Country(
      name: 'Canada', imageUrl: 'assets/icons/flags/ca.svg', description: ''),
  Country(
      name: 'Chili', imageUrl: 'assets/icons/flags/cl.svg', description: ''),
  Country(
      name: 'Colombia', imageUrl: 'assets/icons/flags/co.svg', description: ''),
  Country(
      name: 'Ecuador', imageUrl: 'assets/icons/flags/ec.svg', description: ''),
  Country(
      name: 'Finland', imageUrl: 'assets/icons/flags/fi.svg', description: ''),
  Country(
      name: 'India', imageUrl: 'assets/icons/flags/in.svg', description: ''),
  Country(
      name: 'Indonesia',
      imageUrl: 'assets/icons/flags/id.svg',
      description: ''),
  Country(
      name: 'Italy', imageUrl: 'assets/icons/flags/it.svg', description: ''),
  Country(
      name: 'Japan', imageUrl: 'assets/icons/flags/jp.svg', description: ''),
  Country(
      name: 'Mexico', imageUrl: 'assets/icons/flags/mx.svg', description: ''),
  Country(
      name: 'New Zealand',
      imageUrl: 'assets/icons/flags/nz.svg',
      description: ''),
  Country(name: 'Peru', imageUrl: 'assets/icons/flags/pe.svg', description: ''),
  Country(
      name: 'South Africa',
      imageUrl: 'assets/icons/flags/za.svg',
      description: ''),
  Country(
      name: 'South Korea',
      imageUrl: 'assets/icons/flags/kr.svg',
      description: ''),
  Country(
      name: 'Taiwan', imageUrl: 'assets/icons/flags/tw.svg', description: ''),
  Country(
      name: 'Thailand', imageUrl: 'assets/icons/flags/th.svg', description: ''),
  Country(name: 'USA', imageUrl: 'assets/icons/flags/us.svg', description: ''),
  Country(
      name: 'Spain', imageUrl: 'assets/icons/flags/es.svg', description: ''),
  Country(
      name: 'Europa', imageUrl: 'assets/icons/flags/eu.svg', description: ''),
  Country(
      name: 'Switzerland',
      imageUrl: 'assets/icons/flags/ch.svg',
      description: ''),
  Country(
      name: 'France', imageUrl: 'assets/icons/flags/fr.svg', description: ''),
];
