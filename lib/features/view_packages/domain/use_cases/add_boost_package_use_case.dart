import 'package:injectable/injectable.dart';
import 'package:fixgo/features/view_packages/domain/entities/boost_package_entity.dart';
import 'package:fixgo/features/view_packages/domain/repos/boost_package_repository.dart';

@injectable
class AddBoostPackageUseCase {
  final BoostPackageRepository repo;
  AddBoostPackageUseCase(this.repo);

  Future<void> call(BoostPackageEntity entity) {
    return repo.addPackage(entity);
  }
}
