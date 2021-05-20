import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:url_launcher/url_launcher.dart';

class CampsAndToursProgramPage extends StatefulWidget {
  @override
  _CampsAndToursProgramPageState createState() =>
      _CampsAndToursProgramPageState();
}

class _CampsAndToursProgramPageState extends State<CampsAndToursProgramPage> {
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
        title: Text(
          "Camps & Tours",
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
                  "CAMPS & TOURS: deelnemen",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "Wat houdt dat in?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Heel veel Europese landen organiseren in de periode van juni t/m september Zomer Tours en speciale kampen, zoals zeil-, ski- en sportkampen. De laatste jaren worden er ook Zomerkampen in Canada, V.S. en Taiwan georganiseerd. Er worden groepen van 10 à 20 deelnemers gevormd met een zo groot mogelijke spreiding van nationaliteiten. Deze groepen zijn te gast bij Rotaryclubs die een informatief, toeristisch of sportief programma organiseren. Meestal verblijft men in (Rotary)gezinnen of hostels waarbij Rotarians de leiding hebben. De belangstelling is doorgaans groter dan het aantal beschikbare plaatsen, dus stuur z.s.m. jouw aanmelding in!.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "Voor wie?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "De leeftijd van de deelnemers varieert van 15 - 21 jaar. Deelname is mogelijk voor jongeren van Rotarians en van niet-Rotarians.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "Met welke landen?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Europese landen, maar ook Canada, VS en Taiwan.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "Aanmelden?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: RichText(
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 13),
                        children: [
                      TextSpan(
                        text:
                            'Door de buitenlandse organisator worden uitnodigingen aan de MDJC (= Multi District Jeugdzaken Commissie van Rotary) gestuurd om een jongen of meisje van een bepaalde leeftijd en in een speciale periode aan hun Camp of Tour te laten deelnemen. Deze uitnodigingen worden direct na ontvangst op de site ',
                      ),
                      TextSpan(
                        text: 'rotaryyep.nl/zomerkampen',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch("http://rotaryyep.nl/zomerkampen");
                          },
                      ),
                      TextSpan(
                        text:
                            ' geplaatst ter info. Je treft deze op de site aan vanaf half januari t/m begin mei. Dus hier vind je steeds het meest actuele aanbod over de Camps & Tours uit de deelnemende landen. Je kunt de coördinator ook direct laten weten als je interesse hebt om deel te nemen aan een bepaald Camp of Tour. Aanmelden via links op deze ',
                      ),
                      TextSpan(
                        text: 'pagina.',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch(
                                "http://rotaryyep.nl/campsandtours/outbound");
                          },
                      ),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Hierop moet duidelijk worden:",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "- Wie jouw sponsor-Rotary Club is;",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "- De periode waarin je beschikbaar bent;",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "- De landen waarnaar je voorkeur uitgaat. (Als er geen speci­fieke voor­keur is en elk Europees land goed is, kan dit vermeld worden.)",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "De coördinator koppelt de aanmeldingen aan de uitnodigingen en stuurt de deelnemers bericht.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: RichText(
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 13),
                        children: [
                      TextSpan(
                        text: 'Dringend verzoek: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            'gelieve bij aanmelding op te geven of men zich ook heeft aangemeld voor andere reizen of kampen',
                      ),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: RichText(
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 14),
                        children: [
                      TextSpan(
                        text:
                            'De CJC van de sponsorclub stuurt het aanmeldingsformulier naar de outboundcoördinator: ',
                      ),
                      TextSpan(
                        text: 'zomerkamp@rotaryyep.nl',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch("mailto:zomerkamp@rotaryyep.nl");
                          },
                      ),
                    ])),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "Aanmelden?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "De kosten voor aanmelding zijn € 100.-. * (kosten kunnen per jaar verschillen) \n\nDe aanmelding staat open tot mei. \n\nNaast het inschrijfgeld moet men rekening houden met de volgende kosten:",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "- Reiskosten naar de plaats waar het kamp wordt gehouden.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "- Zakgeld ter plaatse.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "- Een enkele Rotary Club in het buitenland vraagt wel eens een klein deelnamebedrag (dit staat steeds in de uitnodiging vermeld.)",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  "Waarom doen we dit?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "- Het opbouwen van goede relaties met andere landen",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "- Het houdt de club jong",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "- De jongere ontwikkelt zichzelf en zijn/haar omgeving",
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
                    'Update: 26 augustus 2019',
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
