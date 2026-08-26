import 'package:injectable/injectable.dart';
import 'package:fixgo/features/auth/domain/repos/auth_repo.dart';

@injectable
class UpdateUserUseCase {
  final AuthRepo repository;

  UpdateUserUseCase(this.repository);

  Future<void> call({
    required String uid,
    String? name,
    String? phone,
    String? city,
    String? district,
    double? latitude,
    double? longitude,
    String? profession,
    String? serviceCategory,
    int? yearsOfExperience,
  }) async {
    return await repository.updateUser(
      uid: uid,
      name: name,
      phone: phone,
      city: city,
      district: district,
      latitude: latitude,
      longitude: longitude,
      profession: profession,
      serviceCategory: serviceCategory,
      yearsOfExperience: yearsOfExperience,
    );
  }
}
