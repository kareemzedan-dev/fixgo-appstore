import 'package:injectable/injectable.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repos/auth_repo.dart';
import '../data_sources/auth_remote_data_source.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepoImpl(this.remoteDataSource);
  @override
  Future<void> register({
    required String name,
    required String phone,
    required String password,
    required String type,
    String? profession,
    String? serviceCategory,
    int? yearsOfExperience,
  }) async {
    await remoteDataSource.register(
      name: name,
      phone: phone,
      password: password,
      type: type,
      profession: profession,
      serviceCategory: serviceCategory,
      yearsOfExperience: yearsOfExperience,
    );
  }

  @override
  Future<void> login({required String phone, required String password}) async {
    await remoteDataSource.login(phone: phone, password: password);
  }

  @override
  Future<bool> checkUserExistsByPhone(String phone) async {
    return await remoteDataSource.checkUserExistsByPhone(phone);
  }

  @override
  Future<String> sendOtp(String phone) async {
    return await remoteDataSource.sendOtp(phone);
  }

  /// data/repos/auth_repo_impl.dart

  @override
  Future<void> verifyOtp({
    required String verificationId,
    required String otp,
    required String name,
    required String phone,
    required String type,
    String? profession,
    String? serviceCategory,
    int? yearsOfExperience,
  }) async {
    await remoteDataSource.verifyOtp(
      verificationId: verificationId,
      otp: otp,
      name: name,
      phone: phone,
      type: type,
      profession: profession,
      serviceCategory: serviceCategory,
      yearsOfExperience: yearsOfExperience,
    );
  }

  @override
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
  }) async {
    await remoteDataSource.updateUser(
      uid: uid,
      name: name,
      phone: phone,
      city: city,
      district: district,
      latitude: latitude,
      longitude: longitude,
      profession: profession,
      serviceCategory: serviceCategory,
      yearsOfExperience: yearsOfExperience,
    );
  }

  @override
  Future<void> verifySignInOtp({
    required String verificationId,
    required String otp,
    required String phone,
  }) async {
    await remoteDataSource.verifySignInOtp(
      verificationId: verificationId,
      otp: otp,
      phone: phone,
    );
  }

  @override
  Future<UserEntity> updateUserImage(XFile image) {
    return remoteDataSource.updateUserImage(image);
  }

  @override
  Future<UserEntity> updateUserLocation({
    required String uid,
    required double latitude,
    required double longitude,
    required String city,
    required String district,
  }) {
    return remoteDataSource.updateUserLocation(
      uid: uid,
      latitude: latitude,
      longitude: longitude,
      city: city,
      district: district,
    );
  }

  @override
  Future<void> verifyUpdatePhoneOtp({
    required String verificationId,
    required String otp,
    required String newPhone,
  }) {
    return remoteDataSource.verifyUpdatePhoneOtp(
      verificationId: verificationId,
      otp: otp,
      newPhone: newPhone,
    );
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }

  @override
  Future<void> sendPasswordResetOtp(String phone) {
    return remoteDataSource.sendPasswordResetOtp(phone);
  }

  @override
  Future<void> verifyPasswordResetOtp({
    required String phone,
    required String otp,
  }) {
    return remoteDataSource.verifyPasswordResetOtp(phone: phone, otp: otp);
  }

  @override
  Future<void> resendPasswordResetOtp(String phone) {
    return remoteDataSource.resendPasswordResetOtp(phone);
  }

  @override
  Future<void> resetPassword({
    required String phone,
    required String password,
  }) {
    return remoteDataSource.resetPassword(phone: phone, password: password);
  }

  @override
  Future<void> deleteAccount() {
    return remoteDataSource.deleteAccount();
  }

  @override
  Future<bool> checkUserSuspended(String phone) async {
    return remoteDataSource.checkUserSuspended(phone);
  }
}
