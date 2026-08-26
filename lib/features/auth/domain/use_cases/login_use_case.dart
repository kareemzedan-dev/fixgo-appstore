import 'package:injectable/injectable.dart';
import 'package:fixgo/features/auth/domain/repos/auth_repo.dart';

@injectable
class LoginUseCase {
  final AuthRepo authRepo;

  LoginUseCase(this.authRepo);

  Future<void> call({required String phone, required String password}) {
    return authRepo.login(phone: phone, password: password);
  }
}
