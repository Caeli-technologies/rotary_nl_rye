import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rotary_nl_rye/core/prop.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
        centerTitle: false,
        title: Text(
          'About Us',
          textScaleFactor: 1.7,
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              //   child: Container(
              //       child: ClipRRect(
              //     child: Image.asset(
              //       "assets/image/rotary_opens_opportunities_logo.png",
              //     ),
              //   )),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: SizedBox(
                  child: Text('Nederland MDJC : Multi district Jeugd Commissie',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                        inherit: true,
                        fontSize: 20.0,
                        color: Palette.titleText,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.5, right: 16.0, top: 20.0),
                child: Text(
                  'Internationale jeugduitwisselingen met Rotary worden al 55 jaar met succes georganiseerd. Jeugduitwisselingen zit in het DNA van Rotary. De jeugd heeft de toekomst, niet alleen voor de Rotary, maar ook voor de wereld. In 2010 is Jeugdzaken met jeugduitwisseling de vijfde Avenue binnen Rotary geworden. Jaarlijks zijn er 7000 Exchanges wereldwijd.',
                  style: TextStyle(color: Palette.bodyText, fontSize: 16.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 30.0),
                child: Text(
                  'DOEL UITWISSELING',
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0),
                child: Text(
                  'Connecting your minds, share future beliefs',
                  style: TextStyle(
                      color: Colors.yellow[700],
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0),
                child: RichText(
                  text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 15),
                      children: [
                        TextSpan(
                          text: '‣ Missie: ',
                          style: TextStyle(
                              color: Palette.titleText,
                              fontWeight: FontWeight.bold),
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
              ),

              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0),
                child: RichText(
                  text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 15),
                      children: [
                        TextSpan(
                          text: '‣ Visie: ',
                          style: TextStyle(
                              color: Palette.titleText,
                              fontWeight: FontWeight.bold),
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
              ),

              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0),
                child: RichText(
                  text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 15),
                      children: [
                        TextSpan(
                          text: '‣ Strategie: ',
                          style: TextStyle(
                              color: Palette.titleText,
                              fontWeight: FontWeight.bold),
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
}
