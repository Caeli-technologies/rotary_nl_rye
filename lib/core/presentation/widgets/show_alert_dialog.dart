import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showMaterialDialog(context, title, message, action) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Platform.isIOS
          ? new CupertinoAlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                action != null
                    ? CupertinoDialogAction(
                        child: Text(action),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    : CupertinoDialogAction(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
              ],
            )
          : new AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                action != null
                    ? TextButton(
                        child: Text(action),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    : TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
              ],
            );
    },
  );
}
