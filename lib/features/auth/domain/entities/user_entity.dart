/// domain/entities/user_entity.dart
library;

class UserEntity {
  final String uid;
  final String phone;
  final String name;
  final String type;
  final String password;

  /// user only -> ""
  /// worker -> profession name
  final String profession;

  /// worker only
  final String serviceCategory;

  /// worker only
  final int yearsOfExperience;

  final double? latitude;
  final double? longitude;

  final String? city;
  final String? district;
  final String? locationUrl;

  /// 🔥 الجديد
  final String? imageUrl;
  final String state;

  UserEntity({
    required this.uid,
    required this.phone,
    required this.name,
    required this.type,
    required this.profession,
    this.serviceCategory = '',
    this.yearsOfExperience = 0,
    this.latitude,
    this.longitude,
    this.city,
    this.district,
    this.locationUrl,
    required this.password,

    /// 👇 هنا
    this.imageUrl,
    required this.state,
  });
}
