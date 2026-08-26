import 'package:fixgo/features/verification/domain/entities/verification_request_entity.dart';

class VerificationRequestModel {
  final String? id;
  final String userId;
  final String? frontImage;
  final String? backImage;
  final String status;

  const VerificationRequestModel({
    this.id,
    required this.userId,
    this.frontImage,
    this.backImage,
    required this.status,
  });

  factory VerificationRequestModel.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    return VerificationRequestModel(
      id: id,
      userId: map['userId'] as String? ?? '',
      frontImage: map['frontImage'] as String?,
      backImage: map['backImage'] as String?,
      status: map['status'] as String? ?? 'pending',
    );
  }

  VerificationRequestEntity toEntity() {
    return VerificationRequestEntity(
      id: id,
      userId: userId,
      frontImageUrl: frontImage,
      backImageUrl: backImage,
      status: status,
    );
  }
}
