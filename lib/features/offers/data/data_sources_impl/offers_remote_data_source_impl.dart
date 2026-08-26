import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/core/helper/search_helper.dart';
import 'package:fixgo/core/services/firebase_services/firebase_storage_service.dart';
import 'package:fixgo/core/services/firebase_services/view_sponsorship_service.dart';
import 'package:fixgo/core/session/session_local_data_source.dart';
import 'package:fixgo/features/auth/data/models/user_model.dart';
import 'package:fixgo/features/offers/data/models/add_service_model.dart';
import 'package:fixgo/features/offers/domain/entities/boost_offer_status_entity.dart';
import 'package:image_picker/image_picker.dart';

import '../data_sources/offers_remote_data_source.dart';
import '../models/offer_model.dart';

@LazySingleton(as: OffersRemoteDataSource)
class OffersRemoteDataSourceImpl implements OffersRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final SessionLocalDataSource sessionLocalDataSource;
  final ViewSponsorshipService viewSponsorshipService;
  final FirebaseStorageService storageService;

  OffersRemoteDataSourceImpl(
    this.firestore,
    this.auth,
    this.sessionLocalDataSource,
    this.viewSponsorshipService,
    this.storageService,
  );

  @override
  Future<List<OfferModel>> getOffers() async {
    final result = await firestore.collection("offers").get();

    return result.docs.map((e) => OfferModel.fromFirestore(e)).toList();
  }

  @override
  Future<List<OfferModel>> getRecommendedOffers() async {
    final offers = await getOffers();

    /// ترتيب حسب الأعلى تقييم
    offers.sort((a, b) => b.averageRating.compareTo(a.averageRating));

    /// أول 10 فقط
    return offers.take(10).toList();
  }

  @override
  Future<List<OfferModel>> getNearbyOffers() async {
    final offers = await getOffers();

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return offers;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return offers;
    }

    final position = await Geolocator.getCurrentPosition();

    List<OfferModel> nearby = [];

    for (final offer in offers) {
      final distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        offer.latitude,
        offer.longitude,
      );

      if (distance <= 50000) {
        nearby.add(offer.copyWith(distance: distance));
      }
    }

    nearby.sort((a, b) => a.distance.compareTo(b.distance));

    return nearby;
  }

  @override
  Future<List<OfferModel>> getMyServices() async {
    final user = auth.currentUser;

    if (user == null) return [];

    final result = await firestore
        .collection("offers")
        .where("userId", isEqualTo: user.uid)
        .get();

    return result.docs.map((e) => OfferModel.fromFirestore(e)).toList();
  }

  /// =========================
  /// FAVORITE LOGIC
  /// =========================

  @override
  Future<void> toggleFavorite(String offerId) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final userRef = firestore.collection("users").doc(user.uid);

    final userDoc = await userRef.get();

    List<dynamic> favorites = [];

    if (userDoc.exists && userDoc.data()!.containsKey("favorites")) {
      favorites = userDoc["favorites"] ?? [];
    }

    /// لو موجود → احذفه
    if (favorites.contains(offerId)) {
      favorites.remove(offerId);
    }
    /// لو مش موجود → ضيفه
    else {
      favorites.add(offerId);
    }

    await userRef.set({"favorites": favorites}, SetOptions(merge: true));
  }

  Future<List<String>> getUserFavorites() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return [];

    final userDoc = await firestore.collection("users").doc(user.uid).get();

    if (!userDoc.exists) {
      return [];
    }

    final data = userDoc.data();

    if (data == null || !data.containsKey("favorites")) {
      return [];
    }

    return List<String>.from(data["favorites"] ?? []);
  }
  // ===============================
  // data/data_sources/offers_remote_data_source_impl.dart
  // ADD THIS ONLY
  // ===============================

  @override
  Future<OfferModel> getOfferDetails(String offerId) async {
    final doc = await firestore.collection("offers").doc(offerId).get();

    if (!doc.exists) {
      throw Exception("الخدمة غير موجودة");
    }

    return OfferModel.fromFirestore(doc);
  }

  @override
  Stream<BoostOfferStatusEntity> watchBoostOfferStatus(String offerId) {
    return firestore.collection("offers").doc(offerId).snapshots().map((doc) {
      final data = doc.data() ?? const <String, dynamic>{};
      return BoostOfferStatusEntity(
        isViewSponsored: data["isViewSponsored"] ?? false,
        remainingViews: data["remainingViews"] ?? 0,
        totalViews: data["totalViews"] ?? 0,
        viewsExpireAt: (data["viewsExpireAt"] as Timestamp?)?.toDate(),
      );
    });
  }

  /// التعديل المطلوب داخل addService()
  /// لإضافة yearsOfExperience إلى Firestore

  @override
  Future<void> addService({required AddServiceModel service}) async {
    try {
      final user = await sessionLocalDataSource.getUser();

      if (user == null) {
        throw Exception("المستخدم غير مسجل الدخول");
      }

      final userDoc = await firestore.collection("users").doc(user.uid).get();
      final userData = userDoc.data();

      if (userData == null) {
        throw Exception("بيانات المستخدم غير موجودة");
      }
      await firestore.collection("offers").add({
        "userId": user.uid,

        "userName": userData["name"] ?? "",

        "userImageUrl": userData["imageUrl"] ?? "",
        "phone": userData["phone"] ?? "",

        "profession": userData["profession"] ?? "",

        "title": service.title,

        "location": service.city,

        "neighborhood": service.neighborhood,

        "category": service.category,

        "serviceCategory": service.serviceCategory,

        "description": service.description,

        /// الجديد المهم جدًا
        "yearsOfExperience": service.yearsOfExperience,

        "imageUrl": service.images.isNotEmpty ? service.images.first : "",

        "images": service.images,

        "latitude": service.latitude,

        "longitude": service.longitude,

        "averageRating": 0.0,

        "ratingsCount": 0,

        "isSponsored": false,

        "createdAt": FieldValue.serverTimestamp(),
      });

      log("Service Added Successfully");
    } catch (e) {
      log("addService Error => ${e.toString()}");

      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateOffer({
    required String offerId,
    required String title,
    required String description,
    required String category,
    required String serviceCategory,
    required int yearsOfExperience,
    required String imageUrl,
    required List<String> images,
    required String location,
  }) async {
    try {
      await firestore.collection("offers").doc(offerId).update({
        /// ✅ صح
        "title": title,

        "description": description,

        "category": category,

        "serviceCategory": serviceCategory,

        "yearsOfExperience": yearsOfExperience,

        "imageUrl": imageUrl,

        /// 🔥 الجديد
        "images": images,

        "location": location,

        "updatedAt": FieldValue.serverTimestamp(),
      });

      log("Offer Updated Successfully");
    } catch (e) {
      log("updateOffer Error => ${e.toString()}");

      throw Exception("فشل تعديل الخدمة");
    }
  }

  @override
  Future<List<OfferModel>> getOffersByCategory(String category) async {
    final result = await firestore
        .collection("offers")
        .where("serviceCategory", isEqualTo: category)
        .get();

    return result.docs.map((e) => OfferModel.fromFirestore(e)).toList();
  }

  @override
  Future<List<OfferModel>> searchOffers(String query) async {
    final result = await firestore.collection("offers").get();

    List<OfferModel> allOffers = result.docs
        .map((e) => OfferModel.fromFirestore(e))
        .toList();

    allOffers = allOffers.where((offer) {
      final offerText = SearchHelper.normalizeArabic(
        "${offer.title} "
        "${offer.profession} "
        "${offer.serviceCategory} "
        "${offer.description} "
        "${offer.location}",
      );

      log("================================");

      log("🔍 QUERY => $query");

      log("📌 OFFER TITLE => ${offer.title}");

      log("📌 OFFER LOCATION => ${offer.location}");

      log("📌 OFFER PROFESSION => ${offer.profession}");

      log("📌 OFFER TEXT => $offerText");

      log(
        "📌 SMART SEARCH => "
        "${SearchHelper.smartSearch(query, offerText)}",
      );

      /// البحث فقط
      return SearchHelper.smartSearch(query, offerText);
    }).toList();

    /// =========================
    /// الإعلانات أولاً
    /// =========================

    final sponsored = allOffers.where((e) => e.isSponsored == true).toList();

    final normal = allOffers.where((e) => e.isSponsored != true).toList();

    sponsored.shuffle();

    allOffers = [...sponsored, ...normal];

    return allOffers;
  }

  @override
  Future<List<OfferModel>> getOffersByUser(String userId) async {
    final result = await firestore
        .collection("offers")
        .where("userId", isEqualTo: userId)
        .get();

    return result.docs.map((e) => OfferModel.fromFirestore(e)).toList();
  }

  @override
  Future<List<OfferModel>> getSimilarOffers({
    required String offerId,
    required String serviceCategory,
  }) async {
    try {
      final result = await firestore
          .collection("offers")
          .where("serviceCategory", isEqualTo: serviceCategory)
          .limit(10)
          .get();

      final offers = result.docs
          .map((e) => OfferModel.fromFirestore(e))
          .where((offer) => offer.id != offerId)
          .toList();

      /// ترتيب الأفضل تقييمًا أولًا
      offers.sort((a, b) => b.averageRating.compareTo(a.averageRating));

      return offers;
    } catch (e) {
      log("getSimilarOffers Error => ${e.toString()}");

      return [];
    }
  }

  @override
  Future<void> toggleFollow(String userId) async {
    final currentUser = auth.currentUser;

    if (currentUser == null) return;

    final userRef = firestore.collection("users").doc(currentUser.uid);

    final userDoc = await userRef.get();

    List<dynamic> following = [];

    if (userDoc.exists && userDoc.data()!.containsKey("following")) {
      following = userDoc["following"] ?? [];
    }

    /// لو بيتابعه → شيله
    if (following.contains(userId)) {
      following.remove(userId);
    } else {
      /// لو مش بيتابعه → ضيفه
      following.add(userId);
    }

    await userRef.set({"following": following}, SetOptions(merge: true));
    await firestore
        .collection("notifications")
        .doc(userId)
        .collection("items")
        .add({
          "title": "تمت إضافتك إلى المفضلة ❤️",
          "body": "أحد العملاء مهتم بخدمتك",
          "type": "favorite",
          "otherUserId": currentUser.uid,
          "isRead": false,
          "createdAt": FieldValue.serverTimestamp(),
        });
  }

  @override
  Future<List<String>> getFollowingUsers() async {
    final user = auth.currentUser;

    if (user == null) return [];

    final doc = await firestore.collection("users").doc(user.uid).get();

    if (!doc.exists) return [];

    final data = doc.data();

    if (data == null || !data.containsKey("following")) {
      return [];
    }

    return List<String>.from(data["following"]);
  }

  @override
  Future<List<OfferModel>> getFollowingOffers() async {
    final followingIds = await getFollowingUsers();

    if (followingIds.isEmpty) return [];

    final result = await firestore
        .collection("offers")
        .where("userId", whereIn: followingIds)
        .get();

    return result.docs.map((e) => OfferModel.fromFirestore(e)).toList();
  }

  @override
  Future<void> countOfferView({
    required String offerId,
    String? offerOwnerId,
    String? userId,
  }) {
    return viewSponsorshipService.countView(
      offerId: offerId,
      offerOwnerId: offerOwnerId ?? '',
      userId: userId,
    );
  }

  @override
  Future<List<String>> uploadOfferImages({
    required List<XFile> images,
    required String folderName,
  }) {
    return storageService.uploadMultipleImages(
      images: images,
      folderName: folderName,
    );
  }

  @override
  Future<String> uploadOfferImage({
    required XFile image,
    required String folderName,
  }) {
    return storageService.uploadSingleImage(
      image: image,
      folderName: folderName,
    );
  }

  @override
  Future<List<UserModel>> getFollowingUsersData() async {
    final ids = await getFollowingUsers();

    if (ids.isEmpty) return [];

    final users = await Future.wait(
      ids.map((id) async {
        final data = await getUserData(id);
        return UserModel.fromMap(data);
      }),
    );

    return users;
  }

  @override
  Future<Map<String, dynamic>> getUserData(String userId) async {
    log("🟡 START getUserData");
    log("🟡 userId => $userId");

    final doc = await firestore.collection("users").doc(userId).get();

    log("🟢 DOC EXISTS => ${doc.exists}");

    if (!doc.exists) {
      log("❌ USER NOT FOUND");
      throw Exception("المستخدم غير موجود");
    }

    final data = doc.data();

    log("🟣 RAW DATA => $data");

    if (data == null) {
      log("❌ DATA NULL");
      throw Exception("بيانات المستخدم فاضية");
    }

    /// 👇 أهم سطر
    data["id"] = doc.id;

    log("🔵 FINAL DATA => $data");

    return data;
  }
}
