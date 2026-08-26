library;

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/core/services/firebase_services/firebase_storage_service.dart';

import '../data_sources/stories_remote_data_source.dart';
import '../models/story_model.dart';

@LazySingleton(as: StoriesRemoteDataSource)
class StoriesRemoteDataSourceImpl implements StoriesRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final FirebaseStorageService storageService;

  StoriesRemoteDataSourceImpl({
    required this.firestore,
    required this.auth,
    required this.storageService,
  });

  /// ===============================
  /// GET STORIES
  /// ===============================

  @override
  Future<List<StoryModel>> getStories() async {
    try {
      final currentUser = auth.currentUser;

      if (currentUser == null) return [];

      /// هات المستخدم الحالي
      final userDoc = await firestore
          .collection("users")
          .doc(currentUser.uid)
          .get();

      final userData = userDoc.data() ?? {};
      final List following = List.from(userData["following"] ?? []);

      // أضف المستخدم الحالي لو مش موجود
      if (!following.contains(currentUser.uid)) {
        following.add(currentUser.uid);
      }
      final snapshot = await firestore
          .collection("stories")
          .where("expiresAt", isGreaterThan: Timestamp.now())
          .where("userId", whereIn: following)
          .orderBy("createdAt", descending: true)
          .get();

      final stories = snapshot.docs
          .map((doc) => StoryModel.fromMap(doc.data(), doc.id))
          .toList();

      return stories;
    } catch (e) {
      log("getStories Error => ${e.toString()}");

      return [];
    }
  }

  /// ===============================
  /// ADD STORY
  /// ===============================

  @override
  Future<void> addStory({required String text, String? storyImage}) async {
    try {
      final currentUser = auth.currentUser;

      if (currentUser == null) {
        throw Exception("User not logged in");
      }

      final userDoc = await firestore
          .collection("users")
          .doc(currentUser.uid)
          .get();

      final userData = userDoc.data() ?? {};

      await firestore.collection("stories").add({
        "userId": currentUser.uid,
        "userName": userData["name"] ?? "بدون اسم",
        "image": storyImage,
        "text": text,
        "viewsCount": 0,
        "viewedBy": [],
        "createdAt": FieldValue.serverTimestamp(),
        "expiresAt": Timestamp.fromDate(
          DateTime.now().add(const Duration(hours: 24)),
        ),
      });

      log("Story Added Successfully");
    } catch (e) {
      log("addStory Error => ${e.toString()}");

      rethrow;
    }
  }

  /// ===============================
  /// DELETE STORY
  /// ===============================

  @override
  Future<void> deleteStory(String storyId) async {
    try {
      await firestore.collection("stories").doc(storyId).delete();

      log("Story Deleted Successfully");
    } catch (e) {
      log("deleteStory Error => ${e.toString()}");

      rethrow;
    }
  }

  /// ===============================
  /// INCREMENT VIEW
  /// ===============================

  @override
  Future<void> incrementView({
    required String storyId,
    required String viewerId,
  }) async {
    try {
      final docRef = firestore.collection("stories").doc(storyId);

      await firestore.runTransaction((transaction) async {
        final snap = await transaction.get(docRef);

        if (!snap.exists) return;

        final data = snap.data()!;

        final List viewedBy = data["viewedBy"] ?? [];

        /// check already viewed
        final alreadyViewed = viewedBy.any(
          (viewer) => viewer["userId"] == viewerId,
        );

        if (alreadyViewed) {
          return;
        }

        /// get viewer name
        final userDoc = await firestore.collection("users").doc(viewerId).get();

        final userName = userDoc.data()?["name"] ?? "مستخدم";

        transaction.update(docRef, {
          "viewsCount": FieldValue.increment(1),

          "viewedBy": FieldValue.arrayUnion([
            {"userId": viewerId, "userName": userName},
          ]),
        });
      });

      log("Story View Counted");
    } catch (e) {
      log("incrementView Error => ${e.toString()}");

      rethrow;
    }
  }

  @override
  Future<bool> hasViewedStory({
    required String storyId,
    required String viewerId,
  }) async {
    try {
      final doc = await firestore.collection("stories").doc(storyId).get();

      if (!doc.exists) {
        return false;
      }

      final data = doc.data()!;

      final List viewedBy = data["viewedBy"] ?? [];

      return viewedBy.any((viewer) => viewer["userId"] == viewerId);
    } catch (e) {
      log("hasViewedStory Error => ${e.toString()}");

      return false;
    }
  }

  @override
  Future<String> uploadStoryImage({
    required XFile image,
    required String folderName,
  }) {
    return storageService.uploadSingleImage(
      image: image,
      folderName: folderName,
    );
  }
}
