// 🐦 Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher_string.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/outbound/presentation/pages/short_term/camps_and_tours/widgets/loadCsv.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class CampsAndToursProgramPage extends StatefulWidget {
  @override
  _CampsAndToursProgramPageState createState() =>
      _CampsAndToursProgramPageState();
}

class _CampsAndToursProgramPageState extends State<CampsAndToursProgramPage> {
  int _current1 = 0;
  int _current2 = 0;
  int _current3 = 0;

  final List<CarouselModel> localImages1 = [
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/outbound_summercamp/Picture1-1.png',
        text: 'roeien'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/outbound_summercamp/Picture1-2.png',
        text: 'leren boogschieten  '),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/outbound_summercamp/Picture2.png',
        text:
            'Marjolein neemt deel aan een kamp in Brazilië, een tiendaagse boottocht met excursies over de Amazone Rivier'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/outbound_summercamp/Picture3-1.png',
        text: 'OUTBOUND Zomerkamp: Egypte'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/outbound_summercamp/Picture3-2.png',
        text: 'OUTBOUND Zomerkamp: Egypte'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/outbound_summercamp/Picture4-1.png',
        text: 'OUTBOUND zomerkamp: Zuid-Italië'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/outbound_summercamp/Picture4-2.png',
        text: 'OUTBOUND zomerkamp: Zuid-Italië'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/outbound_summercamp/Picture5.png',
        text: 'OUTBOUND zomerkamp: Zuid-Italië')
  ];

  final List<CarouselModel> localImages2 = [
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/inbound_summercamp/Picture1.png',
        text:
            'INBOUND zomerkamp in Nederland: Buitenlandse jongeren in Nederland'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/inbound_summercamp/Picture2.png',
        text:
            'INBOUNDS zomerkamp in Nederland. Buitenlandse jongere logeert bij gasfamilies.'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/inbound_summercamp/Picture3.png',
        text: 'INBOUND Zomerkamp'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/inbound_summercamp/Picture4.png',
        text: 'INBOUND Zomerkamp: Buitenlandse jongeren op kamp in Nederland'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/inbound_summercamp/Picture5.png',
        text:
            'INBOUND zomerkamp: Buitenlandse jongeren krijgen informatie over ‘de inpoldering’'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/inbound_summercamp/Picture6.png',
        text:
            'INBOUND zomerkamp: Buitenlandse jongeren maken kennis met de Nederlandse cultuur')
  ];

  final List<CarouselModel> localImages3 = [
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/inbound_summercamp/Picture7.png',
        text: 'INBOUND zomerkamp: samen pannenkoeken leren bakken'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/inbound_summercamp/Picture8.png',
        text:
            'INBOUND zomerkamp: Buitenlandse jongeren vertellen bij de gastclub over hun land'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/inbound_summercamp/Picture9.png',
        text: 'INBOUND zomerkamp: mee op de reddingsboot'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/inbound_summercamp/Picture10.png',
        text: 'INBOUND zomerkamp: Varen en Nederland'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/inbound_summercamp/Picture11.png',
        text: 'INBOUND zomerkamp: Kerktoren beklimmen'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/inbound_summercamp/Picture12.png',
        text: 'Inbound Zomerkamp in Nederland ‘Afscheids- of BONTE avond')
  ];

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
          'Camps & Tours',
          textScaler: TextScaler.linear(1),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        children: <Widget>[
          buildSectionTitle('CAMPS & TOURS: deelnemen'),
          buildSubsectionTitle('OUTBOUND zomerkamp: '),
          buildCarousel(localImages1, _current1, (index) {
            setState(() {
              _current1 = index;
            });
          }),
          buildSubsectionTitle('INBOUND zomerkamp: '),
          buildCarousel(localImages2, _current2, (index) {
            setState(() {
              _current2 = index;
            });
          }),
          buildCarousel(localImages3, _current3, (index) {
            setState(() {
              _current3 = index;
            });
          }),
          buildSectionTitle('Wat houdt dat in?'),
          buildParagraph(
              'Heel veel Europese landen organiseren in de periode van juni t/m september Zomer Tours en speciale kampen, zoals zeil-, ski- en sportkampen. De laatste jaren worden er ook Zomerkampen in Canada, V.S. en Taiwan georganiseerd. Er worden groepen van 10 à 20 deelnemers gevormd met een zo groot mogelijke spreiding van nationaliteiten. Deze groepen zijn te gast bij Rotaryclubs die een informatief, toeristisch of sportief programma organiseren. Meestal verblijft men in (Rotary)gezinnen of hostels waarbij Rotarians de leiding hebben. De belangstelling is doorgaans groter dan het aantal beschikbare plaatsen, dus stuur z.s.m. jouw aanmelding in!.'),
          buildSectionTitle('Voor wie?'),
          buildParagraph(
              'De leeftijd van de deelnemers varieert van 15 - 21 jaar. Deelname is mogelijk voor jongeren van Rotarians en van niet-Rotarians.'),
          buildSectionTitle('Met welke landen?'),
          buildParagraph('Europese landen, maar ook Canada, VS en Taiwan.'),
          buildSectionTitle('Aanmelden?'),
          buildRichText(
              'Door de buitenlandse organisator worden uitnodigingen aan de MDJC (= Multi District Jeugdzaken Commissie van Rotary) gestuurd om een jongen of meisje van een bepaalde leeftijd en in een speciale periode aan hun Camp of Tour te laten deelnemen. Deze uitnodigingen worden direct na ontvangst op de site ',
              'Summer Camps',
              LoadCsv()),
          buildParagraph(
              ' geplaatst ter info. Je treft deze op de site aan vanaf half januari t/m begin mei. Dus hier vind je steeds het meest actuele aanbod over de Camps & Tours uit de deelnemende landen. Je kunt de coördinator ook direct laten weten als je interesse hebt om deel te nemen aan een bepaald Camp of Tour. Aanmelden via deze email: '),
          buildLinkText(
              'zomerkamp@rotaryyep.nl', 'mailto:zomerkamp@rotaryyep.nl'),
          buildParagraph('Hierop moet duidelijk worden:'),
          buildBulletPoint('Wie jouw sponsor-Rotary Club is;'),
          buildBulletPoint('De periode waarin je beschikbaar bent;'),
          buildBulletPoint(
              'De landen waarnaar je voorkeur uitgaat. (Als er geen specifieke voorkeur is en elk Europees land goed is, kan dit vermeld worden.)'),
          buildParagraph(
              'De coördinator koppelt de aanmeldingen aan de uitnodigingen en stuurt de deelnemers bericht.'),
          buildBoldText('Dringend verzoek: ',
              'gelieve bij aanmelding op te geven of men zich ook heeft aangemeld voor andere reizen of kampen'),
          buildRichText(
              'De CJC van de sponsorclub stuurt het aanmeldingsformulier naar de outboundcoördinator: ',
              'zomerkamp@rotaryyep.nl',
              null),
          buildSectionTitle('Kosten?'),
          buildParagraph(
              'De kosten voor aanmelding zijn 100,-- ex BTW (121 euro incl. BTW) (kosten kunnen per jaar verschillen) \n\nDe aanmelding staat open tot mei. \n\nNaast het inschrijfgeld moet men rekening houden met de volgende kosten:'),
          buildBulletPoint(
              'Reiskosten naar de plaats waar het kamp wordt gehouden.'),
          buildBulletPoint('Zakgeld ter plaatse.'),
          buildBulletPoint(
              'Een enkele Rotary Club in het buitenland vraagt wel eens een klein deelnamebedrag (dit staat steeds in de uitnodiging vermeld.)'),
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

  Widget buildSubsectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
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
        text,
        style: TextStyle(fontSize: 14.0),
      ),
    );
  }

  Widget buildRichText(String text1, String text2, Widget? page) {
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
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  if (page != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => page),
                    );
                  } else {
                    launchUrlString('mailto:zomerkamp@rotaryyep.nl');
                  }
                },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLinkText(String text, String url) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
          children: [
            TextSpan(
              text: text,
              style: TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  launchUrlString(url);
                },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoldText(String boldText, String normalText) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
          children: [
            TextSpan(
              text: boldText,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: normalText),
          ],
        ),
      ),
    );
  }

  Widget buildCarousel(
      List<CarouselModel> images, int currentIndex, Function onPageChanged) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CarouselSlider.builder(
            itemCount: images.length,
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 1.0,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                onPageChanged(index);
              },
            ),
            itemBuilder: (context, index, realIdx) {
              return CachedNetworkImage(
                imageUrl: images[index].image,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              );
            },
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      images[currentIndex].text,
                      textScaler: TextScaler.linear(1),
                      maxLines: 100,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: Palette.grey),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: images.map((image) {
                  int index = images.indexOf(image);
                  return Container(
                    alignment: Alignment.centerLeft,
                    height: 6,
                    width: 6,
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentIndex == index
                            ? Palette.accentColor
                            : Palette.lightIndigo),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
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
              'Update: 26 augustus 2019',
              style: TextStyle(color: Color(0xFF777777)),
            ),
          ),
        ),
        SizedBox(height: 60),
      ],
    );
  }
}

class CarouselModel {
  final String image;
  final String text;

  CarouselModel({required this.image, required this.text});
}
