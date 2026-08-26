import 'package:injectable/injectable.dart';
import 'package:fixgo/features/auth/domain/repos/auth_repo.dart';

@injectable
class RegisterUseCase {
  final AuthRepo authRepo;

  RegisterUseCase(this.authRepo);

  Future<void> call({
    required String name,
    required String phone,
    required String password,
    required String type,
    String? profession,
    String? serviceCategory,
    int? yearsOfExperience,
  }) {
    return authRepo.register(
      name: name,
      phone: phone,
      password: password,
      type: type,
      profession: profession,
      serviceCategory: serviceCategory,
      yearsOfExperience: yearsOfExperience,
    );
  }
}
