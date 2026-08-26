import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../data_sources/favorite_remote_data_source.dart';
import '../models/favorite_offer_model.dart';

@Injectable(as: FavoriteRemoteDataSource)
class FavoriteRemoteDataSourceImpl
    implements FavoriteRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  FavoriteRemoteDataSourceImpl(
    this.firestore,
    this.auth,
  );

  /// =========================
  /// GET FAVORITE OFFERS
  /// =========================

  @override
  Future<List<FavoriteOfferModel>>
      getFavoriteOffers() async {
    final user = auth.currentUser;

    if (user == null) return [];

    final userDoc = await firestore
        .collection("users")
        .doc(user.uid)
        .get();

    List<dynamic> favoriteIds = [];

    if (userDoc.exists &&
        userDoc.data()!
            .containsKey("favorites")) {
      favoriteIds =
          userDoc["favorites"] ?? [];
    }

    if (favoriteIds.isEmpty) {
      return [];
    }

    final offersSnapshot =
        await firestore
            .collection("offers")
            .where(
              FieldPath.documentId,
              whereIn: favoriteIds,
            )
            .get();

    return offersSnapshot.docs
        .map(
          (doc) =>
              FavoriteOfferModel.fromMap(
            doc.data(),
            doc.id,
          ),
        )
        .toList();
  }

  /// =========================
  /// TOGGLE FAVORITE
  /// =========================

  @override
  Future<void> toggleFavorite(
    String offerId,
  ) async {
    final user = auth.currentUser;

    if (user == null) return;

    final userRef = firestore
        .collection("users")
        .doc(user.uid);

    final userDoc =
        await userRef.get();

    List<dynamic> favorites = [];

    if (userDoc.exists &&
        userDoc.data()!
            .containsKey("favorites")) {
      favorites =
          userDoc["favorites"] ?? [];
    }

    /// لو موجود → احذفه
    if (favorites.contains(offerId)) {
      favorites.remove(offerId);
    }

    /// لو مش موجود → ضيفه
    else {
      favorites.add(offerId);
    }

    await userRef.set(
      {
        "favorites": favorites,
      },
      SetOptions(
        merge: true,
      ),
    );
  }

  /// =========================
  /// GET FAVORITE IDS
  /// =========================

  @override
  Future<List<String>>
      getUserFavorites() async {
    final user = auth.currentUser;

    if (user == null) return [];

    final userDoc = await firestore
        .collection("users")
        .doc(user.uid)
        .get();

    if (!userDoc.exists) {
      return [];
    }

    final data = userDoc.data();

    if (data == null ||
        !data.containsKey("favorites")) {
      return [];
    }

    return List<String>.from(
      data["favorites"] ?? [],
    );
  }
}