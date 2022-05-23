import 'package:flutter/material.dart';
import '../View/Login.dart';

class DeleteDialog {
  static showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Delete Hospital',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: const Text(
            "Are you sure you want to delete this account?",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text(
                "YES",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Login(),
                  ),
                  (route) => false,
                );
              },
            ),
            FlatButton(
              child: const Text(
                "NO",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
