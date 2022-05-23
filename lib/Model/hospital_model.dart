class HospitalModel {
  late String name;
  late String? id;
  late String? password;
  late String phoneNumber;
  late int beds;
  late String address;
  late double lat;
  late double lng;
  late String city;
  late String email;

  HospitalModel(
      {required this.name,
      this.password,
      this.id,
      required this.lat,
      required this.lng,
      required this.city,
      required this.email,
      required this.address,
      required this.beds,
      required this.phoneNumber});

  static HospitalModel fromJson(Map<String, dynamic> json) {
    return HospitalModel(
        name: json['name'] as String,
        lat: json['lat'] as double,
        lng: json['lng'] as double,
        city: json['city'] as String,
        email: json['email'] as String,
        address: json['address'] as String,
        beds: json['beds'] as int,
        phoneNumber: json['phoneNumber'] as String);
  }

  //Map<String, dynamic>
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['lat'] = lat;
    data['lng'] = lng;
    data['city'] = city;
    data['email'] = email;
    data['address'] = address;
    data['beds'] = beds;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
