import 'package:injectable/injectable.dart';
import 'package:fixgo/features/auth/domain/repos/auth_repo.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo authRepo;

  ResetPasswordUseCase(this.authRepo);

  Future<void> call({required String phone, required String password}) {
    return authRepo.resetPassword(phone: phone, password: password);
  }
}
