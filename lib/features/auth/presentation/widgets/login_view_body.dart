/// presentation/views/widgets/login_view_body.dart
/// تم استخدام CustomTopMessage بدل SnackBar بالكامل
library;

import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/components/custom_top_message.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:fixgo/features/auth/presentation/manager/auth_cubit/auth_state.dart';
import 'package:fixgo/features/auth/presentation/utils/auth_message_localizer.dart';
import 'package:fixgo/features/auth/presentation/widgets/login_form_section.dart';
import 'package:fixgo/l10n/app_localizations.dart';

import '../widgets/auth_header.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final String selectedCountryCode = "+968";

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String cleanText(String text) {
    return text
        .replaceAll(' ', '')
        .replaceAll('-', '')
        .replaceAll('(', '')
        .replaceAll(')', '');
  }

  String normalizePhoneNumber(AppLocalizations l10n) {
    String cleaned = cleanText(phoneController.text);

    /// لازم يكون 9 أرقام
    if (cleaned.length != 8) {
      throw Exception(l10n.phoneNumberNineDigits);
    }

    /// نحول دايمًا لسعودي
    return "+968$cleaned";
  }

  void _login(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    try {
      if (phoneController.text.trim().isEmpty) {
        CustomTopMessage.show(
          context,
          message: l10n.enterPhoneNumber,
          type: MessageType.warning,
        );
        return;
      }
      if (passwordController.text.trim().isEmpty) {
        CustomTopMessage.show(
          context,
          message: l10n.enterPassword,
          type: MessageType.warning,
        );
        return;
      }
      final phone = normalizePhoneNumber(l10n);

      context.read<AuthCubit>().loginWithPassword(
        phone: phone,
        password: passwordController.text.trim(),
      );
    } catch (e) {
      CustomTopMessage.show(
        context,
        message: e.toString().replaceAll("Exception: ", ""),
        type: MessageType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        /// User Not Found
        if (state is AuthUserNotFound) {
          CustomTopMessage.show(
            context,
            message: AppLocalizations.of(context).phoneNotRegistered,
            type: MessageType.warning,
          );
        }

        /// Failure
        if (state is AuthFailure) {
          CustomTopMessage.show(
            context,
            message: localizeAuthMessage(
              AppLocalizations.of(context),
              state.message,
            ),
            type: MessageType.error,
          );
        }

        /// Success
        if (state is AuthSuccess) {
          CustomTopMessage.show(
            context,
            message: localizeAuthMessage(
              AppLocalizations.of(context),
              state.message,
            ),
            type: MessageType.success,
          );

          context.read<AppSessionCubit>().loadUser();

          Future.delayed(const Duration(milliseconds: 800), () {
            context.go("/home/home");
          });
        }
      },
      builder: (context, state) {
        final bool isLoading = state is AuthLoading;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Header
                  AuthHeader(
                    headerTitle: l10n.createAccount,
                    title: l10n.welcomeBack,
                    subtitle: l10n.welcomeBackSubtitle,
                    showBack: true,
                  ),

                  const SizedBox(height: 32),
                  LoginFormSection(
                    phoneController: phoneController,
                    passwordController: passwordController,
                    isLoading: isLoading,
                    onForgotPassword: () => context.push("/forgot_password"),
                    onLogin: () => _login(context),
                  ),
                  SizedBox(height: 12),
                  TextButton(
                    child: Text(l10n.createAccount),
                    onPressed: () {
                      if (kIsWeb) {
                        context.push("/role_selection");
                      } else {
                        context.push("/role_selection");
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        ColorsManager.secondaryColor.withValues(alpha: 0.8),
                      ),
                      foregroundColor: WidgetStatePropertyAll(
                        ColorsManager.white,
                      ),
                      textStyle: WidgetStatePropertyAll(
                        TextStyle(
                          fontFamily: "Alyamama",
                          fontSize: 16,
                          color: ColorsManager.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
