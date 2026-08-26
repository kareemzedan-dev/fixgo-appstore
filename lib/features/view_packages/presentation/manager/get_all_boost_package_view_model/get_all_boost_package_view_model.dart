import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/view_packages/domain/use_cases/get_boost_packages_use_case.dart';
import 'package:fixgo/features/view_packages/presentation/manager/get_all_boost_package_view_model/get_all_boost_package_states.dart';

@injectable
class GetAllBoostPackageViewModel extends Cubit<GetAllBoostPackageStates> {
  final GetBoostPackagesUseCase getBoostPackagesUseCase;

  GetAllBoostPackageViewModel(this.getBoostPackagesUseCase)
    : super(GetAllBoostPackageInitial());

  Future<void> getBoostPackages() async {
    try {
      emit(GetAllBoostPackageLoading());

      final packages = await getBoostPackagesUseCase.call();

      emit(GetAllBoostPackageSuccess(packages));
    } catch (e) {
      emit(GetAllBoostPackageError(e.toString()));
    }
  }
}
