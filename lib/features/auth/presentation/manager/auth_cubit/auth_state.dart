/// presentation/manager/auth_cubit/auth_state.dart
library;

import '../../../domain/entities/user_entity.dart';

abstract class AuthState {}

/// الحالة الابتدائية
class AuthInitial extends AuthState {}

/// حالة اللودينج أثناء أي عملية Auth
class AuthLoading extends AuthState {}

/// عند إرسال OTP بنجاح
class OtpSent extends AuthState {
  final String verificationId;

  OtpSent(this.verificationId);
}

/// نجاح العملية (Login / Register / Verify)
class AuthSuccess extends AuthState {
  final String message;

  AuthSuccess(this.message);
}

/// فشل العملية
class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}

/// المستخدم غير موجود أثناء تسجيل الدخول
class AuthUserNotFound extends AuthState {}

/// تسجيل الخروج
class AuthLoggedOut extends AuthState {}

class AuthUserUpdated extends AuthState {
  final UserEntity user;

  AuthUserUpdated(this.user);
}
