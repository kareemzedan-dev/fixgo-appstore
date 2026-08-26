/// ===============================
/// data/models/story_model.dart
/// النسخة الصحيحة النهائية
/// دعم:
/// - Firestore Timestamp
/// - story image
/// - user image
/// - viewedBy (name + id)
/// ===============================

library;

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/story_entity.dart';

class StoryModel
    extends StoryEntity {
  const StoryModel({
    required super.storyId,
    required super.userId,
    required super.name,

    /// صورة العامل
    super.userImage,

    /// صورة الحالة
    super.storyImage,

    required super.text,
    required super.viewsCount,

    /// المشاهدات
    super.viewedBy,

    required super.createdAt,
    required super.expiresAt,

    super.isExpired,
  });

  /// ===============================
  /// FROM MAP
  /// ===============================

  factory StoryModel.fromMap(
    Map<String, dynamic> map,
    String docId,
  ) {
    final DateTime createdAt =
        map['createdAt'] != null
            ? (map['createdAt']
                    as Timestamp)
                .toDate()
            : DateTime.now();

    final DateTime expiresAt =
        map['expiresAt'] != null
            ? (map['expiresAt']
                    as Timestamp)
                .toDate()
            : DateTime.now().add(
                const Duration(
                  hours: 24,
                ),
              );

    return StoryModel(
      storyId: docId,

      /// صاحب الحالة
      userId:
          map['userId'] ?? '',

      /// اسم العامل
      name:
          map['userName'] ??
              'بدون اسم',

      /// صورة العامل الأساسية
      userImage:
          map['userImage'],

      /// صورة الحالة
      /// محفوظة في Firebase باسم image
      storyImage:
          map['image'],

      /// النص
      text:
          map['text'] ?? '',

      /// عدد المشاهدات
      viewsCount:
          map['viewsCount'] ?? 0,

      /// المشاهدات
      viewedBy:
          List<Map<String, dynamic>>.from(
        map['viewedBy'] ?? [],
      ),

      /// التواريخ
      createdAt:
          createdAt,
      expiresAt:
          expiresAt,

      /// انتهاء
      isExpired:
          map['isExpired'] ??
              false,
    );
  }

  /// ===============================
  /// TO MAP
  /// ===============================

  Map<String, dynamic>
      toMap() {
    return {
      /// صاحب الحالة
      'userId': userId,

      /// الاسم
      'userName': name,

      /// صورة العامل
      'userImage':
          userImage,

      /// صورة الحالة
      'image':
          storyImage,

      /// النص
      'text': text,

      /// المشاهدات
      'viewsCount':
          viewsCount,

      /// viewedBy
      'viewedBy':
          viewedBy,

      /// التواريخ
      'createdAt':
          Timestamp.fromDate(
        createdAt,
      ),

      'expiresAt':
          Timestamp.fromDate(
        expiresAt,
      ),

      /// انتهاء
      'isExpired':
          isExpired,
    };
  }

  /// ===============================
  /// COPY WITH
  /// ===============================

  StoryModel copyWith({
    String? storyId,
    String? userId,
    String? name,

    String? userImage,
    String? storyImage,

    String? text,

    int? viewsCount,

    List<
            Map<String,
                dynamic>>?
        viewedBy,

    DateTime? createdAt,
    DateTime? expiresAt,

    bool? isExpired,
  }) {
    return StoryModel(
      storyId:
          storyId ??
              this.storyId,

      userId:
          userId ??
              this.userId,

      name:
          name ??
              this.name,

      userImage:
          userImage ??
              this.userImage,

      storyImage:
          storyImage ??
              this.storyImage,

      text:
          text ??
              this.text,

      viewsCount:
          viewsCount ??
              this.viewsCount,

      viewedBy:
          viewedBy ??
              this.viewedBy,

      createdAt:
          createdAt ??
              this.createdAt,

      expiresAt:
          expiresAt ??
              this.expiresAt,

      isExpired:
          isExpired ??
              this.isExpired,
    );
  }
}