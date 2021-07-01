import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/native_video.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/calendar/presentation/pages/events_page.dart';
import 'package:url_launcher/url_launcher.dart';

class LongTermExchangeProgramPage extends StatefulWidget {
  @override
  _LongTermExchangeProgramPageState createState() =>
      _LongTermExchangeProgramPageState();
}

class _LongTermExchangeProgramPageState
    extends State<LongTermExchangeProgramPage> {
  @override
  initState() {
    super.initState();
  }

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
          "Long Term Exchange Program",
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
                  "WAT HOUDT DAT IN?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Dit programma van Rotary International is bestemd voor alle hierin geïnteresseerde scholieren uit het Voortgezet Onderwijs. Het is de bedoeling dat je in het buitenland een jaar High School volgt. Omgekeerd komen buitenlandse scholieren hier om gedurende een jaar samen met leeftijdgenoten naar school te gaan.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Zit je op VWO, HAVO of VMBO dan kun je na selectie voor deze uitwisseling in aanmerking komen. Je hebt wel een Rotaryclub nodig die jou wil voordragen: een Sponsorclub. Dat betekent uiteraard niet dat de club jouw kosten betaalt. Nee, de club is verantwoordelijk voor de terug ontvangst van een jaarkind uit het buitenland.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  "Een diploma is geen vereiste om je op te geven; je kunt ook je schoolprogramma onderbreken. Soms is dat zelfs een voordeel. In het buitenland worden namelijk vaak strenge leeftijdsgrenzen gesteld om tot een school te worden toegelaten. En om deel te kunnen nemen aan de schoolsporten is het soms beter om nog geen diploma te hebben.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: NativeVideo(
                    url:
                        "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/videos/promo/Rotary_Promo_Short.mp4"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "VOOR WIE?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Voor de uitzending gelden indicatieve leeftijdsgrenzen, in principe 15,5-18,5 jaar. De leeftijdsgrens geldt voor overheidsscholen, soms is er enige rek mogelijk.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Als je ouder bent zijn de mogelijkheden kleiner; je kunt het echter altijd vragen.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Kandidaten dienen deel te nemen aan een selectiedag in oktober en een selectieweekend in november.",
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
                        text: 'Voor de datum van deze dagen zie de ',
                      ),
                      TextSpan(
                        text: 'agenda',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CalendarPage()),
                            );
                          },
                      ),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Op basis van de beoordeling na de selectiedagen wordt uitgenodigd aan het programma deel te nemen. Er is een verplichte informatiedag in april en juni, waarbij ook je ouders aanwezig dienen te zijn.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "MET WELKE LANDEN?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "De commissie jaaruitwisseling probeert een zo groot mogelijke spreiding in de bestemmingen te realiseren omdat daardoor ook de groep scholieren in Nederland een grote spreiding in nationaliteiten en culturen zal hebben.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "In de hieronder genoemde landen wordt uitgewisseld met één of meer districten. Van jaar tot jaar kunnen die districten veranderen. De informatie per land is nog niet ingevuld.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "NOORDELIJK HALFROND",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "USA, Canada, India, Indonesie, Japan, Thailand, Taiwan",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Europa: Frankrijk. Italie, Finland en Zweden, Spanje, Turkije",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                child: Text(
                  "Op exchange dicht bij huis, duurzaam reizen en toch een andere cultuur & taal? Geniet van wat Europa jou kan bieden!",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              //video Europa
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: NativeVideo(
                    url:
                        "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/videos/promo/proud_to_be_European.mp4"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "ZUIDELIJK HALFROND",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Brazilie, Chili, Argentinie, Mexico, Ecuador, Peru, Mexico, Australie, Nieuw Zeeland, Zuid Afrika",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "AANMELDEN?",
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
                            'Zie aanmelden (zie menu balk bovenaan deze pagina). Inlichtingen bij de coördinator van het programma Barbara Tusveld ',
                      ),
                      TextSpan(
                        text: 'longtermchair@rotaryyep.nl.',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch("mailto:longtermchair@rotaryyep.nl");
                          },
                      ),
                    ])),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "KOSTEN?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "De kosten voor de jongere bedragen vanaf € 2.400,-- incl. zakgeld exclusief ticket en andere onkosten.",
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
                    'Update: 20 juli 2020',
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

  @override
  void dispose() {
    super.dispose();
  }
}
