import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/di/di.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/features/splash/presentation/manager/splash_cubit.dart';
import 'package:fixgo/features/splash/presentation/widgets/splash_view_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SplashCubit>()..resolveNext(),
      child: BlocListener<SplashCubit, SplashNavigationTarget>(
        listener: (context, state) {
          if (state == SplashNavigationTarget.home) {
            context.go('/home/home');
          } else if (state == SplashNavigationTarget.onboarding) {
            context.go('/onboarding');
          }
        },
        child: const Scaffold(
          backgroundColor: ColorsManager.white,
          body: SplashViewBody(),
        ),
      ),
    );
  }
}
