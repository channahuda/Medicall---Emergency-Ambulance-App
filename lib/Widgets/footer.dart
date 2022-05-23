import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicall/Widgets/logout_hospital.dart';
import 'package:medicall/View/patient_list.dart';

//import 'package:shared_preferences/shared_preferences.dart';
import 'package:medicall/View/edit_hospital.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  Color iconColor = Colors.black;

  //late SharedPreferences logindata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context) => Table(
        border: const TableBorder(top: BorderSide(color: Colors.black)),
        children: <TableRow>[
          TableRow(
            decoration: const BoxDecoration(
              color: Color(0xffF8F8F8),
            ),
            children: <Widget>[
              TableCell(
                child: SizedBox(
                  height: 60.h,
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Image.asset(
                          'Assets/icons8-form-64.png',
                          height: 25.h,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PatientList(),
                            ),
                          );
                        },
                      ),
                      InkWell(
                        child: Text(
                          'Emergency Patients',
                          style:
                              TextStyle(color: Colors.black, fontSize: 10.sp),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PatientList(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              TableCell(
                child: SizedBox(
                  height: 60.h,
                  //  width: 64,
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Image.asset(
                          'Assets/icons8-hospital-3-64.png',
                          color: iconColor,
                          height: 25.h,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditHospital(),
                              ));
                        },
                      ),
                      InkWell(
                        child: Text(
                          'Profile',
                          style:
                              TextStyle(color: Colors.black, fontSize: 10.sp),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditHospital(),
                              ));
                        },
                      )
                    ],
                  ),
                ),
              ),
              TableCell(
                child: SizedBox(
                  height: 60.h,
                  //width: 64,
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Image.asset(
                          'Assets/logout.png',
                          color: Colors.black,
                          height: 25.h,
                        ),
                        onPressed: () {
                          LogoutHospital logout = LogoutHospital();
                          logout.showLogoutDialog(context);
                        },
                      ),
                      InkWell(
                        child: Text(
                          'Logout',
                          style:
                              TextStyle(color: Colors.black, fontSize: 10.sp),
                        ),
                        onTap: () {
                          LogoutHospital logout = LogoutHospital();
                          logout.showLogoutDialog(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
