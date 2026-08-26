import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/components/custom_button.dart';
import 'package:fixgo/core/components/custom_top_error_message.dart';
import 'package:fixgo/core/components/custom_top_message.dart';
import 'package:fixgo/core/di/di.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:fixgo/features/auth/presentation/manager/auth_cubit/auth_state.dart';
import 'package:fixgo/features/auth/presentation/widgets/auth_header.dart';
import 'package:fixgo/features/auth/presentation/widgets/otp_fields.dart';
import 'package:fixgo/features/auth/presentation/utils/auth_message_localizer.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class ForgotPasswordOtpView extends StatefulWidget {
  final String phone;

  const ForgotPasswordOtpView({super.key, required this.phone});

  @override
  State<ForgotPasswordOtpView> createState() => _ForgotPasswordOtpViewState();
}

class _ForgotPasswordOtpViewState extends State<ForgotPasswordOtpView> {
  String enteredOtp = '';
  int seconds = 60;
  bool canResend = false;
  late Timer timer;
  final GlobalKey<OtpFieldsState> otpKey = GlobalKey<OtpFieldsState>();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    canResend = false;
    seconds = 60;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds == 0) {
        setState(() => canResend = true);
        t.cancel();
      } else {
        setState(() => seconds--);
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess && state.message == 'otp_verified') {
            context.push('/create_new_password', extra: widget.phone);
          } else if (state is AuthSuccess && state.message == 'otp_resent') {
            startTimer();
            CustomTopMessage.show(
              context,
              message: l10n.otpResent,
              type: MessageType.success,
            );
          } else if (state is AuthFailure) {
            otpKey.currentState?.clearOtp();
            CustomTopErrorMessage.show(
              context,
              message: localizeAuthMessage(l10n, state.message),
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
                      title: l10n.enterOtpTitle,
                      subtitle: l10n.enterOtpSubtitle(widget.phone),
                    ),
                    const SizedBox(height: 40),
                    OtpFields(
                      key: otpKey,
                      length: 6,
                      onCompleted: (otp) => enteredOtp = otp,
                    ),
                    const SizedBox(height: 40),
                    CustomButton(
                      text: l10n.confirm,
                      isLoading: state is AuthLoading,
                      onPressed: () {
                        if (enteredOtp.length != 6) {
                          CustomTopErrorMessage.show(
                            context,
                            message: l10n.enterFullOtp,
                          );
                          return;
                        }
                        context.read<AuthCubit>().verifyPasswordResetOtp(
                          phone: widget.phone,
                          otp: enteredOtp,
                        );
                      },
                    ),
                    SizedBox(height: AppSizes.h(16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: canResend
                              ? () => context
                                    .read<AuthCubit>()
                                    .resendPasswordResetOtp(widget.phone)
                              : null,
                          child: Text(
                            l10n.resendOtp,
                            style: TextStyle(
                              fontSize: AppSizes.sp(16),
                              fontWeight: FontWeight.w500,
                              color: canResend ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(width: AppSizes.w(16)),
                        Text(
                          canResend
                              ? ''
                              : '00:${seconds.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            fontSize: AppSizes.sp(16),
                            color: Colors.grey,
                          ),
                        ),
                      ],
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
