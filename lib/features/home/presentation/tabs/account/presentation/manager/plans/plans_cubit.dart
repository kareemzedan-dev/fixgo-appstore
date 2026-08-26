import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/home/presentation/tabs/account/domain/use_cases/get_plans_use_case.dart';
import 'plans_state.dart';

@injectable
class PlansCubit extends Cubit<PlansState> {
  final GetPlansUseCase getPlansUseCase;

  PlansCubit(this.getPlansUseCase) : super(PlansInitial());
  Future<void> fetchPlans() async {
    emit(PlansLoading());

    try {
      final plans = await getPlansUseCase();

      emit(PlansLoaded(plans));
      log("Fetched ${plans.length} plans from Firestore");
    } catch (e) {
      emit(PlansError('Error fetching plans: $e'));
      log("Error fetching plans: $e");
    }
  }
}
