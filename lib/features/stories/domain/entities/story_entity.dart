/// ===============================
/// domain/entities/story_entity.dart
/// النسخة الكاملة الاحترافية
/// ===============================

library;

class StoryEntity {
  final String storyId;
  final String userId;

  /// اسم العامل
  final String name;

  /// صورة العامل الأساسية
  final String? userImage;

  /// صورة الحالة نفسها (اختياري)
  final String? storyImage;

  /// نص الحالة
  final String text;

  /// عدد المشاهدات
  final int viewsCount;

  /// من شاهد الحالة
  final List<Map<String, dynamic>> viewedBy;

  /// وقت الإنشاء
  final DateTime createdAt;

  /// انتهاء بعد 24 ساعة
  final DateTime expiresAt;

  /// هل منتهية
  final bool isExpired;

  const StoryEntity({
    required this.storyId,
    required this.userId,
    required this.name,

    this.userImage,
    this.storyImage,

    required this.text,
    required this.viewsCount,
    this.viewedBy = const [],

    required this.createdAt,
    required this.expiresAt,

    this.isExpired = false,
  });
  StoryEntity copyWith({
  String? storyId,
  String? userId,
  String? name,
  String? userImage,
  String? storyImage,
  String? text,
  int? viewsCount,
  List<Map<String, dynamic>>? viewedBy,
  DateTime? createdAt,
  DateTime? expiresAt,
  bool? isExpired,
}) {
  return StoryEntity(
    storyId: storyId ?? this.storyId,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    userImage: userImage ?? this.userImage,
    storyImage: storyImage ?? this.storyImage,
    text: text ?? this.text,
    viewsCount: viewsCount ?? this.viewsCount,
    viewedBy: viewedBy ?? this.viewedBy,
    createdAt: createdAt ?? this.createdAt,
    expiresAt: expiresAt ?? this.expiresAt,
    isExpired: isExpired ?? this.isExpired,
  );
}
}