import 'package:injectable/injectable.dart';
import 'package:fixgo/features/view_packages/domain/repos/boost_package_repository.dart';

@injectable
class ToggleBoostPackageUseCase {
  final BoostPackageRepository repo;
  ToggleBoostPackageUseCase(this.repo);

  Future<void> call(String id, bool isActive) {
    return repo.togglePackage(id, isActive);
  }
}
