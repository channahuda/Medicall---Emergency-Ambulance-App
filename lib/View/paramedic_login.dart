import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medicall/Providers/paramedic_login_provider.dart';
import 'package:provider/provider.dart';

import 'nearest_location.dart';

class ParamedicLogin extends StatefulWidget {
  const ParamedicLogin({Key? key}) : super(key: key);

  @override
  _ParamedicLoginState createState() => _ParamedicLoginState();
}

class _ParamedicLoginState extends State<ParamedicLogin> {
  final formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pw = TextEditingController();

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (BuildContext context) => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: const Color(0xffF8F8F8),
            appBar: AppBar(
              leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              backgroundColor: const Color(0xFF353559),
              centerTitle: true,
              title: Text(
                'Paramedic Login',
                style: TextStyle(fontSize: 22.sp, color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              reverse: true,
              child: Form(
                key: formkey,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'Assets/Medicall (8).png',
                        width: 400.w,
                        height: 400.h,
                      ),
                    ),
                    Padding(
                      padding: REdgeInsets.fromLTRB(40, 0, 40, 10),
                      child: TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: REdgeInsets.fromLTRB(10, 0, 0, 0),
                          hintText: ("Email"),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          } else if (!RegExp(
                                  "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter a valid email");
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: REdgeInsets.fromLTRB(40, 0, 40, 10),
                      child: TextFormField(
                        controller: pw,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          hintText: ("Password"),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          RegExp regex = RegExp(r'^.{6,}$');

                          if (!regex.hasMatch(value)) {
                            return "Enter Valid Password(Min. 6 Characters)";
                          }
                          return null;
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          await context
                              .read<ParamedicLoginProvider>()
                              .loginHospital(email.text, pw.text);
                          if (await context
                              .read<ParamedicLoginProvider>()
                              .getIsValidParamedic()) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const NearestLocation(),
                              ),
                            );
                          } else {
                            Fluttertoast.showToast(msg: "Login Failed");
                          }
                        } else {
                          return null;
                        }
                      },
                      child: const Text('Login'),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff353559),
                        padding: REdgeInsets.symmetric(
                            horizontal: 120.w, vertical: 15.h),
                        textStyle: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w500),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
