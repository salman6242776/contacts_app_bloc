import 'package:flutter/material.dart';

class AppDialog {
  static AlertDialog getOneButtonAlertDialog({
    required BuildContext buildContext,
    required String title,
    required String content,
    // required String leftButtonText,
    required String rightButtonText,
    // required Function leftButtonClickListener,
    required Function rightButtonClickListener,
  }) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(buildContext).textTheme.titleMedium,
      ),
      content: Text(
        content,
        style: const TextStyle(
            fontWeight: FontWeight.normal, color: Colors.black87, fontSize: 14),
      ),
      actions: [
        // TextButton(
        //     onPressed: () {
        //       Navigator.of(buildContext).pop();
        //       leftButtonClickListener();
        //     },
        //     child: Text(leftButtonText)),
        ElevatedButton(
            onPressed: () {
              Navigator.of(buildContext).pop();
              rightButtonClickListener();
            },
            child: Text(
              rightButtonText,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  static AlertDialog getTwoButtonAlertDialog({
    required BuildContext buildContext,
    required String title,
    required String content,
    required String leftButtonText,
    required String rightButtonText,
    required Function leftButtonClickListener,
    required Function rightButtonClickListener,
  }) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(buildContext).textTheme.titleMedium,
      ),
      content: Text(
        content,
        style: const TextStyle(
            fontWeight: FontWeight.normal, color: Colors.black87, fontSize: 14),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(buildContext).pop();
              leftButtonClickListener();
            },
            child: Text(leftButtonText)),
        ElevatedButton(
            onPressed: () {
              Navigator.of(buildContext).pop();
              rightButtonClickListener();
            },
            child: Text(
              rightButtonText,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
}
