import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class FamilyToFamilyProgramPage extends StatefulWidget {
  @override
  _FamilyToFamilyProgramPageState createState() =>
      _FamilyToFamilyProgramPageState();
}

class _FamilyToFamilyProgramPageState extends State<FamilyToFamilyProgramPage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  double _aspectRatio = 16 / 9;
  int _current = 0;

  List<CarouselModel> localimages = [
    CarouselModel(
        image:
            "assets/image/homepage/Informatiedag_Informatiemarkt_2021_homepage.jpg",
        text: "Informatiemarkt op 18 september a.s."),
    CarouselModel(
        image: "assets/image/homepage/welcom_to_the_netherlands_abbi.jpg",
        text: "Social actief zijn"),
    CarouselModel(
        image: "assets/image/b70db74b-aebe-470d-8c47-306640be9a00.jpg",
        text: "Vergroten van je Horizon"),
    CarouselModel(
        image: "assets/image/homepage/barbara_with_students.jpg",
        text: "Nieuwe vrienden maken"),
    CarouselModel(
        image: "assets/image/homepage/saying_goodby.jpg",
        text:
            "De jeugdafdeling binnen Rotary heeft als missie “jeugd in staat stellen om persoonlijk leiderschap te ontwikkelen”. Onze visie hierbij is dat wij geloven dat leiderschap begint met leiding geven aan jezelf om uiteindelijk anderen in staat te stellen zichzelf te ontwikkelen.\n\nDoor jeugd al vroeg kennis te laten maken met andere mensen, culturen, gewoontes en gebruiken en ze buiten hun comfortzone te brengen, denken wij een bijdrage te leveren aan hun ontwikkeling in het teken van onze missie.")
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
      label: const Text('????'),
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
    _videoPlayerController = VideoPlayerController.network(
        "https://caeli-tech.com/rotary/video/promo/proud_to_be_European.mp4");
    _chewieController = ChewieController(
      allowedScreenSleep: false,
      allowFullScreen: true,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
      videoPlayerController: _videoPlayerController,
      aspectRatio: _aspectRatio,
      autoInitialize: true,
      autoPlay: false,
      showControls: true,
    );
    _chewieController.addListener(() {
      if (_chewieController.isFullScreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }
    });
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
          "Family To Family",
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
                  "FAMILY TO FAMILY: deelnemen",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "WAT IS HET?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "De naam zegt het al, Short Term Exchange Programm (STEP). Het is een uitwisseling met een leeftijdgenoot in het buitenland voor de korte duur van ongeveer 2x3 weken of 2x4 weken. Maar het is ook FAMILY TO FAMILY, wat betekent dat je bij een gezin in het buitenland woont, samen met jouw maatje, en dat jouw maatje samen met jou in Nederland komt wonen.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),

