import 'package:fixgo/features/view_packages/domain/entities/boost_package_entity.dart';

abstract class BoostPackageState {}

class BoostPackageInitial extends BoostPackageState {}

class BoostPackageLoading extends BoostPackageState {}

class BoostPackageLoaded extends BoostPackageState {
  final List<BoostPackageEntity> packages;
  BoostPackageLoaded(this.packages);
}

class BoostPackageError extends BoostPackageState {
  final String message;
  BoostPackageError(this.message);
}
