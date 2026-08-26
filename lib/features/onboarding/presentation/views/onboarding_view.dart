import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../manager/onboarding_view_model.dart';
import '../widgets/onboarding_view_body.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xFFDFE9FF)),
        child: BlocProvider(
          create: (context) => getIt<OnboardingViewModel>(),
          child: const OnboardingViewBody(),
        ),
      ),
    );
  }
}
