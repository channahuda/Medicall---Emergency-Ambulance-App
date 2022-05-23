import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicall/View/hospital_login.dart';
import 'package:medicall/View/paramedic_login.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (BuildContext context) => Scaffold(
        backgroundColor: const Color(0xffF8F8F8),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset('Assets/Medicall (8).png',
                  width: 400.w, height: 400.h, fit: BoxFit.fill),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ParamedicLogin(),
                  ),
                );
              },
              child: const Text('Paramedic Login'),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff353559),
                padding:
                    REdgeInsets.symmetric(horizontal: 75.w, vertical: 18.h),
                textStyle:
                    TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0.r),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HospitalLogin(),
                  ),
                );
              },
              child: const Text('Hospital Login'),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xffF18793),
                padding:
                    REdgeInsets.symmetric(horizontal: 84.w, vertical: 18.h),
                textStyle:
                    TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0.r),
                ),
              ),
            ),
            SizedBox(height: 25.h),
          ],
        ),
      ),
    );
  }
}
