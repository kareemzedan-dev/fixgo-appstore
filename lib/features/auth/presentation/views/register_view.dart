import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/features/auth/presentation/widgets/register_view_body.dart';

import '../../../../core/di/di.dart';
import '../manager/auth_cubit/auth_cubit.dart';

class RegisterView extends StatelessWidget {
  final bool isWorker;

  const RegisterView({super.key, required this.isWorker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => getIt<AuthCubit>(),
        child: SafeArea(child: RegisterViewBody(isWorker: isWorker)),
      ),
    );
  }
}
