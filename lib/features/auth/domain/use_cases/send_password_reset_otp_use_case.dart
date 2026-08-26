import 'package:injectable/injectable.dart';
import 'package:fixgo/features/auth/domain/repos/auth_repo.dart';

@injectable
class SendPasswordResetOtpUseCase {
  final AuthRepo authRepo;

  SendPasswordResetOtpUseCase(this.authRepo);

  Future<void> call(String phone) => authRepo.sendPasswordResetOtp(phone);
}
