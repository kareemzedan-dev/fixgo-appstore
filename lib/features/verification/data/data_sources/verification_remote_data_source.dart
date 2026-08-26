import 'package:image_picker/image_picker.dart';

abstract class VerificationRemoteDataSource {
  Future<String> getVerificationStatus();

  Future<void> submitVerification({
    required XFile frontImage,
    required XFile backImage,
  });

  Future<XFile?> pickImage();
}
