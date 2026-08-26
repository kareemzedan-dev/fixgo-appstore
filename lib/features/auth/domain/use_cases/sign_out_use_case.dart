import 'package:injectable/injectable.dart';

import '../repos/auth_repo.dart';
@injectable
class SignOutUseCase {
  final AuthRepo authRepo;

  SignOutUseCase(this.authRepo);

  Future<void> call() async {
    await authRepo.signOut();
  }
}