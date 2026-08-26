library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/components/custom_button.dart';
import 'package:fixgo/core/components/custom_top_message.dart';
import 'package:fixgo/core/di/di.dart';
import 'package:fixgo/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:fixgo/features/auth/presentation/manager/auth_cubit/auth_state.dart';
import 'package:fixgo/features/auth/presentation/widgets/auth_header.dart';
import 'package:fixgo/features/auth/presentation/utils/auth_message_localizer.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class CreateNewPasswordView extends StatefulWidget {
  final String phone;

  const CreateNewPasswordView({super.key, required this.phone});

  @override
  State<CreateNewPasswordView> createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess && state.message == 'password_reset') {
            CustomTopMessage.show(
              context,
              message: l10n.passwordChangedSuccess,
              type: MessageType.success,
            );
            Future.delayed(const Duration(milliseconds: 800), () {
              if (context.mounted) context.go('/login');
            });
          } else if (state is AuthFailure) {
            CustomTopMessage.show(
              context,
              message: localizeAuthMessage(l10n, state.message),
              type: MessageType.error,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    AuthHeader(
                      headerTitle: l10n.forgotPasswordTitle,
                      title: l10n.enterNewPasswordTitle,
                      subtitle: l10n.enterNewPasswordSubtitle,
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: l10n.newPasswordHint,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: l10n.confirmPasswordHint,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: l10n.save,
                      isLoading: state is AuthLoading,
                      onPressed: () {
                        if (passwordController.text.trim().isEmpty) {
                          CustomTopMessage.show(
                            context,
                            message: l10n.enterPassword,
                            type: MessageType.warning,
                          );
                          return;
                        }
                        if (confirmPasswordController.text.trim().isEmpty) {
                          CustomTopMessage.show(
                            context,
                            message: l10n.confirmPassword,
                            type: MessageType.warning,
                          );
                          return;
                        }
                        if (passwordController.text.trim() !=
                            confirmPasswordController.text.trim()) {
                          CustomTopMessage.show(
                            context,
                            message: l10n.passwordsDoNotMatch,
                            type: MessageType.error,
                          );
                          return;
                        }

                        context.read<AuthCubit>().resetPassword(
                          phone: widget.phone,
                          password: passwordController.text.trim(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
