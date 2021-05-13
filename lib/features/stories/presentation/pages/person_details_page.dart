import 'package:flutter/material.dart';
import 'package:rotary_nl_rye/core/prop.dart';

class PersonDetails extends StatelessWidget {
  final person;
  const PersonDetails({required this.person});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Container(
          margin: EdgeInsets.only(left: 10, top: 5),
          width: 40,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
          child: RawMaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: new Icon(
              Icons.arrow_back,
              color: Palette.accentColor,
              size: 30.0,
            ),
            shape: new CircleBorder(),
            elevation: 2.0,
            fillColor: Palette.themeShadeColor,
            padding: const EdgeInsets.all(5.0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                child: CircleAvatar(
                  backgroundImage: AssetImage(person.imageUrl),
                  radius: 100,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Palette.themeShadeColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(40.0),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      person.name,
                      textAlign: TextAlign.center,
                      textScaleFactor: 2,
                      style: TextStyle(
                        color: Palette.indigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    IntrinsicHeight(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              person.description,
                              textAlign: TextAlign.center,
                            ),
                            VerticalDivider(
                              thickness: 2,
                              width: 20,
                              color: Colors.grey,
                            ),
                            Text(
                              person.place,
                              textAlign: TextAlign.center,
                            )
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone),
                        SizedBox(
                          width: 5,
                        ),
                        Text(person.phoneNumber),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.email),
                        SizedBox(
                          width: 5,
                        ),
                        Text(person.email)
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "About",
                textAlign: TextAlign.center,
                textScaleFactor: 2,
                style: TextStyle(
                  color: Palette.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Text(person.bio),
              SizedBox(
                height: 20,
              ),
              // TODO optional params
              /*person.exchangeInfo.length == null
                  ? SizedBox.shrink()
                  : Text(
                      "Travelled to: ${person.exchangeInfo["place"]} between ${person.exchangeInfo["travelDates"][0]}-${person.exchangeInfo["travelDates"][1]}")
            */],
          ),
        ),
      ),
    );
  }
}
