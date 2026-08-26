import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/onboarding/domain/use_cases/get_onboarding_finished_use_case.dart';
import 'package:fixgo/features/onboarding/domain/use_cases/set_onboarding_finished_use_case.dart';

@injectable
class OnboardingCubit extends Cubit<int> {
  final SetOnboardingFinishedUseCase setOnboardingFinishedUseCase;
  final GetOnboardingFinishedUseCase getOnboardingFinishedUseCase;

  OnboardingCubit(
    this.setOnboardingFinishedUseCase,
    this.getOnboardingFinishedUseCase,
  ) : super(0);

  void setIndex(int index) => emit(index);

  Future<void> completeOnboarding() {
    return setOnboardingFinishedUseCase(true);
  }

  Future<bool> hasFinished() => getOnboardingFinishedUseCase();
}
