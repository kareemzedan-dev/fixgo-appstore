import 'package:fixgo/features/view_packages/domain/entities/boost_package_entity.dart';

abstract class BoostPackageRepository {
  Future<List<BoostPackageEntity>> getPackages();
  Future<void> addPackage(BoostPackageEntity entity);
  Future<void> updatePackage(BoostPackageEntity entity);
  Future<void> deletePackage(String id);
  Future<void> togglePackage(String id, bool isActive);
}
