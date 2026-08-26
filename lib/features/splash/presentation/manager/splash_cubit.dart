import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/onboarding/domain/use_cases/get_onboarding_finished_use_case.dart';

enum SplashNavigationTarget { loading, home, onboarding }

@injectable
class SplashCubit extends Cubit<SplashNavigationTarget> {
  final GetOnboardingFinishedUseCase getOnboardingFinishedUseCase;

  SplashCubit(this.getOnboardingFinishedUseCase)
    : super(SplashNavigationTarget.loading);

  Future<void> resolveNext() async {
    await Future.delayed(const Duration(seconds: 4));
    final finished = await getOnboardingFinishedUseCase();
    emit(
      finished
          ? SplashNavigationTarget.home
          : SplashNavigationTarget.onboarding,
    );
  }
}
