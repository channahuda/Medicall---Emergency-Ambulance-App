
class PatientModel {
  String? id;
  String? name;
  String gender;
  int? age;
  String emergencyType;
  late double bloodPressure;
  late double oxygenLevel;
  late double heartRate;
  String? patientSymptoms;
  String? emergencyTreatmentGiven;

  PatientModel(
      {this.name,
      this.id,
      required this.gender,
      this.age,
      required this.emergencyType,
      required this.bloodPressure,
      required this.oxygenLevel,
      required this.heartRate,
      this.patientSymptoms,
      this.emergencyTreatmentGiven});

  static PatientModel fromJson(Map<String, dynamic> json) {
    return PatientModel(
      name: json['name'] as String?,
      gender: json['gender'] as String,
      age: json['age'] as int?,
      emergencyType: json['emergencyType'] as String,

      //emergencyType: json['emergencyType'] as EmergencyType,
      bloodPressure: json['bloodPressure'] as double,
      oxygenLevel: json['oxygenLevel'] as double,
      heartRate: json['heartRate'] as double,
      patientSymptoms: json['patientSymptoms'] as String?,
      emergencyTreatmentGiven: json['emergencyTreatmentGiven'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
  //  data['id'] = id;
    data['gender'] = gender;
    data['age'] = age;
    data['emergencyType'] = emergencyType;
    data['bloodPressure'] = bloodPressure;
    data['oxygenLevel'] = oxygenLevel;
    data['heartRate'] = heartRate;
    data['patientSymptoms'] = patientSymptoms;
    data['emergencyTreatmentGiven'] = emergencyTreatmentGiven;
    return data;
  }
}
