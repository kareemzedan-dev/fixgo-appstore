/// presentation/manager/auth_cubit/auth_cubit.dart
library;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/auth/domain/entities/user_entity.dart';
import 'package:fixgo/features/auth/domain/use_cases/delete_account_use_case.dart';
import 'package:fixgo/features/auth/domain/use_cases/login_use_case.dart';
import 'package:fixgo/features/auth/domain/use_cases/register_use_case.dart';
import 'package:fixgo/features/auth/domain/use_cases/resend_password_reset_otp_use_case.dart';
import 'package:fixgo/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:fixgo/features/auth/domain/use_cases/send_password_reset_otp_use_case.dart';
import 'package:fixgo/features/auth/domain/use_cases/verify_password_reset_otp_use_case.dart';

import '../../../domain/use_cases/login_with_phone_use_case.dart';
import '../../../domain/use_cases/send_otp_use_case.dart';
import '../../../domain/use_cases/sign_out_use_case.dart';
import '../../../domain/use_cases/update_user_use_case.dart';
import '../../../domain/use_cases/update_user_image_use_case.dart';
import '../../../domain/use_cases/update_user_location_use_case.dart';
import '../../../domain/use_cases/verify_otp_use_case.dart';
import '../../../domain/use_cases/verify_sign_in_otp_use_case.dart';
import '../../../domain/use_cases/verify_update_phone_otp_use_case.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LoginWithPhoneUseCase loginWithPhoneUseCase;
  final SendOtpUseCase sendOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final VerifySignInOtpUseCase verifySignInOtpUseCase;
  final SignOutUseCase signOutUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final SendPasswordResetOtpUseCase sendPasswordResetOtpUseCase;
  final VerifyPasswordResetOtpUseCase verifyPasswordResetOtpUseCase;
  final ResendPasswordResetOtpUseCase resendPasswordResetOtpUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  final UpdateUserImageUseCase updateUserImageUseCase;
  final UpdateUserLocationUseCase updateUserLocationUseCase;
  final VerifyUpdatePhoneOtpUseCase verifyUpdatePhoneOtpUseCase;

  AuthCubit({
    required this.loginWithPhoneUseCase,
    required this.sendOtpUseCase,
    required this.verifyOtpUseCase,
    required this.verifySignInOtpUseCase,
    required this.signOutUseCase,
    required this.updateUserUseCase,
    required this.registerUseCase,
    required this.loginUseCase,
    required this.sendPasswordResetOtpUseCase,
    required this.verifyPasswordResetOtpUseCase,
    required this.resendPasswordResetOtpUseCase,
    required this.resetPasswordUseCase,
    required this.deleteAccountUseCase,
    required this.updateUserImageUseCase,
    required this.updateUserLocationUseCase,
    required this.verifyUpdatePhoneOtpUseCase,
  }) : super(AuthInitial());

  Future<void> register({
    required String name,
    required String phone,
    required String password,
    required String type,
    String? profession,
    String? serviceCategory,
    int? yearsOfExperience,
  }) async {
    emit(AuthLoading());

    try {
      await registerUseCase.call(
        name: name,
        phone: phone,
        password: password,
        type: type,
        profession: profession,
        serviceCategory: serviceCategory,
        yearsOfExperience: yearsOfExperience,
      );

      emit(AuthSuccess('account_created'));
    } catch (e) {
      emit(AuthFailure(_failureMessage(e)));
    }
  }

  Future<void> loginWithPassword({
    required String phone,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      await loginUseCase.call(phone: phone, password: password);
      emit(AuthSuccess('login_success'));
    } catch (e) {
      emit(AuthFailure(_failureMessage(e)));
    }
  }

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
    emit(AuthLoading());

    try {
      await updateUserUseCase.call(
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

      emit(AuthSuccess('profile_updated'));
    } catch (e) {
      emit(AuthFailure(_failureMessage(e)));
    }
  }

  Future<void> verifyUpdatePhoneOtp({
    required String verificationId,
    required String otp,
    required String newPhone,
  }) async {
    emit(AuthLoading());

    try {
      await verifyUpdatePhoneOtpUseCase(
        verificationId: verificationId,
        otp: otp,
        newPhone: newPhone,
      );

      emit(AuthSuccess('phone_updated'));
    } catch (e) {
      emit(AuthFailure(_failureMessage(e)));
    }
  }

  Future<UserEntity?> updateProfileImage(XFile image) async {
    emit(AuthLoading());
    try {
      final user = await updateUserImageUseCase(image);
      emit(AuthUserUpdated(user));
      return user;
    } catch (e) {
      emit(AuthFailure(_failureMessage(e)));
      return null;
    }
  }

  Future<UserEntity?> updateUserLocation({
    required String uid,
    required double latitude,
    required double longitude,
    required String city,
    required String district,
  }) async {
    emit(AuthLoading());
    try {
      final user = await updateUserLocationUseCase(
        uid: uid,
        latitude: latitude,
        longitude: longitude,
        city: city,
        district: district,
      );
      emit(AuthUserUpdated(user));
      return user;
    } catch (e) {
      emit(AuthFailure(_failureMessage(e)));
      return null;
    }
  }

  Future<void> login(String phoneNumber) async {
    emit(AuthLoading());

    try {
      final isUserFound = await loginWithPhoneUseCase.call(phoneNumber);

      if (!isUserFound) {
        emit(AuthUserNotFound());
        return;
      }

      final verificationId = await sendOtpUseCase.call(phoneNumber);
      emit(OtpSent(verificationId));
    } catch (e) {
      emit(AuthFailure(_failureMessage(e)));
    }
  }

  Future<void> sendOtp(String phoneNumber) async {
    emit(AuthLoading());

    try {
      final verificationId = await sendOtpUseCase.call(phoneNumber);
      emit(OtpSent(verificationId));
    } catch (e) {
      emit(AuthFailure(_failureMessage(e)));
    }
  }

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
    emit(AuthLoading());

    try {
      await verifyOtpUseCase.call(
        verificationId: verificationId,
        otp: otp,
        name: name,
        phone: phone,
        type: type,
        profession: profession,
        serviceCategory: serviceCategory,
        yearsOfExperience: yearsOfExperience,
      );

      emit(AuthSuccess('register_success'));
    } catch (e) {
      emit(AuthFailure(_failureMessage(e)));
    }
  }

  Future<void> verifySignInOtp({
    required String verificationId,
    required String otp,
    required String phone,
  }) async {
    emit(AuthLoading());

    try {
      await verifySignInOtpUseCase.call(
        verificationId: verificationId,
        otp: otp,
        phone: phone,
      );

      emit(AuthSuccess('register_success'));
    } catch (e) {
      emit(AuthFailure(_failureMessage(e)));
    }
  }

  Future<void> sendPasswordResetOtp(String phone) async {
    emit(AuthLoading());
    try {
      await sendPasswordResetOtpUseCase(phone);
      emit(AuthSuccess('otp_sent'));
    } catch (e) {
      emit(AuthFailure(_failureMessage(e)));
    }
  }

  Future<void> verifyPasswordResetOtp({
    required String phone,
    required String otp,
  }) async {
    emit(AuthLoading());
    try {
      await verifyPasswordResetOtpUseCase(phone: phone, otp: otp);
      emit(AuthSuccess('otp_verified'));
    } catch (e) {
      emit(AuthFailure(_failureMessage(e)));
    }
  }

  Future<void> resendPasswordResetOtp(String phone) async {
    try {
      await resendPasswordResetOtpUseCase(phone);
      emit(AuthSuccess('otp_resent'));
    } catch (e) {
      emit(AuthFailure(_failureMessage(e)));
    }
  }

  Future<void> resetPassword({
    required String phone,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await resetPasswordUseCase(phone: phone, password: password);
      emit(AuthSuccess('password_reset'));
    } catch (e) {
      emit(AuthFailure(_failureMessage(e)));
    }
  }

  Future<void> deleteAccount() async {
    emit(AuthLoading());
    try {
      await deleteAccountUseCase();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthFailure(_failureMessage(e)));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());

    try {
      await signOutUseCase.call();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthFailure(_failureMessage(e)));
    }
  }

  String _failureMessage(Object e) {
    final msg = e.toString().replaceAll('Exception: ', '');
    if (RegExp(r'[\u0600-\u06FF]').hasMatch(msg)) {
      return 'generic_error';
    }
    return msg;
  }
}
