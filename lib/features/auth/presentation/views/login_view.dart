import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/di/di.dart';
import 'package:fixgo/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:fixgo/features/auth/presentation/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: SafeArea(child: LoginViewBody()),
      ),
    );
  }
}
