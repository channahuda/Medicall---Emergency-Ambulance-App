import 'package:flutter/cupertino.dart';
import 'package:medicall/Model/patient_model.dart';
import 'package:medicall/Network_Layer/firebase_network_call.dart';

class PatientListProvider extends ChangeNotifier {
  late bool isLoading;
  final FirebaseNetworkCall _hospitalServices = FirebaseNetworkCall();
  late List<PatientModel> listOfPatients;
  bool isValid = false;

  // PatientListProvider() {
  //   loadPatientList();
  // }

  //
  // Future<bool> getisValid() async {
  //   return await _isValid;
  // }

  Future<void> signOut() async {
    isLoading = true;
    isValid = await _hospitalServices.signOut();
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadPatientList() async {
    isLoading = true;
    notifyListeners();
    listOfPatients = await _hospitalServices.getPatients();
    isLoading = false;
    notifyListeners();
  }

  Future<void> deletePatients(PatientModel patient) async {
    isLoading = true;
    notifyListeners();
    await _hospitalServices.deletePatient(patient);

    isLoading = false;
    loadPatientList();
    notifyListeners();
  }
}
