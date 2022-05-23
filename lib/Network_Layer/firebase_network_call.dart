import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medicall/Model/patient_model.dart';
import 'package:medicall/View/login.dart';
import 'package:medicall/View/nearest_location.dart';
import 'package:medicall/View/patient_list.dart';

import '../Model/hospital_model.dart';
import '../Model/user_model.dart';
import 'network_call.dart';

class FirebaseNetworkCall implements NetworkCall {
  String hospitalCollection = "Hospitals";
  String userCollection = "Users";
  String patientCollection = "Patients";

//  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _hospitaauth = FirebaseAuth.instance;

  @override
  Future<List<HospitalModel>> getHospitals() async {
    List<HospitalModel> hospitalList = [];

    FirebaseFirestore.instance
        .collection('Hospitals')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        HospitalModel hospital =
            HospitalModel.fromJson(doc.data() as Map<String, dynamic>);
        hospital.id = doc.id;
        if(hospital.beds!=0) {
          hospitalList.add(hospital);
        }
      }
    });

    return hospitalList;
  }

  @override
  void addHospital(HospitalModel hospital, UserModel user) {
    CollectionReference hospitalList =
        FirebaseFirestore.instance.collection(hospitalCollection);
    hospitalList.doc(hospital.id).set(hospital.toJson()).catchError(
          (error) => CupertinoAlertDialog(
            title: const Text("Failed to register hospital"),
            content: Text("$error"),
          ),
        );
    CollectionReference userList =
        FirebaseFirestore.instance.collection(userCollection);
    userList.doc(user.id).set(user.toJson()).catchError(
          (error) => CupertinoAlertDialog(
            title: const Text("Failed to register hospital as a user"),
            content: Text("$error"),
          ),
        );
    Fluttertoast.showToast(msg: "Hospital added successfully ");
  }

  @override
  Future<List<PatientModel>> getPatients() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    List<PatientModel> patientList = [];
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection(hospitalCollection)
          .doc(firebaseUser.uid)
          .collection(patientCollection)
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          PatientModel patient =
              PatientModel.fromJson(doc.data() as Map<String, dynamic>);
          patient.id = doc.id;
          patientList.add(patient);
        }
      });
    }
    return patientList;
  }

  @override
  void addPatient(PatientModel patient, HospitalModel hospital) {
    CollectionReference PatientList = FirebaseFirestore.instance
        .collection(hospitalCollection)
        .doc(hospital.id)
        .collection(patientCollection);
    PatientList.add(patient.toJson()).then((value) {
      patient.id = value.id;
      Fluttertoast.showToast(msg: "Form has been submitted");
    }).catchError(
        (error) => Fluttertoast.showToast(msg: "Failed to submit details"));
    FirebaseFirestore.instance
        .collection(hospitalCollection)
        .doc(hospital.id)
        .update({'beds': hospital.beds - 1}).catchError(
            (error) => Fluttertoast.showToast(msg: "Failed to reserve bed"));
  }

  @override
  Future<void> deletePatient(PatientModel patient) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      CollectionReference PatientList = await FirebaseFirestore.instance
          .collection(hospitalCollection)
          .doc(firebaseUser.uid)
          .collection(patientCollection);
      PatientList.doc(patient.id).delete().catchError(
          (error) => Fluttertoast.showToast(msg: "Failed to delete user"));

