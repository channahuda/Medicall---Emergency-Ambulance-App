import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDown extends StatefulWidget {
  //String val = 'Road Accident';
  final Function(String val) onTypeSelected;

  const DropDown({Key? key, required this.onTypeSelected}) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String dropdownValue = 'Road Accident';
  List<String> cases = [
    'Road Accident',
    'Heart Attack/Chest Pain',
    'Burn Victim',
    'Fractured Bones',
    'Gun Shot',
    'Abdominal Pain',
    'Suicide Attempt',
    'Allergic Reaction'
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //  designSize: const Size(360,800),
      builder: (BuildContext context) => Container(
        decoration: BoxDecoration(
          color: const Color(0xfffdab9f).withOpacity(0.02),
          borderRadius: BorderRadius.circular(7.0.r),
          border: Border.all(
            color: Colors.black,
            width: 1.w,
          ),
        ),
        height: 50.h,
        width: 200.w,
        child: Padding(
          padding: EdgeInsets.only(left: 10).r,
          child: DropdownButton<String>(
            value: dropdownValue,
            hint: SizedBox(
              width: 300.w,
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Color(0xff353559),
            ),
            //elevation: 200,

            style: TextStyle(color: const Color(0xff353559), fontSize: 16.sp),

            items: cases.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                if (newValue != null) {
                  dropdownValue = newValue;
                  widget.onTypeSelected(newValue);
                } else {
                  widget.onTypeSelected(dropdownValue);
                }
              },);
            },
          ),
        ),
      ),
    );
  }
}
