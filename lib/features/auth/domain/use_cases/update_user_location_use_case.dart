import 'package:injectable/injectable.dart';

import '../entities/user_entity.dart';
import '../repos/auth_repo.dart';

@injectable
class UpdateUserLocationUseCase {
  final AuthRepo repository;

  UpdateUserLocationUseCase(this.repository);

  Future<UserEntity> call({
    required String uid,
    required double latitude,
    required double longitude,
    required String city,
    required String district,
  }) {
    return repository.updateUserLocation(
      uid: uid,
      latitude: latitude,
      longitude: longitude,
      city: city,
      district: district,
    );
  }
}
