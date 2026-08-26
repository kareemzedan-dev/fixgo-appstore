import 'package:flutter/material.dart';
import 'package:fixgo/core/components/custom_button.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/chat/presentation/widgets/custom_chat_header.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class VerificationStatusView extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final String? buttonText;
  final VoidCallback? onPressed;

  const VerificationStatusView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(height: AppSizes.h(20)),
              CustomChatHeader(
                title: l10n.verificationTitle,
                showEditButton: false,
              ),
              const Spacer(),
              Icon(icon, size: 100, color: iconColor),
              SizedBox(height: AppSizes.h(24)),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppSizes.h(12)),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.7,
                ),
              ),
              const Spacer(),
              if (buttonText != null && onPressed != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: CustomButton(text: buttonText!, onPressed: onPressed!),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
