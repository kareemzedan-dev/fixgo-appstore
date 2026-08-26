import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/features/view_packages/domain/use_cases/get_boost_packages_use_case.dart';
import 'package:fixgo/features/view_packages/domain/use_cases/toggle_boost_package_use_case.dart';
import 'package:fixgo/features/view_packages/presentation/manager/boost_package_cubit/boost_package_state.dart';

class BoostPackageCubit extends Cubit<BoostPackageState> {
  final GetBoostPackagesUseCase getPackages;
  final ToggleBoostPackageUseCase togglePackage;

  BoostPackageCubit({required this.getPackages, required this.togglePackage})
    : super(BoostPackageInitial());

  Future<void> loadPackages() async {
    emit(BoostPackageLoading());
    try {
      final data = await getPackages();
      emit(BoostPackageLoaded(data));
    } catch (e) {
      emit(BoostPackageError(e.toString()));
    }
  }

  Future<void> toggle(String id, bool isActive) async {
    await togglePackage(id, isActive);
    loadPackages();
  }
}
