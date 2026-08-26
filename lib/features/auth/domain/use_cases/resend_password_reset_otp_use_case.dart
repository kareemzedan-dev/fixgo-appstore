import 'package:injectable/injectable.dart';
import 'package:fixgo/features/auth/domain/repos/auth_repo.dart';

@injectable
class ResendPasswordResetOtpUseCase {
  final AuthRepo authRepo;

  ResendPasswordResetOtpUseCase(this.authRepo);

  Future<void> call(String phone) => authRepo.resendPasswordResetOtp(phone);
}
