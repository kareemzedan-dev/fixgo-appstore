library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/components/custom_button.dart';
import 'package:fixgo/core/components/custom_top_message.dart';
import 'package:fixgo/core/di/di.dart';
import 'package:fixgo/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:fixgo/features/auth/presentation/manager/auth_cubit/auth_state.dart';
import 'package:fixgo/features/auth/presentation/widgets/phone_text_field.dart';
import 'package:fixgo/features/auth/presentation/utils/auth_message_localizer.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final phoneController = TextEditingController();

  String cleanText(String text) {
    return text
        .replaceAll(' ', '')
        .replaceAll('-', '')
        .replaceAll('(', '')
        .replaceAll(')', '');
  }

  String normalizePhoneNumber() {
    String cleaned = cleanText(phoneController.text);

    return '+968$cleaned';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess && state.message == 'otp_sent') {
            CustomTopMessage.show(
              context,
              message: l10n.otpSentSuccess,
              type: MessageType.success,
            );
            context.push('/forgot_password_otp', extra: normalizePhoneNumber());
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
            appBar: AppBar(title: Text(l10n.forgotPasswordTitle)),
            body: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  PhoneTextField(controller: phoneController),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: l10n.sendVerificationCode,
                    isLoading: state is AuthLoading,
                    onPressed: () {
                      context.read<AuthCubit>().sendPasswordResetOtp(
                        normalizePhoneNumber(),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
