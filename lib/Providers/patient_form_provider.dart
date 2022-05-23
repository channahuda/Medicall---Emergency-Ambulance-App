import 'package:flutter/material.dart';
import 'package:medicall/Model/hospital_model.dart';
import 'package:medicall/Model/patient_model.dart';
import 'package:medicall/Network_Layer/firebase_network_call.dart';

class PatientFormProvider extends ChangeNotifier {
  final FirebaseNetworkCall _hospitalServices = FirebaseNetworkCall();

  addPatientsList(PatientModel patient, HospitalModel hospital) async {
    _hospitalServices.addPatient(patient, hospital);
    notifyListeners();
  }
}
