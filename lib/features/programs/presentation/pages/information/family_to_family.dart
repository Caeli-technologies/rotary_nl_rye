// 🐦 Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher_string.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/widgets/native_video.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class FamilyToFamilyProgramPage extends StatefulWidget {
  @override
  _FamilyToFamilyProgramPageState createState() =>
      _FamilyToFamilyProgramPageState();
}

class _FamilyToFamilyProgramPageState extends State<FamilyToFamilyProgramPage> {
  int _current1 = 0;
  int _current2 = 0;
  int _current3 = 0;

  List<CarouselModel> localimages1 = [
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/f_to_f/Picture1.png',
        text:
            ' Meike wordt door haar Argentijnse gastfamilie opgehaald van het vliegveld'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/f_to_f/Picture2.png',
        text: 'Noor met haar gastgezin in Brazilië'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/f_to_f/Picture3.png',
        text:
            'Stijn bij de natuurlijke thermale baden van Mendoza met gastgezin en match \'Fran\' in Argentinië'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/f_to_f/Picture4.png',
        text: 'Stijn in Argentinië'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/f_to_f/Picture5.png',
        text: 'Stijn (in het midden) met de Argentijnse familie van Fran'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/f_to_f/Picture6.png',
        text: 'Lot en haar Indiase match Lutra. Lot laat Deventer zien.')
  ];

  List<CarouselModel> localimages2 = [
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/f_to_f/Picture7.png',
        text:
            'Lutra haar familie maken met Lot een trip door ‘de Gouden Driehoek in Noord India: Delhi, Jaipur en Agra  (foto met de Thai Mahal op de achtergrond. Lutra woont in Nagpur.'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/f_to_f/Picture8-1.png',
        text: '‘EVEN VERWISSELD VAN NATIONAL COSTUME’'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/f_to_f/Picture8-2.png',
        text: 'Appeltaart bakken'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/f_to_f/Picture8-3.png',
        text: 'kaasproeven'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/f_to_f/Picture10-1.png',
        text: 'LIANNE HEEFT EEN MATCH MET JAPANS MEISJE'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/f_to_f/Picture10-2.png',
        text: 'LIANNE HEEFT EEN MATCH MET JAPANS MEISJE')
  ];

  List<CarouselModel> localimages3 = [
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/f_to_f/Picture9-1.png',
        text: 'LOUISE HEEFT EEN MATCH MET JONGERE UIT DE USA'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/f_to_f/Picture9-2.png',
        text: 'LOUISE HEEFT EEN MATCH MET JONGERE UIT DE USA'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/f_to_f/Picture9-3.png',
        text: 'LOUISE HEEFT EEN MATCH MET JONGERE UIT DE USA'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/f_to_f/Picture11.png',
        text: 'Samen nieuwe horizons opzoeken'),
    CarouselModel(
        image:
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/programs/f_to_f/Picture12.png',
        text: 'samen door Amsterdam fietsen')
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  final cols2 = [
    new DataColumn(
      label: const Text(''),
    ),
    new DataColumn(
      label: SizedBox(
        width: Device.width - 280,
        child: Text('price (indication)',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: TextStyle(inherit: true)),
      ),
    ),
  ];

  final rows2 = [
    DataRow(
      cells: <DataCell>[
        DataCell(Text('Inschrijfgeld')),
        DataCell(Text('€150,- tot 150,-')),
      ],
    ),
    DataRow(
      cells: <DataCell>[
        DataCell(Text('Reisverzekering')),
        DataCell(Text('€50,- tot 50,-')),
      ],
    ),
    DataRow(
      cells: <DataCell>[
        DataCell(Text('Ziektekostenverzekering*')),
        DataCell(Text('€50,- tot 100,-')),
      ],
    ),
    DataRow(
      cells: <DataCell>[
        DataCell(Text('Zakgeld (maximaal)')),
        DataCell(Text('€250,- tot 250,-')),
      ],
    ),
    DataRow(
      cells: <DataCell>[
        DataCell(Text('Vliegticket** (gemiddeld)')),
        DataCell(Text('€800.- tot 1.500,-')),
      ],
    ),
    DataRow(
      color: MaterialStateColor.resolveWith(
          (states) => Palette.themeCardShadeColor),
      cells: <DataCell>[
        DataCell(Text('Totaal')),
        DataCell(Text('€1.300.- tot 2.050.-')),
      ],
    ),
  ];

  @override
  initState() {
    super.initState();
    // fetch from inetrnet localy
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   images.forEach((imageUrl) {
    //     precacheImage(NetworkImage(imageUrl), context);
    //   });
    // });
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
          'Family To Family',
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
                  'FAMILY TO FAMILY: deelnemen',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  'WAT IS HET?',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'De naam zegt het al, Short Term Exchange Programm (STEP). Het is een uitwisseling met een leeftijdgenoot in het buitenland voor de korte duur van ongeveer 2x3 weken of 2x4 weken. Maar het is ook FAMILY TO FAMILY, wat betekent dat je bij een gezin in het buitenland woont, samen met jouw maatje, en dat jouw maatje samen met jou in Nederland komt wonen.',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),

// CarouselModel 1

              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      child: CarouselSlider.builder(
                        itemCount: localimages1.length,
                        options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current1 = index;
                              });
                            }),
                        itemBuilder: (context, index, realIdx) {
                          return CachedNetworkImage(
                            imageUrl: localimages1[index].image,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                // color: Colors.grey,
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: map<Widget>(
                            localimages1,
                            (index, image) {
                              return Container(
                                  alignment: Alignment.centerLeft,
                                  child: _current1 == index
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              // right: 30.0, left: 30
                                              ),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Text(
                                                localimages1[index].text,
                                                textScaleFactor: 1,
                                                maxLines: 100,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: Palette.grey)),
                                          ),
                                        )
                                      : SizedBox.shrink());
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: map<Widget>(
                            localimages1,
                            (index, image) {
                              return Container(
                                alignment: Alignment.centerLeft,
                                height: 6,
                                width: 6,
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _current1 == index
                                        ? Palette.accentColor
                                        : Palette.lightIndigo),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  'WAAROM DOEN WE DIT?',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'De jeugdafdeling binnen Rotary heeft als missie “jeugd in staat stellen om persoonlijk leiderschap te ontwikkelen”. Onze visie hierbij is dat wij geloven dat leiderschap begint met leiding geven aan jezelf om uiteindelijk anderen in staat te stellen zichzelf te ontwikkelen.\n\nDoor jeugd al vroeg kennis te laten maken met andere mensen, culturen, gewoontes en gebruiken en ze buiten hun comfortzone te brengen, denken wij een bijdrage te leveren aan hun ontwikkeling in het teken van onze missie.',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),

// CarouselModel 2

              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // height: 220,
                      child: CarouselSlider.builder(
                        itemCount: localimages2.length,
                        options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 1.0,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current2 = index;
                              });
                            }),
                        itemBuilder: (context, index, realIdx) {
                          return CachedNetworkImage(
                            imageUrl: localimages2[index].image,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                // color: Colors.grey,
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: map<Widget>(
                            localimages2,
                            (index, image) {
                              return Container(
                                  alignment: Alignment.centerLeft,
                                  child: _current2 == index
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              // right: 30.0, left: 30
                                              ),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Text(
                                                localimages2[index].text,
                                                textScaleFactor: 1,
                                                maxLines: 100,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: Palette.grey)),
                                          ),
                                        )
                                      : SizedBox.shrink());
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: map<Widget>(
                            localimages2,
                            (index, image) {
                              return Container(
                                alignment: Alignment.centerLeft,
                                height: 6,
                                width: 6,
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _current2 == index
                                        ? Palette.accentColor
                                        : Palette.lightIndigo),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

//end

// CarouselModel 3

              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // height: 250,
                      child: CarouselSlider.builder(
                        itemCount: localimages3.length,
                        options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 1.0,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current3 = index;
                              });
                            }),
                        itemBuilder: (context, index, realIdx) {
                          return CachedNetworkImage(
                            imageUrl: localimages3[index].image,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                // color: Colors.grey,
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: map<Widget>(
                            localimages3,
                            (index, image) {
                              return Container(
                                  alignment: Alignment.centerLeft,
                                  child: _current3 == index
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              // right: 30.0, left: 30
                                              ),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Text(
                                                localimages3[index].text,
                                                textScaleFactor: 1,
                                                maxLines: 100,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: Palette.grey)),
                                          ),
                                        )
                                      : SizedBox.shrink());
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: map<Widget>(
                            localimages3,
                            (index, image) {
                              return Container(
                                alignment: Alignment.centerLeft,
                                height: 6,
                                width: 6,
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _current3 == index
                                        ? Palette.accentColor
                                        : Palette.lightIndigo),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //end
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  'VOOR WIE DOEN WE DIT?',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'Jongens en meisjes in de leeftijd van 15 t/m 19 jaar, die open staan voor anderen, van hen willen leren, met hen ervaringen willen uitwisselen, die uit hun eigen vertrouwde omgeving willen stappen en die anderen zonder vooroordelen willen ontmoeten zijn geschikt om aan dit programma deel te nemen.',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  'MET WELKE LANDEN WISSELEN WE UIT?',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'In principe kan een uitwisseling met elk door Rotary gecertificeerd land plaatsvinden. Voor een uitwisseling is het belangrijk dat het land of district (bij heel grote landen) veilig en goed georganiseerd is om onze kinderen op een goede manier te ontvangen. Hiervoor hanteren we binnen Rotary International strikte procedures. Elk ontvangend land of district staat onder goed toezicht en met onze jarenlange ervaring weten wij waar we succesvolle uitwisselingen tot stand kunnen brengen. Bij aanmelden geef je drie voorkeurslanden aan op minimaal 2 continenten. Wij streven ernaar om een match binnen het voorkeursland te realiseren, maar dat garanderen we niet. Er is een belangrijk onderscheid tussen het noordelijk en het zuidelijk halfrond.',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  'Noordelijk halfrond',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'De belangrijkste bestemmingen zijn; VS, Canada, Mexico en Japan. Inmiddels vinden er steeds meer uitwisselingen binnen Europa en India plaats. Deze uitwisselingen vinden plaats in de zomervakantie. Jouw bezoek aan het buitenland en de ontvangst van jouw maatje vinden aaneengesloten plaats. Dat betekent dat een uitwisseling bestaat uit één aaneengesloten periode van ongeveer 2 x 3 weken.',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                child: Text(
                  'Kijk even deze prachtige video. Je wordt vast erg enthousiast.',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
              //video Europa
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: NativeVideo(
                    url:
                        'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/videos/promo/proud_to_be_European.mp4'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  'Zuidelijk halfrond',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'De belangrijkste bestemmingen zijn; Argentinië, Brazilië en Zuid-Afrika. In de zomervakantie bezoek jij het gezin van jouw maatje. De ontvangst van jouw maatje is in december/januari als het zuidelijk halfrond zomervakantie heeft. Beide bezoeken duren ongeveer 4 weken. Duur en planningsperiode zijn in onderling overleg.',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  'WAT KOST HET?',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'De kosten zijn: €150 euro excl. verzekering, ticket, zakgeld en ziektekosten.',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
//table
              // DataTable(columns: cols2, rows: rows2),
// end table
              // Padding(
              //   padding: const EdgeInsets.only(top: 0.0),
              //   child: Text(
              //     "*In sommige districten, voornamelijk VS, wordt een lokale ziektekostenverzekering verplicht gesteld.",
              //     style: TextStyle( fontSize: 14.0),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 0.0),
              //   child: Text(
              //     "** afhankelijk van bestemming",
              //     style: TextStyle( fontSize: 14.0),
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  'AANMELDPROCEDURE',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: RichText(
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 14),
                        children: [
                      TextSpan(
                        text:
                            'De aanmelding voor Shortterm loopt nu alleen via het emailadres ',
                      ),
                      TextSpan(
                        text: 'interesse@rotaryyep.nl',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrlString('mailto:interesse@rotaryyep.nl');
                          },
                      ),
                    ])),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 10.0),
              //   child: RichText(
              //       text: TextSpan(
              //           style: Theme.of(context)
              //               .textTheme
              //               .bodyMedium!
              //               .copyWith(fontSize: 14),
              //           children: [
              //         TextSpan(
              //           text:
              //               'Heb je vragen stel ze bij voorkeur per mail, klik op de namen bij “family to family” op de ',
              //         ),
              //         TextSpan(
              //           text: 'contact',
              //           style: TextStyle(color: Colors.blue),
              //           recognizer: TapGestureRecognizer()
              //             ..onTap = () {
              //               launch("https://www.rotary.nl/yep/contact/");
              //             },
              //         ),
              //         TextSpan(
              //           text: ' pagina.',
              //         ),
              //       ])),
              // ),

              // Padding(
              //   padding: const EdgeInsets.only(top: 25.0),
              //   child: Text(
              //     "Matchingsproces",
              //     style: TextStyle(
              //
              //         fontSize: 14.0,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 10.0),
              //   child: Text(
              //     'Zodra de coördinator zicht heeft op alle buitenlandse en Nederlandse aanvragen worden geschikte kandidaten bij elkaar gezocht. De primaire matchingscriteria zijn geslacht en leeftijd. In eerste instantie worden meisjes met meisjes en jongens met jongens gematcht. Jongens en meisjes kunnen wel goed met elkaar opschieten op school of binnen vriendengroepen maar dat is wat anders dan een aantal weken aan elkaar gekoppeld zijn. Een match meisje/jongen is dus niet uitgesloten maar zal pas voorgesteld worden als er geen andere mogelijkheid is.\n\nBij voorkeur streven wij ongeveer dezelfde leeftijd na. Leeftijd verschillen groter dan 2 jaar vinden in beginsel niet plaats om het risico te voorkomen dat kandidaten te weinig raakvlakken blijken te hebben. 6 weken intensief contact is dan te lang.\n\nZaken als hobby’s en passies spelen alleen een rol als we meerdere matches hebben. Heel belangrijk zijn uitsluitingscriteria als allergieën en angst voor huisdieren.\n\nOp het moment dat de coördinator een match heeft gevonden worden beide kandidaten geïnformeerd middels het uitwisselen van het Application Form. In principe is de match tot stand gebracht. Alleen indien er zwaarwegende argumenten zijn dat deze match niet gaat werken kun je een match afwijzen. Uitgangspunten van het programma zijn dat je open staat voor nieuwe indrukken, mensen en gewoontes.\n\nZodra er een match tot stand gebracht is kunnen jullie met elkaar gaan communiceren met alle ter beschikking staande communicatiekanalen. Samen met het match gezin gaan jullie overleggen en plannen over reis- en bezoekdata en gaan jullie de vliegtickets boeken.',
              //     style: TextStyle( fontSize: 14.0),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 25.0),
              //   child: Text(
              //     "Landenvoorkeur",
              //     style: TextStyle(
              //
              //         fontSize: 14.0,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 10.0),
              //   child: Text(
              //     'Als je mee wilt doen aan het Family to Family programma geef je op of je voor het noordelijk of zuidelijk halfrond gaat. Bij de landenkeuze dien je drie landen op 2 continenten op te geven. Hierbij gelden de Verenigde Staten en Canada als één bestemming. De reden hiervoor is dat we niet alle kandidaten in de VS en Canada kunnen plaatsen. Daarbij komt dat als jij de juiste instelling hebt voor een Family to Family uitwisseling het uiteindelijk niet uitmaakt naar welk land je gaat.\n\nKies voor Europa! Binnen Europa, ook al ligt dit naast de deur, vinden de mooiste uitwisselingen plaats en ontstaan de mooiste vriendschappen met het voordeel dat je deze vrienden makkelijker kunt herbezoeken. De reiskosten zijn veel lager.',
              //     style: TextStyle( fontSize: 14.0),
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  'Sponsorclub',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'Jouw aanmelding wordt begeleid, en dient goedgekeurd te worden, door de Rotaryclub in de plaats/omgeving waar jij woont.',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.only(top: 25.0),
              //   child: Text(
              //     "Ambassadeurschap",
              //     style: TextStyle(
              //
              //         fontSize: 14.0,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 10.0),
              //   child: Text(
              //     'Eenmaal uitgezonden gaan wij ervan uit dat je Rotary de rest van je leven een warm hart toedraagt omdat je een onvergetelijke ervaring gaat opdoen. Als ambassadeur vragen wij jou om, samen met iemand van Rotary, in de maand oktober een presentatie te verzorgen op jouw school om daar andere jongeren over jouw ervaring te vertellen en hen enthousiast te maken voor een uitwisseling.',
              //     style: TextStyle( fontSize: 14.0),
              //   ),
              // ),

              // Padding(
              //   padding: const EdgeInsets.only(top: 25.0),
              //   child: Text(
              //     "Landelijke informatiebijeenkomst",
              //     style: TextStyle(
              //
              //         fontSize: 14.0,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 10.0),
              //   child: Text(
              //     'Elk jaar vindt er een landelijk informatiebijeenkomst plaats. Hier leren zowel de kandidaten als de ouders hoe je de kans op een succesvolle uitwisseling ze groot mogelijk maakt. Hoe stel je je op als je als gast binnenkomt bij een gezin? Hoe communiceer je met je gastgezin? Hoeveel contact onderhoud je met het thuisfront? Maar zeker zo belangrijk! Hoe ontvang je je maatje bij jou thuis? Hoe zorg je dat hij/zij zich welkom en veilig voelt? Hoe ga je om met het feit dat jouw gast zich onzeker voelt en de taal niet spreekt?',
              //     style: TextStyle( fontSize: 14.0),
              //   ),
              // ),

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
                    'Update: 10 Aug 2021',
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

class CarouselModel {
  final String image, text;

  CarouselModel({required this.image, required this.text});
}
