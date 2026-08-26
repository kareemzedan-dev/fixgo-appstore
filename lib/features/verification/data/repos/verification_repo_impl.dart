import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/verification/data/data_sources/verification_remote_data_source.dart';
import 'package:fixgo/features/verification/domain/repos/verification_repo.dart';

@LazySingleton(as: VerificationRepo)
class VerificationRepoImpl implements VerificationRepo {
  final VerificationRemoteDataSource remoteDataSource;

  VerificationRepoImpl({required this.remoteDataSource});

  @override
  Future<String> getVerificationStatus() {
    return remoteDataSource.getVerificationStatus();
  }

  @override
  Future<void> submitVerification({
    required XFile frontImage,
    required XFile backImage,
  }) {
    return remoteDataSource.submitVerification(
      frontImage: frontImage,
      backImage: backImage,
    );
  }

  @override
  Future<XFile?> pickImage() {
    return remoteDataSource.pickImage();
  }
}
