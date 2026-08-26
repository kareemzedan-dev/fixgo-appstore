import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/stories/domain/repos/stories_repo.dart';

@injectable
class UploadStoryImageUseCase {
  final StoriesRepo repo;

  UploadStoryImageUseCase(this.repo);

  Future<String> call({required XFile image, required String folderName}) {
    return repo.uploadStoryImage(image: image, folderName: folderName);
  }
}
