import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/components/custom_button.dart';
import 'package:fixgo/core/components/custom_top_error_message.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/chat/presentation/widgets/custom_chat_header.dart';
import 'package:fixgo/features/verification/presentation/manager/verification_cubit/verification_cubit.dart';
import 'package:fixgo/features/verification/presentation/manager/verification_cubit/verification_state.dart';
import 'package:fixgo/features/verification/presentation/widgets/verification_upload_card.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class VerificationUploadView extends StatelessWidget {
  const VerificationUploadView({super.key});

  String _failureMessage(AppLocalizations l10n, VerificationFailure failure) {
    switch (failure) {
      case VerificationFailure.incompleteImages:
        return l10n.verificationIncompleteImages;
      case VerificationFailure.submitFailed:
        return l10n.verificationSubmitFailed;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocConsumer<VerificationCubit, VerificationState>(
      listenWhen: (previous, current) =>
          previous.failure != current.failure ||
          previous.submitSuccess != current.submitSuccess,
      listener: (context, state) {
        if (state.failure != null) {
          CustomTopErrorMessage.show(
            context,
            message: _failureMessage(l10n, state.failure!),
          );
          context.read<VerificationCubit>().clearFeedback();
          return;
        }

        if (state.submitSuccess) {
          CustomTopErrorMessage.show(
            context,
            message: l10n.verificationSubmitSuccess,
            isSuccess: true,
          );
          context.read<VerificationCubit>().clearFeedback();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        final cubit = context.read<VerificationCubit>();

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: AppSizes.h(20)),
                    CustomChatHeader(
                      title: l10n.verificationTitleShort,
                      showEditButton: false,
                    ),
                    SizedBox(height: AppSizes.h(24)),
                    VerificationUploadCard(
                      title: l10n.verificationFrontTitle,
                      subtitle: l10n.verificationFrontSubtitle,
                      image: state.frontImage,
                      onTap: cubit.pickFrontImage,
                    ),
                    SizedBox(height: AppSizes.h(14)),
                    VerificationUploadCard(
                      title: l10n.verificationBackTitle,
                      subtitle: l10n.verificationBackSubtitle,
                      image: state.backImage,
                      onTap: cubit.pickBackImage,
                    ),
                    SizedBox(height: AppSizes.h(18)),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF1E1E1E)
                            : const Color(0xFFF1F5FB),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.verificationTipsTitle,
                            style: TextStyle(
                              fontSize: AppSizes.sp(13),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: AppSizes.h(8)),
                          Text(
                            l10n.verificationTipClarity,
                            style: TextStyle(
                              fontSize: AppSizes.sp(12),
                              color: const Color(0xFF2D6CDF),
                              height: 1.7,
                            ),
                          ),
                          Text(
                            l10n.verificationTipLighting,
                            style: TextStyle(
                              fontSize: AppSizes.sp(12),
                              color: const Color(0xFF2D6CDF),
                              height: 1.7,
                            ),
                          ),
                          Text(
                            l10n.verificationTipAngle,
                            style: TextStyle(
                              fontSize: AppSizes.sp(12),
                              color: const Color(0xFF2D6CDF),
                              height: 1.7,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSizes.h(18)),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: CustomButton(
                        text: state.canSubmit
                            ? l10n.verificationSubmit
                            : l10n.verificationCompleteUploads,
                        onPressed: state.canSubmit
                            ? cubit.submitVerification
                            : () {},
                        isLoading: state.isSubmitting,
                        backgroundColor: state.canSubmit
                            ? const Color(0xFF243E63)
                            : isDark
                            ? const Color(0xFF1E1E1E)
                            : const Color(0xFFE0E0E0),
                        textColor: state.canSubmit ? Colors.white : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
