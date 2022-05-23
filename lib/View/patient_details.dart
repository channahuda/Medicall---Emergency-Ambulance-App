import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicall/Widgets/headings.dart';
import '../Model/patient_model.dart';

class PatientDetails extends StatefulWidget {
  final PatientModel patientModel;

  const PatientDetails({Key? key, required this.patientModel})
      : super(key: key);

  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  String patientName = "";

  @override
  Widget build(BuildContext context) {
    if (widget.patientModel.name != null) {
      patientName = widget.patientModel.name!;
    }
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xffF8F8F8),
          appBar: AppBar(
            backgroundColor: const Color(0xFF353559),
            centerTitle: true,
            title: Text(
              patientName,
              style: TextStyle(fontSize: 22.sp, color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: REdgeInsets.fromLTRB(0, 20, 250, 10),
                  child: Headings(text: 'Patient Name'),
                ),
                Padding(
                  padding: REdgeInsets.fromLTRB(10, 0, 10, 5),
                  child: SizedBox(
                    height: 45.h,
                    width: 400.w,
                    child: txtField(1, 400, widget.patientModel.name),
                  ),
                ),
                Padding(
                  padding: REdgeInsets.fromLTRB(2, 10, 10, 10),
                  child: Row(
                    children: <Widget>[
                      const Spacer(
                        flex: 1,
                      ),
                      Headings(text: 'Gender'),
                      const Spacer(
                        flex: 11,
                      ),
                      Headings(text: 'Age'),
                      const Spacer(
                        flex: 10,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    //FOR NAME
                    Padding(
                      padding: REdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: txtField(1, 175, widget.patientModel.gender),
                    ),
                    // FOR AGE
                    Padding(
                      padding: REdgeInsets.fromLTRB(4, 0, 5, 10),
                      child: txtField(
                        1,
                        150,
                        widget.patientModel.age.toString(),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: REdgeInsets.fromLTRB(2, 10, 235, 10),
                  child: Headings(text: 'Emergency Type'),
                ),
                Padding(
                  padding: REdgeInsets.fromLTRB(10, 0, 10, 15),
                  child: SizedBox(
                      height: 45.h,
                      width: 400.w,
                      child: txtField(1, 400, widget.patientModel.emergencyType)
                      // child: dropdown(),
                      ),
                ),
                Padding(
                  padding: REdgeInsets.fromLTRB(0, 10, 255, 10),
                  child: Headings(text: 'Vital Statistics'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Spacer(),
                    //CHANGE THIS AFTER ADDING PROVIDER
                    vitalStat(
                      'Assets/blood.png',
                      'Blood Pressure',
                      widget.patientModel.bloodPressure.toString(),
                    ),
                    const Spacer(),
                    vitalStat(
                      'Assets/oxygen.png',
                      'Oxygen Level',
                      widget.patientModel.oxygenLevel.toString(),
                    ),
                    const Spacer(),
                    vitalStat(
                      'Assets/heart.png',
                      'Heart Rate',
                      widget.patientModel.heartRate.toString(),
                    ),
                    const Spacer(),
                  ],
                ),
                //PATIENT SYMPTOMS
                Padding(
                  padding: REdgeInsets.fromLTRB(0, 10, 200, 10),
                  child: Headings(text: "Patient's Symptoms"),
                ),
                Padding(
                  padding: REdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: txtField(1, 400, widget.patientModel.patientSymptoms),
                  //EMERGENCY TREATMENT
                ),
                Padding(
                  padding: REdgeInsets.fromLTRB(0, 10, 137, 10),
                  child: Headings(text: "Emergency Treatment Given"),
                ),
                Padding(
                  padding: REdgeInsets.fromLTRB(10, 0, 10, 25),
                  child: txtField(
                      4, 400, widget.patientModel.emergencyTreatmentGiven),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget txtField(int lines, int width, String? detail) => SizedBox(
        width: width.w,
        child: (detail != null)
            ? TextFormField(
                readOnly: true,
                maxLines: lines,
                style: TextStyle(fontSize: 16.sp),
                initialValue: detail,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1.w, color: Colors.black),
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(7.r),
                    ),
                    borderSide: BorderSide(width: 1.w, color: Colors.black),
                  ),
                  contentPadding: REdgeInsets.fromLTRB(10, 0, 0, 0),
                ),
              )
            : TextFormField(
                readOnly: true,
                maxLines: lines,
                style: TextStyle(fontSize: 16.sp),
                initialValue: " ",
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1.w, color: Colors.black),
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.r)),
                    borderSide: BorderSide(width: 1.w, color: Colors.black),
                  ),
                  contentPadding: REdgeInsets.fromLTRB(10, 0, 0, 0),
                ),
              ),
      );

  Widget vitalStat(String image, String heading, String detail) => Container(
        width: 115.w,
        height: 115.h,
        decoration: BoxDecoration(
          color: const Color(0xfffdab9f).withOpacity(0.3),
          borderRadius: BorderRadius.circular(7.0.r),
          border: Border.all(
            color: const Color(0xfffdab9f).withOpacity(0.5),
            width: 1.w,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: REdgeInsets.fromLTRB(1, 6, 1, 8),
              child: Image.asset(
                image,
                height: 30.h,
                width: 30.w,
              ),
            ),
            Padding(
              padding: REdgeInsets.fromLTRB(1, 0, 1, 10),
              child: Text(
                heading,
                style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xff353559),
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: REdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Container(
                height: 33.h,
                decoration: BoxDecoration(
                  color: const Color(0xffF8F8F8),
                  borderRadius: BorderRadius.circular(7.r),
                ),
                child: TextFormField(
                  readOnly: true,
                  style: TextStyle(fontSize: 13.sp),
                  //controller: c,
                  initialValue: detail,
                  decoration: InputDecoration(
                    contentPadding: REdgeInsets.fromLTRB(10, 0, 0, 0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.w, color: Colors.black),
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(7.r),
                      ),
                      borderSide: BorderSide(width: 1.w, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
