import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/offers/domain/repos/offers_repo.dart';

@injectable
class UploadOfferImageUseCase {
  final OffersRepo repo;

  UploadOfferImageUseCase(this.repo);

  Future<String> call({required XFile image, required String folderName}) {
    return repo.uploadOfferImage(image: image, folderName: folderName);
  }
}
