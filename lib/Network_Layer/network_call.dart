import 'package:medicall/Model/hospital_model.dart';

import '../Model/hospital_model.dart';
import '../Model/patient_model.dart';
import '../Model/user_model.dart';

abstract class NetworkCall {

  Future<List<HospitalModel>> getHospitals();

  void addHospital(HospitalModel hospital, UserModel user);

  Future<List<PatientModel>> getPatients();

  void addPatient(PatientModel patient, HospitalModel hospital);

  Future<void> deletePatient(PatientModel patient);

  void updateHospital(String hospitalName, String email, String address,
      String city, String contact, int beds);

}

