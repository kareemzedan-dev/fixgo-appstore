import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/di/di.dart';
import 'package:fixgo/features/verification/presentation/manager/verification_cubit/verification_cubit.dart';
import 'package:fixgo/features/verification/presentation/manager/verification_cubit/verification_state.dart';
import 'package:fixgo/features/verification/presentation/views/verification_status_view.dart';
import 'package:fixgo/features/verification/presentation/views/verification_upload_view.dart';
import 'package:fixgo/features/verification/presentation/widgets/verification_intro_body.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<VerificationCubit>()..loadStatus(),
      child: const _VerificationViewBody(),
    );
  }
}

class _VerificationViewBody extends StatelessWidget {
  const _VerificationViewBody();

  void _openUpload(BuildContext context) {
    final cubit = context.read<VerificationCubit>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: const VerificationUploadView(),
        ),
      ),
    ).then((_) {
      cubit.loadStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<VerificationCubit, VerificationState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status == 'pending') {
          return VerificationStatusView(
            title: l10n.verificationPendingTitle,
            subtitle: l10n.verificationPendingSubtitle,
            icon: Icons.hourglass_top,
            iconColor: const Color(0xFFD98B1F),
          );
        }

        if (state.status == 'approved') {
          return VerificationStatusView(
            title: l10n.verificationApprovedTitle,
            subtitle: l10n.verificationApprovedSubtitle,
            icon: Icons.verified,
            iconColor: const Color(0xFF2E7D32),
          );
        }

        if (state.status == 'rejected') {
          return VerificationStatusView(
            title: l10n.verificationRejectedTitle,
            subtitle: l10n.verificationRejectedSubtitle,
            icon: Icons.cancel_outlined,
            iconColor: const Color(0xFFD32F2F),
            buttonText: l10n.verificationRetry,
            onPressed: () => _openUpload(context),
          );
        }

        return Scaffold(
          body: VerificationIntroBody(
            onStartPressed: () => _openUpload(context),
          ),
        );
      },
    );
  }
}
