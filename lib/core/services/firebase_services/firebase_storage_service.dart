 import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirebaseStorageService {
  final FirebaseStorage storage =
      FirebaseStorage.instance;

  final ImagePicker picker =
      ImagePicker();

  /// ===============================
  /// Pick Single Image
  /// ===============================

  Future<XFile?> pickSingleImage() async {
    try {
      final XFile? image =
          await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      return image;
    } catch (e) {
      log(
        "pickSingleImage Error => ${e.toString()}",
      );
      return null;
    }
  }
/// ===============================
/// Upload Verification Image
/// للهوية / التوثيق
/// ===============================

Future<String> uploadVerificationImage(
  dynamic image,
  String imageType,
) async {
  try {
    final fileName =
        "${DateTime.now().millisecondsSinceEpoch}_$imageType.jpg";

    final ref = storage
        .ref()
        .child(
          "verification/$fileName",
        );

    UploadTask uploadTask;

    /// WEB
    if (kIsWeb) {
      uploadTask = ref.putData(
        image,
        SettableMetadata(
          contentType: "image/jpeg",
        ),
      );
    }

    /// MOBILE
    else {
      uploadTask = ref.putFile(
        image,
      );
    }

    final snapshot =
        await uploadTask;

    final downloadUrl =
        await snapshot.ref
            .getDownloadURL();

    log(
      "uploadVerificationImage Success => $downloadUrl",
    );

    return downloadUrl;
  } catch (e) {
    log(
      "uploadVerificationImage Error => ${e.toString()}",
    );

    throw Exception(
      "فشل رفع صورة التوثيق",
    );
  }
}
  /// ===============================
  /// Pick Multiple Images
  /// ===============================

  Future<List<XFile>> pickMultipleImages() async {
    try {
      final List<XFile> images =
          await picker.pickMultiImage(
        imageQuality: 80,
      );

      return images;
    } catch (e) {
      log(
        "pickMultipleImages Error => ${e.toString()}",
      );
      return [];
    }
  }

  /// ===============================
  /// Upload Single Image
  /// ===============================

  Future<String> uploadSingleImage({
    required XFile image,
    required String folderName,
  }) async {
    try {
      final fileName =
          DateTime.now()
              .millisecondsSinceEpoch
              .toString();

      final ref = storage
          .ref()
          .child(
            "$folderName/$fileName.jpg",
          );

      UploadTask uploadTask;

      /// WEB
      if (kIsWeb) {
        Uint8List bytes =
            await image.readAsBytes();

        uploadTask = ref.putData(
          bytes,
          SettableMetadata(
            contentType: "image/jpeg",
          ),
        );
      }

      /// MOBILE
      else {
        final file = File(image.path);

        uploadTask = ref.putFile(file);
      }

      final snapshot =
          await uploadTask;

      final downloadUrl =
          await snapshot.ref
              .getDownloadURL();

      log(
        "uploadSingleImage Success => $downloadUrl",
      );

      return downloadUrl;
    } catch (e) {
      log(
        "uploadSingleImage Error => ${e.toString()}",
      );

      throw Exception(
        "فشل رفع الصورة",
      );
    }
  }

  /// ===============================
  /// Upload Multiple Images
  /// ===============================

  Future<List<String>>
      uploadMultipleImages({
    required List<XFile> images,
    required String folderName,
  }) async {
    try {
      List<String> imageUrls = [];

      for (final image in images) {
        final url =
            await uploadSingleImage(
          image: image,
          folderName: folderName,
        );

        imageUrls.add(url);
      }

      log(
        "uploadMultipleImages Success => $imageUrls",
      );

      return imageUrls;
    } catch (e) {
      log(
        "uploadMultipleImages Error => ${e.toString()}",
      );

      throw Exception(
        "فشل رفع الصور",
      );
    }
  }

  /// ===============================
  /// Delete Image
  /// ===============================

  Future<void> deleteImage(
    String imageUrl,
  ) async {
    try {
      final ref = storage.refFromURL(
        imageUrl,
      );

      await ref.delete();

      log(
        "deleteImage Success",
      );
    } catch (e) {
      log(
        "deleteImage Error => ${e.toString()}",
      );
    }
  }
}