library;

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.id,
    required super.offerId,
    required super.userId,

    /// الجديد
    required super.userName,

    required super.content,
    required super.createdAt,
    super.rating,
    super.parentId,
  });

  factory ReviewModel.fromMap(
    Map<String, dynamic> map,
    String docId,
  ) {
    return ReviewModel(
      id: docId,

      offerId:
          map['offerId'] ?? '',

      userId:
          map['userId'] ?? '',

      /// الجديد
      userName:
          map['userName'] ??
              "مستخدم",

      content:
          map['content'] ?? '',

      rating:
          map['rating'] != null
              ? (map['rating'] as num)
                  .toDouble()
              : null,

      parentId:
          map['parentId'],

      createdAt:
          map['createdAt'] != null
              ? (map['createdAt']
                      as Timestamp)
                  .toDate()
              : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'offerId': offerId,

      'userId': userId,

      /// الجديد
      'userName': userName,

      'content': content,

      'rating': rating,

      'parentId': parentId,

      'createdAt':
          Timestamp.fromDate(
        createdAt,
      ),
    };
  }
}