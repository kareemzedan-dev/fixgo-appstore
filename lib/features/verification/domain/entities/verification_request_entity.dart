class VerificationRequestEntity {
  final String? id;
  final String userId;
  final String? frontImageUrl;
  final String? backImageUrl;
  final String status;

  const VerificationRequestEntity({
    this.id,
    required this.userId,
    this.frontImageUrl,
    this.backImageUrl,
    required this.status,
  });

  bool get isPending => status == 'pending';
  bool get isApproved => status == 'approved';
  bool get isRejected => status == 'rejected';
  bool get isNotVerified => status == 'not_verified';
}