// CarouselModel

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
                        itemCount: localimages.length,
                        options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                        itemBuilder: (context, index, realIdx) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: AssetImage(
                                    localimages[index].image,
                                  ),
                                  fit: BoxFit.cover),
                            ),
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
                            localimages,
                            (index, image) {
                              return Container(
                                  alignment: Alignment.centerLeft,
                                  child: _current == index
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
                                              localimages[index].text,
                                              textScaleFactor: 1,
                                              maxLines: 100,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              // style: TextStyle(color: Palette.grey)
                                            ),
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
                            localimages,
                            (index, image) {
                              return Container(
                                alignment: Alignment.centerLeft,
                                height: 6,
                                width: 6,
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _current == index
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
                  "WAAROM DOEN WE DIT?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "De jeugdafdeling binnen Rotary heeft als missie “jeugd in staat stellen om persoonlijk leiderschap te ontwikkelen”. Onze visie hierbij is dat wij geloven dat leiderschap begint met leiding geven aan jezelf om uiteindelijk anderen in staat te stellen zichzelf te ontwikkelen.\n\nDoor jeugd al vroeg kennis te laten maken met andere mensen, culturen, gewoontes en gebruiken en ze buiten hun comfortzone te brengen, denken wij een bijdrage te leveren aan hun ontwikkeling in het teken van onze missie.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "VOOR WIE DOEN WE DIT?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Jongens en meisjes in de leeftijd van 15 t/m 19* jaar, die open staan voor anderen, van hen willen leren, met hen ervaringen willen uitwisselen, die uit hun eigen vertrouwde omgeving willen stappen en die anderen zonder vooroordelen willen ontmoeten zijn geschikt om aan dit programma deel te nemen. Alleen voor hen willen wij, Rotary vrijwilligers, onze kostbare tijd inzetten zodat zij een onvergetelijke ervaring opdoen die hen in toekomst uitdaagt tot nog grotere stappen.\n\n* De kansen op een match nemen bij 19 jaar behoorlijk af. Neem bij twijfel contact op.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "MET WELKE LANDEN WISSELEN WE UIT?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "In principe kan een uitwisseling met elk door Rotary gecertificeerd land plaatsvinden. Voor een uitwisseling is het belangrijk dat het land of district (bij heel grote landen) veilig en goed georganiseerd is om onze kinderen op een goede manier te ontvangen. Hiervoor hanteren we binnen Rotary International strikte procedures. Elk ontvangend land of district staat onder goed toezicht en met onze jarenlange ervaring weten wij waar we succesvolle uitwisselingen tot stand kunnen brengen. Bij aanmelden geef je drie voorkeurslanden aan op minimaal 2 continenten. Wij streven ernaar om een match binnen het voorkeursland te realiseren, maar dat garanderen we niet. Er is een belangrijk onderscheid tussen het noordelijk en het zuidelijk halfrond.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "Noordelijk halfrond",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "De belangrijkste bestemmingen zijn; VS, Canada, Mexico en Japan. Inmiddels vinden er steeds meer uitwisselingen binnen Europa en India plaats. Deze uitwisselingen vinden plaats in de zomervakantie. Jouw bezoek aan het buitenland en de ontvangst van jouw maatje vinden aaneengesloten plaats. Dat betekent dat een uitwisseling bestaat uit één aaneengesloten periode van ongeveer 2 x 3 weken.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                child: Text(
                  "moet nog een leuk stukje text komen",
                  style: TextStyle(color: Colors.red, fontSize: 13.0),
                ),
              ),
              //video Europa
              Container(
                //margin: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                height: 220,
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "Zuidelijk halfrond",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "De belangrijkste bestemmingen zijn; Argentinië, Brazilië en Zuid-Afrika. In de zomervakantie bezoek jij het gezin van jouw maatje. De ontvangst van jouw maatje is in december/januari als het zuidelijk halfrond zomervakantie heeft. Beide bezoeken duren ongeveer 4 weken. Duur en planningsperiode zijn in onderling overleg.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "WAT KOST HET?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "De kosten (indicatief) voor deelname aan het programma zijn:",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
//table
              DataTable(columns: cols2, rows: rows2),
// end table
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Text(
                  "*In sommige districten, voornamelijk VS, wordt een lokale ziektekostenverzekering verplicht gesteld.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Text(
                  "** afhankelijk van bestemming",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "AANMELDPROCEDURE",
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
                        text: 'Aanmelden',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch("https://www.rotary.nl/yep/aanmelden/");
                          },
                      ),
                      TextSpan(
                        text:
                            ' Doe je via de site van Rotary Youth Exchange. Hier maak je eerst een account aan. Daarna kun je aanmelden onder "Outbound"/ "familie naar familie" / "registreren".\n\nZodra je het registratieformulier hebt aangemaakt ontvang je een email met daarin alle instructies. Deze instructies dienen nauwgezet opgevolgd te worden. Pas dan beginnen wij met het zoeken van een geweldige match voor jou.',
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
                            .copyWith(fontSize: 13),
                        children: [
                      TextSpan(
                        text:
                            'Heb je vragen stel ze bij voorkeur per mail, klik op de namen bij “family to family” op de ',
                      ),
                      TextSpan(
                        text: 'contact',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch("https://www.rotary.nl/yep/contact/");
                          },
                      ),
                      TextSpan(
                        text: ' pagina.',
                      ),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "Matchingsproces",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'Zodra de coördinator zicht heeft op alle buitenlandse en Nederlandse aanvragen worden geschikte kandidaten bij elkaar gezocht. De primaire matchingscriteria zijn geslacht en leeftijd. In eerste instantie worden meisjes met meisjes en jongens met jongens gematcht. Jongens en meisjes kunnen wel goed met elkaar opschieten op school of binnen vriendengroepen maar dat is wat anders dan een aantal weken aan elkaar gekoppeld zijn. Een match meisje/jongen is dus niet uitgesloten maar zal pas voorgesteld worden als er geen andere mogelijkheid is.\n\nBij voorkeur streven wij ongeveer dezelfde leeftijd na. Leeftijd verschillen groter dan 2 jaar vinden in beginsel niet plaats om het risico te voorkomen dat kandidaten te weinig raakvlakken blijken te hebben. 6 weken intensief contact is dan te lang.\n\nZaken als hobby’s en passies spelen alleen een rol als we meerdere matches hebben. Heel belangrijk zijn uitsluitingscriteria als allergieën en angst voor huisdieren.\n\nOp het moment dat de coördinator een match heeft gevonden worden beide kandidaten geïnformeerd middels het uitwisselen van het Application Form. In principe is de match tot stand gebracht. Alleen indien er zwaarwegende argumenten zijn dat deze match niet gaat werken kun je een match afwijzen. Uitgangspunten van het programma zijn dat je open staat voor nieuwe indrukken, mensen en gewoontes.\n\nZodra er een match tot stand gebracht is kunnen jullie met elkaar gaan communiceren met alle ter beschikking staande communicatiekanalen. Samen met het match gezin gaan jullie overleggen en plannen over reis- en bezoekdata en gaan jullie de vliegtickets boeken.',
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "Landenvoorkeur",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'Als je mee wilt doen aan het Family to Family programma geef je op of je voor het noordelijk of zuidelijk halfrond gaat. Bij de landenkeuze dien je drie landen op 2 continenten op te geven. Hierbij gelden de Verenigde Staten en Canada als één bestemming. De reden hiervoor is dat we niet alle kandidaten in de VS en Canada kunnen plaatsen. Daarbij komt dat als jij de juiste instelling hebt voor een Family to Family uitwisseling het uiteindelijk niet uitmaakt naar welk land je gaat.\n\nKies voor Europa! Binnen Europa, ook al ligt dit naast de deur, vinden de mooiste uitwisselingen plaats en ontstaan de mooiste vriendschappen met het voordeel dat je deze vrienden makkelijker kunt herbezoeken. De reiskosten zijn veel lager.',
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "Sponsorclub",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'Jouw aanmelding wordt begeleid, en dient goedgekeurd te worden, door de Rotaryclub in de plaats/omgeving waar jij woont. Zij zullen gesprekken voeren met jou en je ouders als voorbereiding op het programma maar ook om vast te stellen of je geschikt bent voor het programma. Ook zullen zij de nodige gegevens moeten verstrekken die jij op het aanmeldformulier en het Application Form moet invullen. Let op! Het netjes, volledig en duidelijk invullen van de formulieren is jouw verantwoordelijkheid. Tevens verwachten we dat je de jeugdcommissaris van de Rotaryclub die jou uitzendt op de hoogte houdt van alle ontwikkelingen m.b.t. de aanvraag en de matching.\n\nOok zal je gevraagd worden jouw ervaringen te komen vertellen tijdens een clubbijeenkomst van de uitzendende Rotaryclub, maar soms ook de ontvangende Rotaryclub.',
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "Ambassadeurschap",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'Eenmaal uitgezonden gaan wij ervan uit dat je Rotary de rest van je leven een warm hart toedraagt omdat je een onvergetelijke ervaring gaat opdoen. Als ambassadeur vragen wij jou om, samen met iemand van Rotary, in de maand oktober een presentatie te verzorgen op jouw school om daar andere jongeren over jouw ervaring te vertellen en hen enthousiast te maken voor een uitwisseling.',
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "Landelijke informatiebijeenkomst",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'Elk jaar vindt er een landelijk informatiebijeenkomst plaats. Hier leren zowel de kandidaten als de ouders hoe je de kans op een succesvolle uitwisseling ze groot mogelijk maakt. Hoe stel je je op als je als gast binnenkomt bij een gezin? Hoe communiceer je met je gastgezin? Hoeveel contact onderhoud je met het thuisfront? Maar zeker zo belangrijk! Hoe ontvang je je maatje bij jou thuis? Hoe zorg je dat hij/zij zich welkom en veilig voelt? Hoe ga je om met het feit dat jouw gast zich onzeker voelt en de taal niet spreekt?',
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "Deze bijeenkomst is verplicht voor de kandidaat en minimaal één ouder.",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'Deze bijeenkomst vindt plaats op de laatste zaterdag van mei, van 09.30 tot 11.30 uur.\n\nLocatie centraal in het land.',
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
                    'Update: 8 april 2020',
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
    _videoPlayerController.dispose();
    _chewieController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }
}

class CarouselModel {
  final String image, text;

  CarouselModel({required this.image, required this.text});
}
