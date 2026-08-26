import 'package:flutter/material.dart';
import 'package:fixgo/core/components/custom_button.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/features/auth/presentation/widgets/phone_text_field.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class LoginFormSection extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final bool isLoading;
  final VoidCallback onForgotPassword;
  final VoidCallback onLogin;

  const LoginFormSection({
    super.key,
    required this.phoneController,
    required this.passwordController,
    required this.isLoading,
    required this.onForgotPassword,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 335,
          child: Text(
            l10n.phoneNumber,
            style: TextStyle(
              fontSize: AppSizes.sp(16),
              fontWeight: FontWeight.w400,
              height: 1.60,
            ),
          ),
        ),
        const SizedBox(height: 20),
        PhoneTextField(controller: phoneController),
        const SizedBox(height: 20),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(hintText: l10n.password),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Spacer(),
            TextButton(
              onPressed: onForgotPassword,
              child: Text(
                l10n.forgotPasswordTitle,
                style: TextStyle(
                  fontSize: AppSizes.sp(12),
                  fontWeight: FontWeight.w400,
                  height: 1.60,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: ShapeDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF0F0F1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            children: [
              Image.asset(
                AssetsManager.alert,
                width: AppSizes.w(16),
                height: AppSizes.w(16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10n.loginInstruction,
                  style: TextStyle(
                    fontSize: AppSizes.sp(10),
                    fontWeight: FontWeight.w400,
                    height: 1.60,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        CustomButton(
          text: l10n.login,
          isLoading: isLoading,
          onPressed: onLogin,
        ),
      ],
    );
  }
}
