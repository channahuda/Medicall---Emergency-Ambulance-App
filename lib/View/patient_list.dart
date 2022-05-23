import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicall/Model/patient_model.dart';
import 'package:medicall/Providers/patient_list_provider.dart';
import 'package:medicall/Widgets/footer.dart';
import 'package:provider/provider.dart';
import 'package:medicall/View/patient_details.dart';
import 'package:medicall/Widgets/exit_bottom_sheet.dart';

class PatientList extends StatefulWidget {
  const PatientList({Key? key}) : super(key: key);

  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  late PatientListProvider patientProvider;
  List<PatientModel> listOfPatients = [];

  @override
  void initState() {
    context.read<PatientListProvider>().loadPatientList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    patientProvider = Provider.of<PatientListProvider>(context);

    return WillPopScope(
      onWillPop: () => ExitBottomSheet.onWillPop(context),
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (BuildContext context) => Scaffold(
          backgroundColor: const Color(0xffF8F8F8),
          bottomSheet: const Footer(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFF353559),
            centerTitle: true,
            title: Text(
              'Emergency Patients',
              style: TextStyle(fontSize: 22.sp, color: Colors.white),
            ),
          ),
          body: patientProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //  if(patientList.isEmpty)
                    if (patientProvider.listOfPatients.isEmpty)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'You have no emergency patients',
                              style: TextStyle(
                                  fontSize: 20.0.sp,
                                  height: 4.h,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )
                    else
                      Expanded(
                        child: ListTileTheme(
                          contentPadding: REdgeInsets.all(15),
                          iconColor: Colors.black,
                          textColor: Colors.black,
                          tileColor: const Color(0xffF18793).withOpacity(0.15),
                          style: ListTileStyle.list,
                          dense: true,
                          child: ListView.builder(
                            itemCount: patientProvider.listOfPatients.length,
                            padding:
                                REdgeInsets.only(top: 10, left: 8, right: 8).r,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: REdgeInsets.only(
                                        top: 10, left: 10, right: 10)
                                    .r,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: ListTile(
                                    contentPadding:
                                        REdgeInsets.fromLTRB(12, 8, 12, 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    title: SizedBox(
                                      height: 24.h,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          (patientProvider.listOfPatients[index]
                                                      .name !=
                                                  null)
                                              ? Text(
                                                  patientProvider
                                                      .listOfPatients[index]
                                                      .name!,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.sp,
                                                  ),
                                                  textAlign: TextAlign.left)
                                              : Text(
                                                  "Anonymous",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.sp,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            onPressed: () {
                                              patientProvider.deletePatients(
                                                  patientProvider
                                                      .listOfPatients[index]);
                                              patientProvider.loadPatientList();
                                              //setState(() {});
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        const Divider(
                                          color: Colors.black54,
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          'Gender: ${patientProvider.listOfPatients[index].gender}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Emergency type: ${patientProvider.listOfPatients[index].emergencyType}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => PatientDetails(
                                            patientModel: patientProvider
                                                .listOfPatients[index],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
