import 'package:injectable/injectable.dart';
import 'package:fixgo/features/view_packages/domain/entities/boost_package_entity.dart';
import 'package:fixgo/features/view_packages/domain/repos/boost_package_repository.dart';

@injectable
class GetBoostPackagesUseCase {
  final BoostPackageRepository repo;
  GetBoostPackagesUseCase(this.repo);

  Future<List<BoostPackageEntity>> call() {
    return repo.getPackages();
  }
}
