// 🐦 Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:url_launcher/url_launcher_string.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/widgets/native_video.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/calendar/presentation/pages/events_page.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class LongTermExchangeProgramPage extends StatefulWidget {
  @override
  _LongTermExchangeProgramPageState createState() =>
      _LongTermExchangeProgramPageState();
}

class _LongTermExchangeProgramPageState
    extends State<LongTermExchangeProgramPage> {
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
          'Long Term Exchange Program',
          textScaler: TextScaler.linear(1),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        children: <Widget>[
          buildSectionTitle('WAT HOUDT DAT IN?'),
          buildParagraph(
              'Dit programma van Rotary International is bestemd voor alle hierin geïnteresseerde scholieren uit het Voortgezet Onderwijs. Het is de bedoeling dat je in het buitenland een jaar High School volgt. Omgekeerd komen buitenlandse scholieren hier om gedurende een jaar samen met leeftijdgenoten naar school te gaan.'),
          buildParagraph(
              'Zit je op VWO, HAVO of VMBO dan kun je na selectie voor deze uitwisseling in aanmerking komen. Je hebt wel een Rotaryclub nodig die jou wil voordragen: een Sponsorclub. Dat betekent uiteraard niet dat de club jouw kosten betaalt. Nee, de club is verantwoordelijk voor de terug ontvangst van een jaarkind uit het buitenland.'),
          buildParagraph(
              'Een diploma is geen vereiste om je op te geven; je kunt ook je schoolprogramma onderbreken. Soms is dat zelfs een voordeel. In het buitenland worden namelijk vaak strenge leeftijdsgrenzen gesteld om tot een school te worden toegelaten. En om deel te kunnen nemen aan de schoolsporten is het soms beter om nog geen diploma te hebben.'),
          buildVideo(
              'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/videos/promo/Rotary_Promo_Short.mp4'),
          buildSectionTitle('VOOR WIE?'),
          buildParagraph(
              'Voor de uitzending gelden indicatieve leeftijdsgrenzen, in principe 15,5-18,5 jaar. De leeftijdsgrens geldt voor overheidsscholen, soms is er enige rek mogelijk.'),
          buildParagraph(
              'Als je ouder bent zijn de mogelijkheden kleiner; je kunt het echter altijd vragen.'),
          buildParagraph(
              'Kandidaten dienen deel te nemen aan een selectiedag in oktober en een selectieweekend in november.'),
          buildRichText('Voor de datum van deze dagen zie de ', 'agenda', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalendarPage()),
            );
          }),
          buildParagraph(
              'Op basis van de beoordeling na de selectiedagen wordt uitgenodigd aan het programma deel te nemen. Er is een verplichte informatiedag in april en juni, waarbij ook je ouders aanwezig dienen te zijn.'),
          buildSectionTitle('MET WELKE LANDEN?'),
          buildParagraph(
              'De commissie jaaruitwisseling probeert een zo groot mogelijke spreiding in de bestemmingen te realiseren omdat daardoor ook de groep scholieren in Nederland een grote spreiding in nationaliteiten en culturen zal hebben.'),
          buildParagraph(
              'In de hieronder genoemde landen wordt uitgewisseld met één of meer districten. Van jaar tot jaar kunnen die districten veranderen. De informatie per land is nog niet ingevuld.'),
          buildSectionTitle('NOORDELIJK HALFROND'),
          buildParagraph(
              'USA, Canada, India, Indonesie, Japan, Thailand, Taiwan'),
          buildParagraph(
              'Europa: Frankrijk. Italie, Finland en Zweden, Spanje, Turkije'),
          buildParagraph(
              'Op exchange dicht bij huis, duurzaam reizen en toch een andere cultuur & taal? Geniet van wat Europa jou kan bieden!'),
          buildVideo(
              'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/videos/promo/proud_to_be_European.mp4'),
          buildSectionTitle('ZUIDELIJK HALFROND'),
          buildParagraph(
              'Brazilie, Chili, Argentinie, Mexico, Ecuador, Peru, Mexico, Australie, Nieuw Zeeland, Zuid Afrika'),
          buildSectionTitle('AANMELDEN?'),
          buildRichText(
              'Zie aanmelden (zie menu balk bovenaan deze pagina). Inlichtingen bij de coördinator van het programma Barbara Tusveld ',
              'longtermchair@rotaryyep.nl.', () {
            launchUrlString('mailto:longtermchair@rotaryyep.nl');
          }),
          buildSectionTitle('KOSTEN?'),
          buildParagraph(
              'De kosten voor de jongere bedragen vanaf € 2.400,-- Exclusief BTW. zakgeld exclusief ticket en andere onkosten.'),
          buildSectionTitle('Waarom doen we dit?'),
          buildBulletPoint('Het opbouwen van goede relaties met andere landen'),
          buildBulletPoint('Het houdt de club jong'),
          buildBulletPoint(
              'De jongere ontwikkelt zichzelf en zijn/haar omgeving'),
          buildEndSection(),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.0),
      ),
    );
  }

  Widget buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text(
        '- $text',
        style: TextStyle(fontSize: 14.0),
      ),
    );
  }

  Widget buildRichText(String text1, String text2, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
          children: [
            TextSpan(text: text1),
            TextSpan(
              text: text2,
              style: TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVideo(String url) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: NativeVideo(url: url),
    );
  }

  Widget buildEndSection() {
    return Column(
      children: <Widget>[
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
        SizedBox(height: 60),
      ],
    );
  }
}
