class UserModel {
  String? id;
  late String email;
  late bool isHospital;

  UserModel({required this.email, required this.isHospital});

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json['email'] as String, isHospital: json['isHospital'] as bool);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['email'] = email;
    data['isHospital'] = isHospital;
    return data;
  }
}
