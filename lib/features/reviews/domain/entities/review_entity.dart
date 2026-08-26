library;

class ReviewEntity {
  final String id;
  final String offerId;
  final String userId;

  /// اسم المستخدم الحقيقي
  final String userName;

  final String content;

  /// null لو Reply
  final double? rating;

  /// null لو Comment أساسي
  final String? parentId;

  final DateTime createdAt;

  const ReviewEntity({
    required this.id,
    required this.offerId,
    required this.userId,
    required this.userName,
    required this.content,
    required this.createdAt,
    this.rating,
    this.parentId,
  });

  bool get isReply => parentId != null;
}