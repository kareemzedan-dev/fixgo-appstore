/// domain/use_cases/verify_otp_use_case.dart
library;

import 'package:injectable/injectable.dart';
import '../repos/auth_repo.dart';

@injectable
class VerifyOtpUseCase {
  final AuthRepo authRepo;

  VerifyOtpUseCase(this.authRepo);

  Future<void> call({
    required String verificationId,
    required String otp,
    required String name,
    required String phone,

    /// user | worker
    required String type,

    /// worker only
    String? profession,
    String? serviceCategory,
   int? yearsOfExperience,
  }) async {
    await authRepo.verifyOtp(
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
}