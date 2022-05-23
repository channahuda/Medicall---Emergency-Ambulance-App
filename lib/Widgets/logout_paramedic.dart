import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../Providers/nearest_location_provider.dart';
import '../View/Login.dart';
import 'logout_hospital.dart';

class LogoutParamedic extends StatefulWidget {
  //String type;
  const LogoutParamedic({ Key? key}) : super(key: key);

  @override
  State<LogoutParamedic> createState() => _LogoutParamedicState();
}

class _LogoutParamedicState extends State<LogoutParamedic> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (BuildContext context) => IconButton(
        icon: const Icon(
          Icons.logout_rounded,
          color: Colors.white,
        ),
        onPressed: () {
          // LogoutDialog logout = LogoutDialog();
          // logout.showLogoutDialog(context);
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
                        await  context.read<NearestLocationProvider>().signOut();
                        if(context.read<NearestLocationProvider>().isValidSignOut){
                          Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => const Login(),
                                  ),
                                      (route) => false,
                                );
                        }
                         else {
                            Fluttertoast.showToast(msg: 'Sign out failed.');
                            }

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
        },
      ),
    );
  }
}
