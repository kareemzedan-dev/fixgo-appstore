import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/core/services/firebase_services/firebase_storage_service.dart';
import 'package:fixgo/features/verification/data/data_sources/verification_remote_data_source.dart';

@LazySingleton(as: VerificationRemoteDataSource)
class VerificationRemoteDataSourceImpl implements VerificationRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final FirebaseStorageService storageService;

  VerificationRemoteDataSourceImpl({
    required this.firestore,
    required this.auth,
    required this.storageService,
  });

  static const _collection = 'verification_requests';

  String get _userId {
    final user = auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    return user.uid;
  }

  @override
  Future<String> getVerificationStatus() async {
    final snapshot = await firestore
        .collection(_collection)
        .where('userId', isEqualTo: _userId)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data()['status'] as String? ?? 'pending';
    }

    return 'not_verified';
  }

  @override
  Future<void> submitVerification({
    required XFile frontImage,
    required XFile backImage,
  }) async {
    final frontUrl = await _uploadImage(frontImage, 'front');
    final backUrl = await _uploadImage(backImage, 'back');
    final userId = _userId;

    final oldRequest = await firestore
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .limit(1)
        .get();

    if (oldRequest.docs.isNotEmpty) {
      await oldRequest.docs.first.reference.update({
        'frontImage': frontUrl,
        'backImage': backUrl,
        'status': 'pending',
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } else {
      await firestore.collection(_collection).add({
        'userId': userId,
        'frontImage': frontUrl,
        'backImage': backUrl,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<String> _uploadImage(XFile image, String imageType) async {
    if (kIsWeb) {
      final bytes = await image.readAsBytes();
      return storageService.uploadVerificationImage(bytes, imageType);
    }

    return storageService.uploadVerificationImage(File(image.path), imageType);
  }

  @override
  Future<XFile?> pickImage() {
    return storageService.pickSingleImage();
  }
}
