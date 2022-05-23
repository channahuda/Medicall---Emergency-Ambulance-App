import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medicall/Providers/edit_hospital_provider.dart';
import 'package:medicall/View/patient_list.dart';
import 'package:provider/provider.dart';
import '../Widgets/exit_bottom_sheet.dart';
import '../Widgets/footer.dart';

class EditHospital extends StatefulWidget {
  const EditHospital({Key? key}) : super(key: key);

  @override
  _EditHospitalState createState() => _EditHospitalState();
}

class _EditHospitalState extends State<EditHospital> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController hospitalName = TextEditingController(text: '');
  TextEditingController password = TextEditingController();
  TextEditingController cpassword = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController beds = TextEditingController();

  List<Marker> mark = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initHospital();
  }

  void initHospital() {
    context.read<EditHospitalProvider>().editHospital();
  }

  @override
  Widget build(BuildContext context) {
    final hospitalProvider = Provider.of<EditHospitalProvider>(context);

    return WillPopScope(
      onWillPop: () => ExitBottomSheet.onWillPop(context),
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              //because overflow occurs when keyboard pops up
              backgroundColor: const Color(0xffF8F8F8),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: const Color(0xFF353559),
                centerTitle: true,
                title: Text(
                  'Profile',
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
                                  //EditForm(),
                                  Column(
                                    children: <Widget>[
                                      SizedBox(height: 15.h),
                                      Padding(
                                        padding: REdgeInsets.symmetric(
                                            horizontal: 40.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            //
                                            inputFile(
                                                label: "Hospital Name",
                                                initVal: hospitalProvider
                                                    .hospitalModel?.name,
                                                cont: hospitalName),

                                            inputFile(
                                                label: "Email",
                                                initVal: hospitalProvider
                                                    .hospitalModel?.email,
                                                cont: email),
                                            inputFile(
                                                label: "Address",
                                                initVal: hospitalProvider
                                                    .hospitalModel?.address,
                                                cont: address),
                                            inputFile(
                                                label: "City",
                                                initVal: hospitalProvider
                                                    .hospitalModel?.city,
                                                cont: city),
                                            inputFileNumber(
                                                label: "Contact Number",
                                                initval: hospitalProvider
                                                    .hospitalModel?.phoneNumber,
                                                cont: contact),
                                            inputFileNumber(
                                                label:
                                                    "Number of Beds in Hospital",
                                                initval: hospitalProvider
                                                    .hospitalModel?.beds,
                                                cont: beds),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (_formkey.currentState!.validate()) {
                                        bool remove = false;
                                        remove = await showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Save Changes'),
                                            content: const Text(
                                                "Are you sure you want to save changes?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                  hospitalProvider
                                                      .updateHospital(
                                                    hospitalName.text,
                                                    email.text,
                                                    address.text,
                                                    city.text,
                                                    contact.text,
                                                    int.parse(beds.text),
                                                  );
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const PatientList(),
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                      color: Colors.lightBlue),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: const Text(
                                                  'No',
                                                  style: TextStyle(
                                                      color: Colors.lightBlue),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                        //setState(() {});
                                      }
                                    },
                                    child: const Text('Save Changes'),
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color(0xff353559),
                                      padding: REdgeInsets.symmetric(
                                          horizontal: 80.w, vertical: 15.h),
                                      textStyle: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0.r),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 100.h),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                        )
                      ],
                    ),
              //resizeToAvoidBottomInset: false,
              bottomSheet: const Footer(),
            ),
          );
        },
      ),
    );
  }

  Widget inputFile({label, initVal, cont}) {
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
          controller: cont..text = initVal,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                    .hasMatch(value) &&
                cont == email) {
              return ("Please Enter a valid email");
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

  Widget inputFileNumber({label, cont, initval}) {
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
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          controller: cont..text = initval.toString(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            if (cont == contact && contact.text.length != 11) {
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
}
