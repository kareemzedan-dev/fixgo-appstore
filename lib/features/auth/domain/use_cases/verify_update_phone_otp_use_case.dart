import 'package:injectable/injectable.dart';

import '../repos/auth_repo.dart';

@injectable
class VerifyUpdatePhoneOtpUseCase {
  final AuthRepo repository;

  VerifyUpdatePhoneOtpUseCase(this.repository);

  Future<void> call({
    required String verificationId,
    required String otp,
    required String newPhone,
  }) {
    return repository.verifyUpdatePhoneOtp(
      verificationId: verificationId,
      otp: otp,
      newPhone: newPhone,
    );
  }
}
