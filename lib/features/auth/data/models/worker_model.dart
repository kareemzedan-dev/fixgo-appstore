class WorkerModel {
  final String id;
  final String name;
  final String phone;

  /// الأساسية
  final String profession;
  final String serviceCategory;
  final String yearsOfExperience;
  final String type;

  /// اختيارية لاحقًا
  final String email;
  final String imageUrl;

  final bool isVerified;
  final String verificationStatus;
  final String verificationImage;

  final DateTime? createdAt;

  WorkerModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.profession,
    required this.serviceCategory,
    required this.yearsOfExperience,
    required this.type,

    this.email = "",
    this.imageUrl = "",

    this.isVerified = false,
    this.verificationStatus = "none",
    this.verificationImage = "",

    this.createdAt,
  });

  factory WorkerModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return WorkerModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',

      profession: map['profession'] ?? '',
      serviceCategory: map['serviceCategory'] ?? '',
      yearsOfExperience: map['yearsOfExperience'] ?? '',
      type: map['type'] ?? 'worker',

      email: map['email'] ?? '',
      imageUrl: map['imageUrl'] ?? '',

      isVerified: map['isVerified'] ?? false,
      verificationStatus:
      map['verificationStatus'] ?? "none",
      verificationImage:
      map['verificationImage'] ?? "",

      createdAt:
      map['createdAt']?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,

      'profession': profession,
      'serviceCategory': serviceCategory,
      'yearsOfExperience': yearsOfExperience,
      'type': type,

      'email': email,
      'imageUrl': imageUrl,

      'isVerified': isVerified,
      'verificationStatus': verificationStatus,
      'verificationImage': verificationImage,

      'createdAt': createdAt,
    };
  }
}