import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rotary_nl_rye/core/prop.dart';

class NGSEProgramPage extends StatefulWidget {
  @override
  _NGSEProgramPageState createState() => _NGSEProgramPageState();
}

class _NGSEProgramPageState extends State<NGSEProgramPage> {
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
        title: Text(
          "NGSE",
          textScaleFactor: 1,
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 16, top: 15, right: 16),
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "NGSE: deelnemen",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "NGSE behoort tot de vijfde service avenue van Rotary International, net als de Internationale Jeugduitwisselingen, Interact, Rotaract en RYLA.",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "NGSE (New Generations Service Exchange) is een relatief nieuw Rotary uitwisselingsprogramma voor jonge volwassenen tussen de 18 en 30 jaar. Het is bedoeld voor jongeren die graag ervaring willen opdoen in het buitenland. Dit kan zijn als onderdeel van hun studie of als (meekijk) stage. Maar ook kan het worden ingezet om werkervaring op te doen buiten Nederland. De nadruk bij NGSE ligt op vocational en service-activiteiten. Deze kunnen ook via de clubactiviteiten van de Rotary Club ter plaatse (hostclub) worden uitgeoefend. Dankzij de NGSE leert de uitgezonden jongere over het leven in een ander land, over andere onderwijssystemen en andere arbeidsculturen. Voor jonge volwassenen vergroot dit hun wereld en hun netwerk. Door ideeën uit te wisselen en geïnspireerd te raken ontwikkelen zij ook hun kijk op de wereld (en op hun eigen zelfbeeld.) Zelfstandigheid, zelfvertrouwen en leiderschap kunnen hierdoor groeien.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "AANMELDEN - UITZENDEN EN ONTVANGEN DOOR NGSE & ROTARY CLUBS",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Voor deze vorm van uitwisseling is geen wederkerigheid vereist. Een kandidaat kan zich bij een Rotary Club (sponsorclub) in zijn buurt aanmelden of rechtstreeks bij de NGSE-coördinator. De uitzendende Rotary Club mag financieel bijdragen, maar hoeft dat niet te doen. De NGSEcoördinator gaat op zoek naar een passende gastclub (hostclub) in het buitenland. Die hostclub en de kandidaat gaan samen op zoek naar een passend gastgezin of passende woonruimte en indien van toepassing, ook een passende onderwijsinstelling of werkgever. Als tegenprestatie houdt de uitgezonden jongere contact met de hostclub en helpt die club bij serviceprojecten, vocational projecten of andere humanitaire acties. Zo ontstaan soms wel levenslange contacten en vriendschappen. De hostclub kan natuurlijk ook zelf een jongvolwassene uitsturen naar Nederland en rekenen op de gastvrijheid van de sponsorclub van de uitgezonden Nederlandse NGSE-jongere. Maar dit is geen vanzelfsprekende zaak.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Iedere Rotary Club kan zichzelf ook aanmelden om als ‘host’ of gastclub te fungeren, ook al is er nog geen aanmelding vanuit het buitenland.",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "DUUR VAN UITWISSELING & KOSTEN",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "De duur van deze NGSE uitwisseling is variabel, maar bij werkervaringsstages geldt een maximum van drie maanden. Een visumaanvraag is veelal niet nodig of eenvoudig. Langere periodes (tot maximaal 6 maanden) zijn bespreekbaar afhankelijk van het gastland. De studie of stageplek voor de kandidaat moet geregeld zijn vóór de aankomst van de kandidaat in het gastland. Alle kosten zijn voor de kandidaat: reis, visum, inentingen, studie en verzekeringen.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Bij inschrijving betaalt de kandidaat aan NGSE € 50,00. Wanneer de kandidaat daadwerkelijk wordt uitgezonden komen daar nog bemiddelingskosten bij. Die worden ingeschat op circa € 300,00.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),

              // the end dont touch XD
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Center(
                  child: Image.asset(
                    'assets/image/rotary_blue.png',
                    height: 55.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Center(
                  child: Text(
                    'Update: 20 oktober 2020',
                    style: TextStyle(color: Color(0xFF777777)),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],
          )
        ],
      ),
    );
  }
}
