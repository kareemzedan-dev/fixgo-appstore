import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/offers/domain/repos/offers_repo.dart';

@injectable
class UploadOfferImagesUseCase {
  final OffersRepo repo;

  UploadOfferImagesUseCase(this.repo);

  Future<List<String>> call({
    required List<XFile> images,
    required String folderName,
  }) {
    return repo.uploadOfferImages(images: images, folderName: folderName);
  }
}
