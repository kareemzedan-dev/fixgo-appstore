import 'package:fixgo/features/view_packages/domain/entities/boost_package_entity.dart';

abstract class GetAllBoostPackageStates {}

class GetAllBoostPackageInitial extends GetAllBoostPackageStates {}

class GetAllBoostPackageLoading extends GetAllBoostPackageStates {}

class GetAllBoostPackageError extends GetAllBoostPackageStates {
  String error;
  GetAllBoostPackageError(this.error);
}

class GetAllBoostPackageSuccess extends GetAllBoostPackageStates {
  List<BoostPackageEntity> packages;
  GetAllBoostPackageSuccess(this.packages);
}
