import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderDropDown extends StatefulWidget {
  final Function(String val) onGenderSelected;

  const GenderDropDown({Key? key, required this.onGenderSelected})
      : super(key: key);

  @override
  State<GenderDropDown> createState() => _GenderDropDownState();
}

class _GenderDropDownState extends State<GenderDropDown> {
  List<String> gender = ['Male', 'Female', 'Other'];
  String dropdownValue = 'Male';

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // designSize: const Size(360,800),
      builder: (BuildContext context) => Container(
        decoration: BoxDecoration(
          color: const Color(0xfffdab9f).withOpacity(0.02),
          borderRadius: BorderRadius.circular(7.0.r),
          border: Border.all(
            color: Colors.black,
            width: 1.w,
          ),
        ),
        height: 40.h,
        width: 175.w,
        child: Padding(
          padding: EdgeInsets.only(left: 10).r,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: dropdownValue,
              hint: SizedBox(
                width: 130.w,
              ),
              //SizedBox(width: 135.w,),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Color(0xff353559),
              ),
              //elevation: 200,

              style: TextStyle(color: Color(0xff353559), fontSize: 16.sp),

              items: gender.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(
                  () {
                    if (newValue != null) {
                      dropdownValue = newValue;
                      widget.onGenderSelected(newValue);
                    } else {
                      widget.onGenderSelected(dropdownValue);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
