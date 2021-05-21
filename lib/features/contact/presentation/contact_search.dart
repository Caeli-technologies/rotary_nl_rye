// @dart=2.9
import 'package:flutter/material.dart';

import 'models/organization.dart';

class ContactSearch extends SearchDelegate {
  List<Organization> contactPlayers;
  String selectedResult;

  ContactSearch(this.contactPlayers);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Organization> suggestedContactPlayers = [];
    query.isEmpty
        ? suggestedContactPlayers = contactPlayers
        // ignore: unnecessary_statements
        : suggestedContactPlayers.addAll;

    return ListView.builder(
        itemCount: suggestedContactPlayers.length,
        itemBuilder: (context, position) => ListTile(
              title: Text(suggestedContactPlayers[position].toString()),
            ));
  }
}
