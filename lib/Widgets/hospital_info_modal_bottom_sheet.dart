import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicall/Model/hospital_model.dart';
import 'package:medicall/Providers/nearest_location_provider.dart';
import 'package:provider/provider.dart';

import '../View/patient_form.dart';

class DisplayHospitalInfo extends StatefulWidget {
  HospitalModel hospitalSelected;

  DisplayHospitalInfo({required this.hospitalSelected, Key? key})
      : super(key: key);

  @override
  State<DisplayHospitalInfo> createState() => _DisplayHospitalInfoState();
}

class _DisplayHospitalInfoState extends State<DisplayHospitalInfo> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context) => Wrap(
        children: [
          Padding(
            padding: REdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.hospitalSelected.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff353559),
                      fontSize: 22.sp,
                    ),
                  ),
                ]),
          ),
          ListTile(
            contentPadding: REdgeInsets.fromLTRB(30, 0, 0, 0),
            tileColor: const Color(0xffF8F8F8),
            leading: Image.asset(
              'Assets/phone-68-64.png',
              height: 20.h,
            ),
            title: Text(
              widget.hospitalSelected.phoneNumber,
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
          const Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: Colors.grey,
          ),
          ListTile(
            contentPadding: REdgeInsets.fromLTRB(30, 0, 0, 0),
            tileColor: const Color(0xffF8F8F8),
            leading: Image.asset(
              'Assets/icons8-sleeping-in-bed-64.png',
              height: 20.h,
            ),
            title: Text(
              '${widget.hospitalSelected.beds}',
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
          const Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: Colors.grey,
          ),
          ListTile(
            contentPadding: REdgeInsets.fromLTRB(30, 0, 0, 0),
            //horizontalTitleGap: 30.0,
            tileColor: const Color(0xffF8F8F8),
            leading: Image.asset(
              'Assets/icons8-map-pin-64.png',
              height: 20.h,
            ),
            title: Text(
              widget.hospitalSelected.address,
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
          const Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: Colors.grey,
          ),
          ListTile(
            contentPadding: REdgeInsets.fromLTRB(30, 0, 0, 0),
            //horizontalTitleGap: 30.0,
            tileColor: const Color(0xffF8F8F8),
            leading: Image.asset(
              'Assets/email-5-64.png',
              height: 20.h,
            ),
            title: Text(
              widget.hospitalSelected.email,
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
          Row(
            children: [
              const Spacer(),
              SizedBox(
                height: 40.h,
                width: 150.w,
                child: ElevatedButton(
                  child: const Text('Directions'),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff353559),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 9.h),
                    textStyle:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0.r),
                    ),
                  ),
                  onPressed: () {
                    context.read<NearestLocationProvider>().launchMap(
                        widget.hospitalSelected.lat,
                        widget.hospitalSelected.lng);
                  },
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 40.h,
                width: 150.w,
                child: ElevatedButton(
                  child: const Text('Patient Form'),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff353559),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 9.h),
                    textStyle:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientForm(
                          hospitalModel: widget.hospitalSelected,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Spacer()
            ],
          ),
          SizedBox(
            height: 60.h,
          ),
        ],
      ),
    );
  }
}
