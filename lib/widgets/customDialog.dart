import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tune_up/constants/colours.dart';
import 'package:tune_up/constants/ourTextStyle.dart';

class CustomDialog extends StatelessWidget {
  final Completer completer;

  const CustomDialog({required this.completer, super.key});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        backgroundColor: backgroundColour,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Text(
          "Permission Needed!",
          textAlign: TextAlign.center,
        ),
        titleTextStyle: ourTextStyle(),
        content: Text(
          "Please accept the permission in the settings",
          textAlign: TextAlign.center,
        ),
        contentTextStyle: ourTextStyle(fontWeight: FontWeight.w400),
        actions: [
          TextButton(
              onPressed: () async {
                await openAppSettings();
                if (!completer.isCompleted) {
                  completer.complete();
                }
              },
              child: Text("Open Settings"))
        ],
      ),
    );
  }
}
