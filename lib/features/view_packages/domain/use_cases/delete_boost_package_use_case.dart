import 'package:injectable/injectable.dart';
import 'package:fixgo/features/view_packages/domain/repos/boost_package_repository.dart';

@injectable
class DeleteBoostPackageUseCase {
  final BoostPackageRepository repo;
  DeleteBoostPackageUseCase(this.repo);

  Future<void> call(String id) {
    return repo.deletePackage(id);
  }
}
