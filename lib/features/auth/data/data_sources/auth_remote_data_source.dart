/// data/data_sources/auth_remote_data_source.dart
library;

import 'package:image_picker/image_picker.dart';

import '../../domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<bool> checkUserExistsByPhone(String phone);

  /// OTP
  Future<String> sendOtp(String phone);

  Future<void> verifyOtp({
    required String verificationId,
    required String otp,
    required String name,
    required String phone,
    required String type,
    String? profession,
    String? serviceCategory,
    int? yearsOfExperience,
  });

  Future<void> verifySignInOtp({
    required String verificationId,
    required String otp,
    required String phone,
  });

  /// Password Auth
  Future<void> register({
    required String name,
    required String phone,
    required String password,
    required String type,
    String? profession,
    String? serviceCategory,
    int? yearsOfExperience,
  });

  Future<void> login({required String phone, required String password});

  /// Profile
  Future<void> updateUser({
    required String uid,
    String? name,
    String? phone,
    String? city,
    String? district,
    double? latitude,
    double? longitude,
    String? profession,
    String? serviceCategory,
    int? yearsOfExperience,
  });

  /// Password reset (Cloud Functions)
  Future<void> sendPasswordResetOtp(String phone);

  Future<void> verifyPasswordResetOtp({
    required String phone,
    required String otp,
  });

  Future<void> resendPasswordResetOtp(String phone);

  Future<void> resetPassword({required String phone, required String password});

  Future<void> deleteAccount();

  Future<UserEntity> updateUserImage(XFile image);

  Future<UserEntity> updateUserLocation({
    required String uid,
    required double latitude,
    required double longitude,
    required String city,
    required String district,
  });

  Future<void> verifyUpdatePhoneOtp({
    required String verificationId,
    required String otp,
    required String newPhone,
  });

  Future<void> signOut();
  Future<bool> checkUserSuspended(String phone);
}