// getting beds from collection
      final hospital = await FirebaseFirestore.instance
          .collection(hospitalCollection)
          .doc(firebaseUser.uid)
          .get();
      final hospitalModel =
      HospitalModel.fromJson(hospital.data() as Map<String, dynamic>);
     hospitalModel.id=hospital.id;
      //add beds when pateint is deleted
      FirebaseFirestore.instance
          .collection(hospitalCollection)
          .doc(hospitalModel.id)
          .update({'beds': (hospitalModel.beds + 1)}).catchError(
              (error) => Fluttertoast.showToast(msg: "Failed to add bed"));

    } else {
      Fluttertoast.showToast(msg: "Failed to delete user");
    }
  }

  Future<bool> signInHospital(String email, String password) async {
    bool isValid = false;
    String? errorMessage;
    DocumentSnapshot snapshot = (await FirebaseFirestore.instance
            .collection(userCollection)
            .where("email", isEqualTo: email)
            .get())
        .docs
        .first;
    if (snapshot.exists) {
      if ((snapshot.data()! as Map<String, dynamic>)['isHospital'] as bool) {
        try {
          await _hospitaauth
              .signInWithEmailAndPassword(email: email, password: password)
              .then((uid) => {
                    isValid = true,
                    Fluttertoast.showToast(msg: "Login Successful"),
                  });
        } on FirebaseAuthException catch (error) {
          switch (error.code) {
            case "invalid-email":
              errorMessage = "Your email address appears to be malformed.";
              break;
            case "invalid-uid":
              errorMessage = "Your email address appears to be malformed.";
              break;
            case "wrong-password":
              errorMessage = "Your password is wrong.";
              break;
            case "user-not-found":
              errorMessage = "User with this email doesn't exist.";
              break;
            case "user-disabled":
              errorMessage = "User with this email has been disabled.";
              break;
            case "too-many-requests":
              errorMessage = "Too many requests";
              break;
            case "operation-not-allowed":
              errorMessage =
                  "Signing in with Email and Password is not enabled.";
              break;
            default:
              errorMessage = "An undefined Error happened.";
          }
          Fluttertoast.showToast(msg: errorMessage);
        }
      } else if ((snapshot.data()! as Map<String, dynamic>)['isHospital']
              as bool ==
          false) {
        Fluttertoast.showToast(msg: "Attempt to Login Failed");
      }
    } else if (snapshot.data() == null) {
      Fluttertoast.showToast(msg: "Account with this email does not exist");
    }
    return isValid;
  }

  void signUpHospital(HospitalModel hospital, UserModel user) async {
    String? errorMessage;
    try {
      await _hospitaauth
          .createUserWithEmailAndPassword(
              email: hospital.email, password: hospital.password!)
          .then((value) => {
                hospital.id = value.user?.uid,
                addHospital(hospital, user),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage);
    }
  }

  Future<bool> signOut() async {
    bool isValid = false;
    await FirebaseAuth.instance
        .signOut()
        .then((value) => isValid = true)
        .catchError((error) => Exception('User is null'));
    return isValid;
  }

  Future<bool> signInParamedic(String email, String password) async {
    bool isValid = false;
    String? errorMessage;
    DocumentSnapshot snapshot = (await FirebaseFirestore.instance
            .collection(userCollection)
            .where("email", isEqualTo: email)
            .get())
        .docs
        .first;
    if (snapshot.exists) {
      if ((snapshot.data()! as Map<String, dynamic>)['isHospital'] as bool ==
          false) {
        try {
          await _hospitaauth
              .signInWithEmailAndPassword(email: email, password: password)
              .then((uid) => {
                    isValid = true,

            Fluttertoast.showToast(msg: "Login Successful"),
                  });
        } on FirebaseAuthException catch (error) {
          switch (error.code) {
            case "invalid-email":
              errorMessage = "Your email address appears to be malformed.";
              break;
            case "wrong-password":
              errorMessage = "Your password is wrong.";
              break;
            case "user-not-found":
              errorMessage = "User with this email doesn't exist.";
              break;
            case "user-disabled":
              errorMessage = "User with this email has been disabled.";
              break;
            case "too-many-requests":
              errorMessage = "Too many requests";
              break;
            case "operation-not-allowed":
              errorMessage =
                  "Signing in with Email and Password is not enabled.";
              break;
            default:
              errorMessage = "An undefined Error happened.";
          }
          Fluttertoast.showToast(msg: errorMessage);
        }
      } else if ((snapshot.data()! as Map<String, dynamic>)['isHospital']
              as bool ==
          true) {
        Fluttertoast.showToast(msg: "Attempt to Login Failed");
      }
    } else if (snapshot.data() == null) {
      Fluttertoast.showToast(msg: "Account with this email does not exist");
    }
    return isValid;
  }

  Future<HospitalModel?> fetchHospital() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      final hospital = await FirebaseFirestore.instance
          .collection(hospitalCollection)
          .doc(firebaseUser.uid)
          .get();
      final hospitalModel =
          HospitalModel.fromJson(hospital.data() as Map<String, dynamic>);
      return hospitalModel;
    } else {
      throw Exception('User is null');
    }
  }

  @override
  void updateHospital(String hospitalName, String email, String address,
      String city, String contact, int beds) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      CollectionReference HospitalList =
          FirebaseFirestore.instance.collection(hospitalCollection);
      HospitalList.doc(firebaseUser.uid).update({
        'name': hospitalName,
        'email': email,
        'address': address,
        'beds': beds,
        'city': city,
        'phoneNumber': contact
      }).catchError((error) =>
          Fluttertoast.showToast(msg: "Hospital Could not be updated"));
    } else {
      Fluttertoast.showToast(msg: "Hospital Could not be updated");
    }
  }
}
