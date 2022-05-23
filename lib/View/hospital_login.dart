import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicall/Providers/hospital_login_provider.dart';
import 'package:medicall/View/patient_list.dart';
import 'package:medicall/View/register_hospital.dart';
import 'package:provider/provider.dart';

class HospitalLogin extends StatefulWidget {
  const HospitalLogin({Key? key}) : super(key: key);

  @override
  _HospitalLoginState createState() => _HospitalLoginState();
}

class _HospitalLoginState extends State<HospitalLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController pw = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    email.dispose();
    pw.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (BuildContext context) => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              backgroundColor: const Color(0xFF353559),
              centerTitle: true,
              title: Text(
                'Hospital Login',
                style: TextStyle(fontSize: 22.sp, color: Colors.white),
              ),
            ),
            body: context.read<HospitalLoginProvider>().isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    reverse: true,
                    child: Form(
                      key: _formkey,
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
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                contentPadding:
                                    REdgeInsets.fromLTRB(10, 0, 0, 0),
                                hintText: ("Email"),
                              ),
                            ),
                          ),
                          Padding(
                            padding: REdgeInsets.fromLTRB(40, 0, 40, 10),
                            child: TextFormField(
                              controller: pw,
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
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 0, 0),
                                hintText: ("Password"),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                await context
                                    .read<HospitalLoginProvider>()
                                    .loginHospital(email.text, pw.text);
                                if (
                                await context
                                    .read<HospitalLoginProvider>()
                                    .getIsValidHospital()) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const PatientList(),
                                    ),
                                  );
                                }
                              } else {
                                return;
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
                                borderRadius: BorderRadius.circular(5.0.r),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Don't have your hospital registered?",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: ' Sign Up',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      //
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterHospital(),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      );
}
