import 'package:injectable/injectable.dart';
import 'package:fixgo/features/auth/domain/repos/auth_repo.dart';

@injectable
class DeleteAccountUseCase {
  final AuthRepo authRepo;

  DeleteAccountUseCase(this.authRepo);

  Future<void> call() => authRepo.deleteAccount();
}
