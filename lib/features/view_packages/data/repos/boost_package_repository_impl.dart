import 'package:injectable/injectable.dart';
import 'package:fixgo/features/view_packages/data/data_sources/remote/boost_package_remote_data_source.dart';
import 'package:fixgo/features/view_packages/data/models/boost_package_model.dart';
import 'package:fixgo/features/view_packages/domain/entities/boost_package_entity.dart';
import 'package:fixgo/features/view_packages/domain/repos/boost_package_repository.dart';

@Injectable(as: BoostPackageRepository)
class BoostPackageRepositoryImpl implements BoostPackageRepository {
  final BoostPackageRemoteDataSource remote;

  BoostPackageRepositoryImpl(this.remote);

  @override
  Future<List<BoostPackageEntity>> getPackages() {
    return remote.getPackages();
  }

  @override
  Future<void> addPackage(BoostPackageEntity entity) {
    return remote.addPackage(
      BoostPackageModel(
        id: entity.id,
        title: entity.title,
        views: entity.views,
        price: entity.price,
        duration: entity.duration,
        description: entity.description,
        bankAccount: entity.bankAccount,
        isActive: entity.isActive,
      ),
    );
  }

  @override
  Future<void> updatePackage(BoostPackageEntity entity) {
    return addPackage(entity);
  }

  @override
  Future<void> deletePackage(String id) {
    return remote.deletePackage(id);
  }

  @override
  Future<void> togglePackage(String id, bool isActive) {
    return remote.togglePackage(id, isActive);
  }
}
