import 'package:injectable/injectable.dart';
import 'package:fixgo/features/auth/domain/repos/auth_repo.dart';

@injectable
class CheckUserStateUsecase {
  final AuthRepo authRepo;

  CheckUserStateUsecase(this.authRepo);

  Future<bool> call(String phone) => authRepo.checkUserSuspended(phone);
}
