import 'package:injectable/injectable.dart';

import '../repos/auth_repo.dart';
@injectable
class LoginWithPhoneUseCase {
  final AuthRepo authRepo;

  LoginWithPhoneUseCase(this.authRepo);

  Future<bool> call(String phone) async {
    return await authRepo.checkUserExistsByPhone(phone);
  }
}