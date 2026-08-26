import 'package:injectable/injectable.dart';

import '../repos/auth_repo.dart';
@injectable
class VerifySignInOtpUseCase {
  final AuthRepo authRepo;

  VerifySignInOtpUseCase(this.authRepo);

  Future<void> call({
    required String verificationId,
    required String otp,
    required String phone,
  }) async {
    await authRepo.verifySignInOtp(
      verificationId: verificationId,
      otp: otp,
      phone: phone,
    );
  }
}