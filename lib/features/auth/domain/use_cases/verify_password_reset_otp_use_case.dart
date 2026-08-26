import 'package:injectable/injectable.dart';
import 'package:fixgo/features/auth/domain/repos/auth_repo.dart';

@injectable
class VerifyPasswordResetOtpUseCase {
  final AuthRepo authRepo;

  VerifyPasswordResetOtpUseCase(this.authRepo);

  Future<void> call({required String phone, required String otp}) {
    return authRepo.verifyPasswordResetOtp(phone: phone, otp: otp);
  }
}
