// 🎯 Dart imports:
import 'dart:io';

// 📦 Package imports:
import 'package:url_launcher/url_launcher.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/widgets/show_alert_dialog.dart';

openwhatsapp(context, String tel) async {
  var whatsapp = tel;
  var whatsappURlandroid = 'whatsapp://send?phone=$whatsapp';
  var whatappURLios = 'https://wa.me/$whatsapp';
  if (Platform.isIOS) {
    // for iOS phone only
    if (await canLaunch(whatappURLios)) {
      await launch(whatappURLios, forceSafariVC: false);
    } else {
      String title = 'whatsapp not installed';
      String message = 'WhatsApp is niet geïnstalleerd';
      String action = 'Close';
      showMaterialDialog(context, title, message, action);
    }
  } else {
    // android , web
    if (await canLaunch(whatsappURlandroid)) {
      await launch(whatsappURlandroid);
    } else {
      String title = 'whatsapp not installed';
      String message = 'WhatsApp is niet geïnstalleerd';
      String action = 'Close';
      showMaterialDialog(context, title, message, action);
    }
  }
}
