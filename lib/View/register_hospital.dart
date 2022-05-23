import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medicall/Model/hospital_model.dart';
import 'package:medicall/Model/user_model.dart';
import 'package:medicall/Providers/nearest_location_provider.dart';
import 'package:medicall/Providers/hospital_register_provider.dart';
import 'package:medicall/View/hospital_login.dart';
import 'package:provider/provider.dart';

class RegisterHospital extends StatefulWidget {
  const RegisterHospital({Key? key}) : super(key: key);

  @override
  _RegisterHospitalState createState() => _RegisterHospitalState();
}

class _RegisterHospitalState extends State<RegisterHospital> {
  final _formkey = GlobalKey<FormState>();
  List<Marker> mark = [];
  TextEditingController hospitalName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pw = TextEditingController();
  TextEditingController cpw = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController beds = TextEditingController();

  @override
  Widget build(BuildContext context) {
    HospitalRegisterProvider hospitalProvider =
        Provider.of<HospitalRegisterProvider>(context);
    NearestLocationProvider hospitalLocationProvider =
        Provider.of<NearestLocationProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          //because overflow occurs when keyboard pops up
          backgroundColor: const Color(0xffF8F8F8),
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            backgroundColor: const Color(0xFF353559),
            centerTitle: true,
            title: Text(
              'Register Hospital',
              style: TextStyle(fontSize: 22.sp, color: Colors.white),
            ),
          ),
          body: hospitalProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 15.h),
                              Padding(
                                padding:
                                    REdgeInsets.symmetric(horizontal: 40.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    inputFile(
                                        label: "Hospital Name",
                                        obscureText: false,
                                        TextEditingController: hospitalName),
                                    inputFile(
                                        label: "Email",
                                        obscureText: false,
                                        TextEditingController: email),
                                    inputFile(
                                        label: "Password",
                                        obscureText: true,
                                        TextEditingController: pw),
                                    inputFileCPassword(
                                        label: "Confirm Password",
                                        textEditingController: cpw),
                                    inputFile(
                                        label: "Address",
                                        obscureText: false,
                                        TextEditingController: address),
                                    inputFile(
                                        label: "City",
                                        obscureText: false,
                                        TextEditingController: city),
                                    inputFileNumber(
                                      label: "Contact Number",
                                      textEditingController: number,
                                    ),
                                    inputFileNumber(
                                        label: "Number of Beds in Hospital",
                                        textEditingController: beds),
                                    Text(
                                      'Mark Location on Map',
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              //this form is inside w_register_form
                              Stack(
                                children: <Widget>[
                                  Container(
                                    height: 320.h,
                                    width: 300.w,
                                    margin: REdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black26),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: GoogleMap(
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                          hospitalProvider.position.latitude,
                                          hospitalProvider.position.longitude,
                                        ),
                                        zoom: 16,
                                      ),
                                      mapType: MapType.normal,
                                      onTap: (LatLng latLng) {
                                        Marker newMark = Marker(
                                          markerId:
                                              const MarkerId('Places Name'),
                                          icon: BitmapDescriptor
                                              .defaultMarkerWithHue(
                                                  BitmapDescriptor.hueRed),
                                          position: LatLng(latLng.latitude,
                                              latLng.longitude),
                                        );
                                        mark.add(newMark);
                                        setState(() {});
                                      },
                                      markers: mark.map((e) => e).toSet(),
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    //NEED TO CHANGE THIS OFCOURSE
                                    final hospital = HospitalModel(
                                      name: hospitalName.text,
                                      password: cpw.text,
                                      address: address.text,
                                      email: email.text,
                                      lng: mark[0].position.longitude,
                                      lat: mark[0].position.latitude,
                                      beds: int.parse(beds.text),
                                      city: city.text,
                                      phoneNumber: number.text,
                                    );
                                    final user = UserModel(
                                        email: email.text, isHospital: true);
                                    Provider.of<HospitalRegisterProvider>(
                                            context,
                                            listen: false)
                                        .addHospitalsList(hospital, user);
                                    hospitalLocationProvider
                                        .loadHospitalsList();
                                    Navigator.pushAndRemoveUntil(
                                        (context),
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HospitalLogin(),
                                        ),
                                        (route) => false);
                                  }
                                },
                                child: const Text('Register'),
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff353559),
                                  padding: REdgeInsets.symmetric(
                                      horizontal: 120.w, vertical: 15.h),
                                  textStyle: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0.r),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.h),
                            ],
                          ),
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
    );
  }

  Widget inputFileCPassword({label, textEditingController}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        TextFormField(
          controller: textEditingController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            if (pw.text != value) {
              return 'Passwords do not match';
            }
            return null;
          },
          obscureText: true,
          decoration: InputDecoration(
            contentPadding:
                REdgeInsets.symmetric(vertical: 0, horizontal: 10.w),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Colors.black26)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Colors.black45)),
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget inputFileNumber({label, textEditingController}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          controller: textEditingController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            if (textEditingController == number && number.text.length != 11) {
              return "Invalid Contact Number";
            }
            return null;
          },
          obscureText: false,
          decoration: InputDecoration(
            contentPadding:
                REdgeInsets.symmetric(vertical: 0, horizontal: 10.w),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Colors.black26)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Colors.black45)),
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget inputFile({label, obscureText, TextEditingController}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black),
        ),
        SizedBox(
          height: 5.h,
        ),
        TextFormField(
          controller: TextEditingController,
          validator: (value) {
            RegExp regex = RegExp(r'^.{6,}$');
            if (value == null || value.isEmpty) {
              return 'This field is required';
            } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                    .hasMatch(value) &&
                TextEditingController == email) {
              return ("Please Enter a valid email");
            }
            if (!regex.hasMatch(value) && TextEditingController == pw) {
              return "Enter Valid Password(Min. 6 Characters)";
            }
            return null;
          },
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding:
                REdgeInsets.symmetric(vertical: 0, horizontal: 10.w),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Colors.black26)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Colors.black45)),
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
