// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/uniform_widgets/rotary_list_view.dart';
import '../../../../core/presentation/uniform_widgets/last_updated_at.dart';
import '../../../../core/presentation/uniform_widgets/rotary_scaffold.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return RotaryScaffold(
      title: 'About Us',
      returnButtonShown: false,
      body: RotaryListView(
        listTiles: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                child: Text(
                  'Nederland MDJC : Multi district Jeugd Commissie',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Internationale jeugduitwisselingen met Rotary worden al 55 jaar met succes georganiseerd. Jeugduitwisselingen zit in het DNA van Rotary. De jeugd heeft de toekomst, niet alleen voor de Rotary, maar ook voor de wereld. In 2010 is Jeugdzaken met jeugduitwisseling de vijfde Avenue binnen Rotary geworden. Jaarlijks zijn er 7000 Exchanges wereldwijd.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'DOEL UITWISSELING',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Connecting your minds, share future beliefs',
                style: TextStyle(
                    color: Colors.yellow[700],
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: '‣ Missie: ',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      TextSpan(
                        text: 'wij stellen jeugd in staat om ',
                      ),
                      TextSpan(
                        text: 'persoonlijk leiderschap ',
                        style: TextStyle(color: Colors.blue),
                      ),
                      TextSpan(
                        text: 'te ontwikkelen.',
                      ),
                    ]),
              ),
              SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: '‣ Visie: ',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      TextSpan(
                        text: 'wij geloven dat leiderschap begint met ',
                      ),
                      TextSpan(
                        text: 'leiding geven aan jezelf ',
                        style: TextStyle(color: Colors.blue),
                      ),
                      TextSpan(
                        text:
                            'om uiteindelijk anderen in staat te stellen zichzelf te ontwikkelen.',
                      ),
                    ]),
              ),
              SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: '‣ Strategie: ',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      TextSpan(
                        text:
                            'wij doen dit door jonge mensen uit te dagen en te ondersteunen om zich ',
                      ),
                      TextSpan(
                        text: 'buiten hun comfortzone ',
                        style: TextStyle(color: Colors.blue),
                      ),
                      TextSpan(
                        text: 'te manifesteren.',
                      ),
                    ]),
              ),
              SizedBox(
                height: 30,
              ),
              LastUpdatedAt(
                lastUpdated: DateTime(2021, 08, 10),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
