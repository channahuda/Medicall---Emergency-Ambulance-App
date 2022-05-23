import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Headings extends StatefulWidget {
  String text;

  Headings({Key? key, required this.text}) : super(key: key);

  @override
  State<Headings> createState() => _HeadingsState();
}

class _HeadingsState extends State<Headings> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (BuildContext context) => Text(
        widget.text,
        style: TextStyle(
          fontSize: 16.sp,
          color: const Color(0xff353559),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
