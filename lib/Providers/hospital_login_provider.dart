import 'package:flutter/material.dart';
import 'package:medicall/Network_Layer/firebase_network_call.dart';

class HospitalLoginProvider extends ChangeNotifier {
  final FirebaseNetworkCall _hospitalServices = FirebaseNetworkCall();
  bool isLoading = false;
  bool _isValidHospital = false;

  bool getIsValidHospital() {
    return _isValidHospital;
  }

  Future<void> loginHospital(String email, String password) async {
    isLoading = true;
    notifyListeners();
    _isValidHospital = await _hospitalServices.signInHospital(email, password);
    isLoading = false;
    notifyListeners();
  }
}
