// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class AlgemeneInfoPage extends StatefulWidget {
  @override
  _AlgemeneInfoPageState createState() => _AlgemeneInfoPageState();
}

class _AlgemeneInfoPageState extends State<AlgemeneInfoPage> {
  final List<Map<String, String>> infoSections = [
    {
      'title': 'Sponsoring - wat houdt het in?',
      'content':
          'Het is de bedoeling dat een Rotary club als sponsor optreedt voor een scholier die graag als ambassadeur van Rotary International een schooljaar naar het buitenland uitgezonden wil worden. Dit is mogelijk voor alle jongeren, zowel uit Rotary als uit niet-Rotary gezinnen. In datzelfde jaar ontvangt de club een buitenlandse scholier in haar midden. Deze gaat hier naar school met leeftijdsgenoten en wordt tijdens het jaar bij twee tot maximaal vier gastgezinnen ondergebracht.\n\nLeeftijd - voor de uitzending en ontvangst van de scholier gelden indicatieve leeftijdsgrenzen. In principe is dit 15½ - 18½ jaar.'
    },
    {
      'title': 'De uitwisseling',
      'content':
          'De uitwisseling vindt plaats op basis van wederkerigheid. Dit wil zeggen dat elke Rotary club die een scholier uitzendt, in hetzelfde jaar een het jaarkind ontvangt. Deze scholier wordt tijdens het jaar bij diverse gastgezinnen ondergebracht. De club bezoekt tevoren de gastgezinnen.'
    },
    {
      'title': 'Kosten',
      'content':
          'Voor sponsoring van een Nederlandse scholier naar het buitenland zijn er geen kosten verbonden voor jullie club. Wel zijn er kosten voor de ontvangst van een jaarstudent. (Dit programma is op basis van wederkerigheid, dus het een kan niet zonder het ander plaatsvinden).\n\nDe maximaal totale kosten die hiermee gemoeid zijn voor jullie club bedragen € 2.000,-- voor een heel schooljaar/uitwisselingsjaar. De landelijke Rotary-organisatie MDJC vindt het Rotary uitwisselingsprogramma zo belangrijk, dat zij een tegemoetkoming in de kosten (subsidie) van € 1.250,-- betalen voor elke club die wil hosten. Dat betekent dat de feitelijke kosten voor jullie club voor een heel jaar dan nog maximaal € 750,- bedragen.'
    },
    {
      'title': 'Gastgezinnen',
      'content':
          'De CJC zoekt samen met de student die uitgezonden wil worden naar drie gastgezinnen en een reservegezin. Het is prettig als er kinderen van dezelfde leeftijd in het gezin zijn, maar dat is beslist niet noodzakelijk. In gezinnen met kinderen van dezelfde leeftijd krijgen ze eerder aansluiting met leeftijdsgenoten, maar oudere echtparen zijn vaak fantastische gastouders en in gezinnen met kleine kinderen leren de studenten vaak eerder onze taal.\n\nSamenwerking met een andere Rotary club is dan mogelijk een leuke optie en biedt meer mogelijkheden voor het vinden van gastgezinnen.\n\nOm je als club goed te informeren (of te enthousiasmeren) over het meedoen aan deze jaaruitwisseling zijn er oud-exchange studenten in Nederland die graag over hun ervaringen komen vertellen. Daarnaast kun je als club ook meer informatie opvragen bij de leden van MDJC of je eigen District Jeugd Commissaris.'
    }
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
          'Algemene Informatie',
          textScaler: TextScaler.linear(1),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        itemCount: infoSections.length,
        itemBuilder: (context, index) {
          return _buildInfoSection(
            infoSections[index]['title']!,
            infoSections[index]['content']!,
          );
        },
      ),
    );
  }

  Widget _buildInfoSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Palette.bodyText,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            content,
            style: TextStyle(color: Palette.bodyText, fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
