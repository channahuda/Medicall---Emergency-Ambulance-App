import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicall/Model/hospital_model.dart';
import 'package:medicall/Model/patient_model.dart';
import 'package:medicall/Providers/patient_form_provider.dart';
import 'package:medicall/Providers/patient_list_provider.dart';
import 'package:medicall/Widgets/gender_drop_down.dart';
import 'package:medicall/Widgets/drop_down.dart';
import 'package:medicall/Widgets/headings.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientForm extends StatefulWidget {
  HospitalModel hospitalModel;

  PatientForm({Key? key, required this.hospitalModel}) : super(key: key);

  @override
  _PatientFormState createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {
  final formkey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController bp = TextEditingController();
  TextEditingController oxygen = TextEditingController();
  TextEditingController rate = TextEditingController();
  TextEditingController symptom = TextEditingController();
  TextEditingController treatment = TextEditingController();
  TextEditingController gender = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PatientFormProvider patientFormProvider =
        Provider.of<PatientFormProvider>(context);
    PatientListProvider patientListProvider =
        Provider.of<PatientListProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: const Color(0xffF8F8F8),
          appBar: AppBar(
            backgroundColor: const Color(0xFF353559),
            centerTitle: true,
            title: Text(
              'Patient Form',
              style: TextStyle(fontSize: 22.sp, color: Colors.white),
            ),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Padding(
                          padding: REdgeInsets.fromLTRB(0, 20, 250, 10),
                          child: Headings(text: "Patient Name"),
                        ),
                        Padding(
                          padding: REdgeInsets.fromLTRB(10, 0, 10, 5),
                          child: txtFormField(lines: 1, width: 400.0, c: name),
                          //EMERGENCY TREATMENT
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
                              padding: REdgeInsets.fromLTRB(10, 0, 10, 9),
                              // child: GenderDropDown(validkey: formkey,)
                              //TxtFormField(lines:1, width:175,c: gender),
                              child: SizedBox(
                                height: 50.h,
                                width: 170.w,
                                child: GenderDropDown(
                                  onGenderSelected: (val) {
                                    gender.text = val;
                                  },
                                ),
                              ),
                            ),
                            // FOR AGE
                            Padding(
                              padding: REdgeInsets.fromLTRB(4, 0, 5, 10),
                              child: NumTxtFormField(
                                  lines: 1, width: 150.0, c: age),
                            ),
                          ],
                        ),
                        Padding(
                          padding: REdgeInsets.fromLTRB(2, 10, 230, 10),
                          child: Headings(text: 'Emergency Type'),
                        ),
                        Padding(
                          padding: REdgeInsets.fromLTRB(10, 0, 10, 15),
                          child: SizedBox(
                            height: 50.h,
                            width: 400.w,
                            child: DropDown(
                              onTypeSelected: (val) {
                                type.text = val;
                              },
                            ),
                          ),
                        ),
                        //VITAL STATS
                        Padding(
                          padding: REdgeInsets.fromLTRB(0, 10, 255, 10),
                          child: Headings(text: 'Vital Statistics'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Spacer(),
                            vitalStats(
                                image: 'Assets/blood.png',
                                heading: 'Blood Pressure',
                                c: bp),
                            const Spacer(),
                            vitalStats(
                              image: 'Assets/oxygen.png',
                              heading: 'Oxygen Level',
                              c: oxygen,
                            ),
                            const Spacer(),
                            vitalStats(
                              image: 'Assets/heart.png',
                              heading: 'Heart Rate',
                              c: rate,
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
                          child:
                              txtFormField(lines: 1, width: 400.0, c: symptom),
                          //EMERGENCY TREATMENT
                        ),
                        Padding(
                          padding: REdgeInsets.fromLTRB(0, 10, 137, 10),
                          child: Headings(text: "Emergency Treatment Given"),
                        ),
                        Padding(
                          padding: REdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: txtFormField(
                              lines: 4, width: 400.0, c: treatment),
                          //EMERGENCY TREATMENT
                        ),
                        Padding(
                          padding: REdgeInsets.fromLTRB(40, 0, 40, 85),
                          child: ElevatedButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                final patient = PatientModel(
                                  name: name.text,
                                  age: (age.text == "")
                                      ? null
                                      : int.parse(age.text),
                                  heartRate: double.parse(rate.text),
                                  gender: (gender.text == "")
                                      ? 'Not Specified'
                                      : (gender.text),
                                  bloodPressure: double.parse(bp.text),
                                  oxygenLevel: double.parse(oxygen.text),
                                  patientSymptoms: symptom.text,
                                  emergencyTreatmentGiven: treatment.text,
                                  emergencyType: (type.text == "")
                                      ? 'Not Specified'
                                      : (type.text),
                                );
                                patientFormProvider.addPatientsList(
                                  patient,
                                  widget.hospitalModel,
                                );
                                patientListProvider.loadPatientList();
                                name.clear();
                                age.clear();
                                type.clear();
                                bp.clear();
                                oxygen.clear();
                                rate.clear();
                                symptom.clear();
                                treatment.clear();
                              } else {
                                return null;
                              }
                            },
                            child: const Text('Submit'),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xff353559),
                              padding: REdgeInsets.symmetric(
                                  horizontal: 80.w, vertical: 9.h),
                              textStyle: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.w500),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0.r),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget txtFormField({lines, width, c}) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (BuildContext context) => SizedBox(
        width: width,
        child: TextFormField(
          maxLines: lines,
          style: TextStyle(fontSize: 16.sp),
          controller: c,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.w, color: Colors.black),
              borderRadius: BorderRadius.circular(7.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.r)),
              borderSide: BorderSide(width: 1.w, color: Colors.black),
            ),
            contentPadding: REdgeInsets.fromLTRB(10, 5, 0, 0),
          ),
        ),
      ),
    );
  }

  Widget NumTxtFormField({lines, width, c}) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (BuildContext context) => SizedBox(
        width: width,
        child: TextFormField(
          maxLines: lines,
          style: TextStyle(fontSize: 16.sp),
          controller: c,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
          ],
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.w, color: Colors.black),
              borderRadius: BorderRadius.circular(7.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.r)),
              borderSide: BorderSide(width: 1.w, color: Colors.black),
            ),
            contentPadding: REdgeInsets.fromLTRB(10, 5, 0, 0),
          ),
        ),
      ),
    );
  }

  Widget vitalStats({image, heading, c}) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (BuildContext context) => Container(
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
                    color: Color(0xff353559),
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
                  style: TextStyle(fontSize: 13.sp),
                  controller: c,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                  ],
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '';
                    } else
                      return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
