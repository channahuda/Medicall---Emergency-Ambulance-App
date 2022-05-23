import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../Providers/patient_list_provider.dart';
import '../View/login.dart';

class LogoutHospital {
  bool isValidHospital = false;

  showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: const Text(
            "Are you sure you want to log out?",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: <Widget>[
            FlatButton(
                child: const Text(
                  "YES",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.blue),
                ),
                onPressed: () async {
                  // if (type == 'Hospital') {
                  await context.read<PatientListProvider>().signOut();
                  if (context.read<PatientListProvider>().isValid) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const Login(),
                      ),
                      (route) => false,
                    );
                  } else {
                    Fluttertoast.showToast(msg: 'Sign out failed.');
                  }
                  //   }
                }),
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
