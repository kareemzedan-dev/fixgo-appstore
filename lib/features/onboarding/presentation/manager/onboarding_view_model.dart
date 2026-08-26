import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/onboarding/domain/use_cases/set_onboarding_finished_use_case.dart';

@injectable
class OnboardingViewModel extends Cubit<int> {
  final SetOnboardingFinishedUseCase setOnboardingFinishedUseCase;

  OnboardingViewModel(this.setOnboardingFinishedUseCase) : super(0);

  final PageController pageController = PageController();

  void onPageChanged(int index) {
    emit(index);
  }

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void previousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> finishOnboarding() {
    return setOnboardingFinishedUseCase(true);
  }
}
