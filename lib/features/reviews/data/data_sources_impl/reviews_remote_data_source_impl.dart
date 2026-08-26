library;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../data_sources/reviews_remote_data_source.dart';
import '../models/review_model.dart';

@LazySingleton(as: ReviewsRemoteDataSource)
class ReviewsRemoteDataSourceImpl implements ReviewsRemoteDataSource {
  final FirebaseFirestore firestore;

  ReviewsRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> createReviewNotification({
    required String offerOwnerId,
    required String offerId,
    required String reviewerId,
    required String reviewerName,
  }) {
    return firestore
        .collection("notifications")
        .doc(offerOwnerId)
        .collection("items")
        .add({
          "title": "تم تقييم خدمتك ⭐",
          "body": "$reviewerName قام بتقييم خدمتك",
          "type": "rating",
          "offerId": offerId,
          "otherUserId": reviewerId,
          "isRead": false,
          "createdAt": FieldValue.serverTimestamp(),
        });
  }

  /// =====================================
  /// FETCH REVIEWS
  /// =====================================

  @override
  Future<List<ReviewModel>> fetchReviews(String offerId) async {
    final snapshot = await firestore
        .collection("offers")
        .doc(offerId)
        .collection("comments")
        .orderBy("createdAt", descending: false)
        .get();

    final reviews = snapshot.docs
        .map((doc) => ReviewModel.fromMap(doc.data(), doc.id))
        .toList();

    return reviews;
  }

  /// =====================================
  /// ADD REVIEW
  /// =====================================

  @override
  Future<void> addReview({
    required String offerId,
    required ReviewModel review,
  }) async {
    final offerRef = firestore.collection("offers").doc(offerId);

    final reviewRef = offerRef.collection("comments").doc(review.id);

    await firestore.runTransaction((tx) async {
      final offerSnap = await tx.get(offerRef);

      if (!offerSnap.exists) return;

      final data = offerSnap.data()!;

      int ratingsCount = data["ratingsCount"] ?? 0;

      double totalRating = (data["totalRating"] ?? 0).toDouble();

      /// rating only if root comment
      if (review.rating != null && review.parentId == null) {
        ratingsCount += 1;
        totalRating += review.rating!;

        tx.update(offerRef, {
          "ratingsCount": ratingsCount,
          "totalRating": totalRating,
          "averageRating": totalRating / ratingsCount,
        });
      }

      tx.set(reviewRef, review.toMap());
    });
  }

  @override
  Future<void> updateReview({
    required String offerId,
    required ReviewModel review,
  }) async {
    final reviewRef = firestore
        .collection("offers")
        .doc(offerId)
        .collection("comments")
        .doc(review.id);

    await reviewRef.update({
      "content": review.content,
      "rating": review.rating,
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<ReviewModel?> getUserReview({
    required String offerId,
    required String userId,
  }) async {
    final snapshot = await firestore
        .collection("offers")
        .doc(offerId)
        .collection("comments")
        .where("userId", isEqualTo: userId)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    final doc = snapshot.docs.first;

    return ReviewModel.fromMap(doc.data(), doc.id);
  }

  /// =====================================
  /// DELETE REVIEW
  /// =====================================

  @override
  Future<void> deleteReview({
    required String offerId,
    required ReviewModel review,
  }) async {
    final offerRef = firestore.collection("offers").doc(offerId);

    final reviewRef = offerRef.collection("comments").doc(review.id);

    await firestore.runTransaction((tx) async {
      final offerSnap = await tx.get(offerRef);

      if (!offerSnap.exists) return;

      final data = offerSnap.data()!;

      int ratingsCount = data["ratingsCount"] ?? 0;

      double totalRating = (data["totalRating"] ?? 0).toDouble();

      if (review.rating != null && review.parentId == null) {
        ratingsCount -= 1;
        totalRating -= review.rating!;

        if (ratingsCount < 0) {
          ratingsCount = 0;
        }

        if (totalRating < 0) {
          totalRating = 0;
        }

        tx.update(offerRef, {
          "ratingsCount": ratingsCount,
          "totalRating": totalRating,
          "averageRating": ratingsCount == 0 ? 0 : totalRating / ratingsCount,
        });
      }

      tx.delete(reviewRef);
    });
  }
}
