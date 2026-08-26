import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../entities/user_entity.dart';
import '../repos/auth_repo.dart';

@injectable
class UpdateUserImageUseCase {
  final AuthRepo repository;

  UpdateUserImageUseCase(this.repository);

  Future<UserEntity> call(XFile image) => repository.updateUserImage(image);
}
