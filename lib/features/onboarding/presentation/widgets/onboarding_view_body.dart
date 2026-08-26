import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';
import '../manager/onboarding_view_model.dart';
import 'onboarding_page.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingViewModel, int>(
      builder: (context, currentPage) {
        final vm = context.read<OnboardingViewModel>();
        final l10n = AppLocalizations.of(context);

        return PageView(
          controller: vm.pageController,
          onPageChanged: vm.onPageChanged,
          physics: const BouncingScrollPhysics(),
          children: [
            OnboardingPage(
              image: AssetsManager.onboarding1,
              title: l10n.onboarding_quality_title,
              description: l10n.onboarding_quality_desc,
              currentIndex: currentPage,
              totalPages: 3,
              onSkip: () async {
                await vm.finishOnboarding();
                if (context.mounted) context.go('/home/home');
              },
              onNext: vm.nextPage,
            ),
            OnboardingPage(
              image: AssetsManager.onboarding2,
              title: l10n.onboarding_service_title,
              description: l10n.onboarding_service_desc,
              currentIndex: currentPage,
              totalPages: 3,
              onSkip: () async {
                await vm.finishOnboarding();
                if (context.mounted) context.go('/home/home');
              },
              onNext: vm.nextPage,
              onPrevious: vm.previousPage,
            ),
            OnboardingPage(
              image: AssetsManager.onboarding3,
              title: l10n.onboarding_technician_title,
              description: l10n.onboarding_technician_desc,
              currentIndex: currentPage,
              totalPages: 3,
              isLast: true,
              onSkip: () async {
                await vm.finishOnboarding();
                if (context.mounted) context.go('/home/home');
              },
              onNext: () async {
                await vm.finishOnboarding();
                if (context.mounted) context.go('/home/home');
              },
              onPrevious: vm.previousPage,
            ),
          ],
        );
      },
    );
  }
}
