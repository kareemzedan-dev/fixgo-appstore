import 'package:flutter/material.dart';
import 'package:fixgo/core/components/custom_button.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/features/chat/presentation/widgets/custom_chat_header.dart';
import 'package:fixgo/features/verification/presentation/widgets/verification_feature_item.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class VerificationIntroBody extends StatelessWidget {
  final VoidCallback onStartPressed;

  const VerificationIntroBody({super.key, required this.onStartPressed});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: AppSizes.h(20)),
            CustomChatHeader(
              title: l10n.verificationTitle,
              showEditButton: false,
            ),
            SizedBox(height: AppSizes.h(20)),
            Image.asset(
              AssetsManager.verified2,
              height: AppSizes.h(160),
              width: AppSizes.w(160),
              fit: BoxFit.contain,
            ),
            SizedBox(height: AppSizes.h(30)),
            Text(
              l10n.verificationHeadline,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppSizes.sp(20),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSizes.h(12)),
            Text(
              l10n.verificationDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppSizes.sp(12),
                color: ColorsManager.darkGrey,
                height: 1.7,
              ),
            ),
            SizedBox(height: AppSizes.h(32)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE5E5E5)),
                ),
                child: Column(
                  children: [
                    VerificationFeatureItem(
                      title: l10n.verificationFeatureSearch,
                      icon: Icons.verified_user_outlined,
                    ),
                    SizedBox(height: AppSizes.h(18)),
                    VerificationFeatureItem(
                      title: l10n.verificationFeatureTrust,
                      icon: Icons.star_border,
                    ),
                    SizedBox(height: AppSizes.h(18)),
                    VerificationFeatureItem(
                      title: l10n.verificationFeatureBadge,
                      icon: Icons.verified_outlined,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: AppSizes.h(32)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                text: l10n.verificationStart,
                onPressed: onStartPressed,
              ),
            ),
            SizedBox(height: AppSizes.h(14)),
          ],
        ),
      ),
    );
  }
}
