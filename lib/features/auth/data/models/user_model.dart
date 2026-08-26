/// data/models/user_model.dart
library;

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    required super.phone,
    required super.name,
    required super.type,
    required super.profession,
    required super.serviceCategory,
    required super.yearsOfExperience,
    super.latitude,
    super.longitude,
    super.city,
    super.district,
    super.locationUrl,

    /// 🔥 الجديد
    super.imageUrl,
    required super.password,
    required super.state,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['id'] ?? '',
      phone: map['phone'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      profession: map['profession'] ?? '',
      serviceCategory: map['serviceCategory'] ?? '',
      yearsOfExperience: map['yearsOfExperience'] ?? 0,

      latitude: (map['latitude'] ?? 0).toDouble(),
      longitude: (map['longitude'] ?? 0).toDouble(),
      city: map['city'] ?? '',
      district: map['district'] ?? '',
      locationUrl: map['locationUrl'] ?? '',

      /// 👇 هنا المهم
      imageUrl: map['imageUrl'] ?? '',
      password: map['password'] ?? '',
      state: map['state'] ?? "1",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': uid,
      'phone': phone,
      'name': name,
      'type': type,
      'profession': profession,
      'serviceCategory': serviceCategory,
      'yearsOfExperience': yearsOfExperience,
      'latitude': latitude,
      'longitude': longitude,
      'city': city,
      'district': district,
      'locationUrl': locationUrl,
      'password': password,

      /// 👇 هنا كمان
      'imageUrl': imageUrl,
      'state': state,
    };
  }
}
