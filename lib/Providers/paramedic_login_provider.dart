import 'package:flutter/cupertino.dart';
import 'package:medicall/Network_Layer/firebase_network_call.dart';

class ParamedicLoginProvider extends ChangeNotifier {
  final FirebaseNetworkCall _hospitalServices = FirebaseNetworkCall();
  bool isLoading = false;
  bool _isValid = false;

  Future<bool> getIsValidParamedic() async {
    return await _isValid;
  }

  Future<void> loginHospital(String email, String password) async {
    isLoading = true;
    notifyListeners();
    _isValid = await _hospitalServices.signInParamedic(email, password);
    isLoading = false;
    notifyListeners();
  }
}
