import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ViewSponsorshipService {
  final _firestore =
      FirebaseFirestore.instance;

  /// ===============================
  /// ACTIVATE
  /// ===============================

  Future<void> activate({
    required String offerId,
    required int views,
  }) async {
    debugPrint(
      "🚀 ACTIVATE START: $offerId",
    );

    await _firestore
        .collection('offers')
        .doc(offerId)
        .update({
      'isViewSponsored': true,
      'totalViews': views,
      'remainingViews': views,
      'lastViewAt': null,
    });

    debugPrint(
      "✅ ACTIVATE DONE: views=$views",
    );
  }

  /// ===============================
  /// DEACTIVATE
  /// ===============================

  Future<void> deactivate(
    String offerId,
  ) async {
    debugPrint(
      "🚀 DEACTIVATE START: $offerId",
    );

    await _firestore
        .collection('offers')
        .doc(offerId)
        .update({
      'isViewSponsored': false,
      'remainingViews': 0,
    });

    debugPrint(
      "✅ DEACTIVATE DONE",
    );
  }

  /// ===============================
  /// COUNT VIEW
  /// ===============================

  Future<void> countView({
    required String offerId,
    required String offerOwnerId,
    String? userId,
    int userDailyLimit = 10,
  }) async {
    final offerRef =
        _firestore
            .collection('offers')
            .doc(offerId);

    debugPrint(
      "==============================",
    );
    debugPrint(
      "🚀 countView START",
    );
    debugPrint(
      "offerId: $offerId",
    );
    debugPrint(
      "offerOwnerId: $offerOwnerId",
    );
    debugPrint(
      "currentUserId: $userId",
    );

    await _firestore.runTransaction(
      (tx) async {
        final offerSnap =
            await tx.get(offerRef);

        if (!offerSnap.exists) {
          debugPrint(
            "❌ Offer does not exist",
          );
          return;
        }

        final data =
            offerSnap.data()!;

        final bool sponsored =
            data['isViewSponsored'] ==
                true;

        final int remaining =
            data['remainingViews'] ??
                0;

        final bool sp =
            data['SP'] ?? false;

        debugPrint(
          "📦 Sponsored Data",
        );
        debugPrint(
          "isViewSponsored: $sponsored",
        );
        debugPrint(
          "SP: $sp",
        );
        debugPrint(
          "remainingViews: $remaining",
        );

        /// ❌ غير ممول
        if (!sponsored) {
          debugPrint(
            "❌ Not View Sponsored -> STOP",
          );
          return;
        }

        /// ❌ انتهت المشاهدات
        if (remaining <= 0) {
          debugPrint(
            "❌ remainingViews <= 0 -> STOP",
          );
          return;
        }

        /// ❌ صاحب الإعلان نفسه
        if (userId != null &&
            userId ==
                offerOwnerId) {
          debugPrint(
            "❌ Owner opened own offer -> STOP",
          );
          return;
        }

        /// ===============================
        /// USER DAILY LIMIT
        /// ===============================

        if (userId != null) {
          final todayKey =
              _todayKey();

          final userDayRef =
              offerRef
                  .collection(
                    'views',
                  )
                  .doc(userId)
                  .collection(
                    'days',
                  )
                  .doc(todayKey);

          final userDaySnap =
              await tx.get(
            userDayRef,
          );

          final int todayCount =
              userDaySnap.exists
                  ? (userDaySnap
                              .data()![
                          'count'] ??
                      0)
                  : 0;

          debugPrint(
            "📅 todayKey: $todayKey",
          );
          debugPrint(
            "👤 todayCount: $todayCount",
          );
          debugPrint(
            "🎯 dailyLimit: $userDailyLimit",
          );

          /// 🚫 الحد اليومي
          if (todayCount >=
              userDailyLimit) {
            debugPrint(
              "🚫 User daily limit reached -> STOP",
            );
            return;
          }

          /// ⬆️ زيادة عداد المستخدم
          tx.set(
            userDayRef,
            {
              'count':
                  todayCount + 1,
              'updatedAt':
                  FieldValue
                      .serverTimestamp(),
            },
            SetOptions(
              merge: true,
            ),
          );

          debugPrint(
            "✅ User daily count updated",
          );
        }

        /// ===============================
        /// خصم المشاهدة
        /// ===============================

        final int newRemaining =
            remaining - 1;

        tx.update(
          offerRef,
          {
            'remainingViews':
                newRemaining,
            'viewsCount':
                FieldValue.increment(
              1,
            ),
            'isViewSponsored':
                newRemaining > 0,
            'lastViewAt':
                FieldValue
                    .serverTimestamp(),
          },
        );

        debugPrint(
          "🔥 VIEW COUNTED SUCCESS",
        );
        debugPrint(
          "remaining old: $remaining",
        );
        debugPrint(
          "remaining new: $newRemaining",
        );
        debugPrint(
          "isViewSponsored after update: ${newRemaining > 0}",
        );
      },
    );

    debugPrint(
      "✅ countView END",
    );
    debugPrint(
      "==============================",
    );
  }

  /// ===============================
  /// TODAY KEY
  /// ===============================

  String _todayKey() {
    final now = DateTime.now();

    return '${now.year}-${now.month}-${now.day}';
  }

  /// ===============================
  /// DECREMENT IF NEEDED
  /// ===============================

  Future<void> decrementIfNeeded({
    required String offerId,
    required String offerOwnerId,
    required String currentUserId,
  }) async {
    debugPrint(
      "🚀 decrementIfNeeded START",
    );

    if (offerOwnerId ==
        currentUserId) {
      debugPrint(
        "❌ Owner opened own offer -> STOP",
      );
      return;
    }

    final docRef =
        _firestore
            .collection('offers')
            .doc(offerId);

    await _firestore.runTransaction(
      (tx) async {
        final snap =
            await tx.get(docRef);

        if (!snap.exists) {
          debugPrint(
            "❌ Offer not found",
          );
          return;
        }

        final data =
            snap.data()!;

        final bool sponsored =
            data['isViewSponsored'] ??
                false;

        final int remaining =
            data['remainingViews'] ??
                0;

        debugPrint(
          "isViewSponsored: $sponsored",
        );
        debugPrint(
          "remainingViews: $remaining",
        );

        if (!sponsored ||
            remaining <= 0) {
          debugPrint(
            "❌ Not valid sponsored -> STOP",
          );
          return;
        }

        final newRemaining =
            remaining - 1;

        tx.update(
          docRef,
          {
            'remainingViews':
                newRemaining,
            'isViewSponsored':
                newRemaining > 0,
            'lastViewAt':
                FieldValue
                    .serverTimestamp(),
          },
        );

        debugPrint(
          "🔥 decrement success",
        );
        debugPrint(
          "newRemaining: $newRemaining",
        );
      },
    );

    debugPrint(
      "✅ decrementIfNeeded END",
    );
  }
}