import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/verification/domain/repos/verification_repo.dart';

@injectable
class SubmitVerificationUseCase {
  final VerificationRepo repo;

  SubmitVerificationUseCase(this.repo);

  Future<void> call({required XFile frontImage, required XFile backImage}) {
    return repo.submitVerification(
      frontImage: frontImage,
      backImage: backImage,
    );
  }
}
