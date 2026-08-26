import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/offers/domain/use_cases/get_provider_data_usecase.dart';
import 'package:fixgo/features/offers/presentation/manager/provider_cubit/provider_states.dart';
import 'package:fixgo/features/offers/domain/use_cases/get_provider_services_usecase.dart';

@injectable
class ProviderCubit extends Cubit<ProviderState> {
  final GetProviderServicesUseCase getProviderServicesUseCase;
  final GetProviderDataUseCase getProviderDataUseCase;

  ProviderCubit(this.getProviderServicesUseCase, this.getProviderDataUseCase)
    : super(const ProviderState());

  Future<void> getProviderData(String userId) async {
    emit(state.copyWith(isLoading: true));

    try {
      final services = await getProviderServicesUseCase(userId);

      final provider = await getProviderDataUseCase(userId); // 👈 الصح

      emit(
        state.copyWith(
          isLoading: false,
          services: services,
          provider: provider,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
