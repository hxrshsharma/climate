import 'package:flutter/material.dart';

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pushNamed(context, '/');
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("404"),
    content: const Text("You typed wrong city!!!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
