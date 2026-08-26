import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/verification/domain/repos/verification_repo.dart';

@injectable
class PickVerificationImageUseCase {
  final VerificationRepo repo;

  PickVerificationImageUseCase(this.repo);

  Future<XFile?> call() => repo.pickImage();
}
