import 'package:fixgo/features/view_packages/data/models/boost_package_model.dart';

abstract class BoostPackageRemoteDataSource {
  Future<List<BoostPackageModel>> getPackages();
  Future<void> addPackage(BoostPackageModel model);
  Future<void> updatePackage(BoostPackageModel model);
  Future<void> deletePackage(String id);
  Future<void> togglePackage(String id, bool isActive);
}
