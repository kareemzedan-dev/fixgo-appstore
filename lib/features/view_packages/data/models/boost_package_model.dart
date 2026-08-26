import 'package:fixgo/features/view_packages/domain/entities/boost_package_entity.dart';

class BoostPackageModel extends BoostPackageEntity {
  const BoostPackageModel({
    required super.id,
    required super.title,
    required super.views,
    required super.price,
    required super.duration,
    required super.description,
    required super.bankAccount,
    required super.isActive,
  });

  /// 🔹 Firestore → Model
  factory BoostPackageModel.fromJson(Map<String, dynamic> json) {
    return BoostPackageModel(
      id: json['id'], // بيجي من doc.id
      title: json['title'],
      views: json['views'],
      price: json['price'],
      duration: json['duration'],
      description: json['description'],
      bankAccount: json['bank_account'],
      isActive: json['is_active'],
    );
  }

  /// 🔹 Model → Firestore
  /// ❌ بدون id
  Map<String, dynamic> toJsonWithoutId() {
    return {
      'title': title,
      'views': views,
      'price': price,
      'duration': duration,
      'description': description,
      'bank_account': bankAccount,
      'is_active': isActive,
    };
  }

  /// 🔹 helper
  BoostPackageModel copyWith({
    String? id,
    String? title,
    int? views,
    String? price,
    String? duration,
    String? description,
    String? bankAccount,
    bool? isActive,
  }) {
    return BoostPackageModel(
      id: id ?? this.id,
      title: title ?? this.title,
      views: views ?? this.views,
      price: price ?? this.price,
      duration: duration ?? this.duration,
      description: description ?? this.description,
      bankAccount: bankAccount ?? this.bankAccount,
      isActive: isActive ?? this.isActive,
    );
  }
}
