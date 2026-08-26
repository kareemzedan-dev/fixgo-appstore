import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/core/session/app_session_state.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/add_review_bottom_sheet.dart';
import 'package:fixgo/features/reviews/domain/entities/review_entity.dart';
import 'package:fixgo/features/reviews/presentation/manager/reviews_cubit/reviews_cubit.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class AddReviewButton extends StatelessWidget {
  final String offerId;
  final String offerOwnerId;

  const AddReviewButton({
    super.key,
    required this.offerId,
    required this.offerOwnerId,
  });

  Future<void> _submitReview(
    BuildContext context,
    double rating,
    String comment,
  ) async {
    final sessionState = context.read<AppSessionCubit>().state;
    if (sessionState is! AppSessionAuthenticated) {
      throw AppLocalizations.of(context).loginRequiredFirst;
    }

    final currentUserId = sessionState.user.uid;
    if (currentUserId == offerOwnerId) {
      throw AppLocalizations.of(context).selfReviewNotAllowed;
    }

    final reviewsCubit = context.read<ReviewsCubit>();
    final oldReview = await reviewsCubit.getUserReview(
      offerId: offerId,
      userId: currentUserId,
    );
    final review = ReviewEntity(
      id: oldReview?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      offerId: offerId,
      userId: currentUserId,
      userName: sessionState.user.name,
      content: comment,
      rating: rating,
      createdAt: oldReview?.createdAt ?? DateTime.now(),
    );

    if (oldReview != null) {
      await reviewsCubit.updateReview(
        offerId: offerId,
        offerOwnerId: offerOwnerId,
        review: review,
      );
    } else {
      await reviewsCubit.addReview(
        offerId: offerId,
        offerOwnerId: offerOwnerId,
        review: review,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return OutlinedButton(
      onPressed: () async {
        final messenger = ScaffoldMessenger.of(context);
        final successMessage = AppLocalizations.of(context).reviewSentSuccess;
        final submitted = await showModalBottomSheet<bool>(
          context: context,
          isScrollControlled: true,
          backgroundColor: isDark ? const Color(0Xff1E1E1E) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSizes.r(24)),
            ),
          ),
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<ReviewsCubit>()),
              BlocProvider.value(value: context.read<AppSessionCubit>()),
            ],
            child: AddReviewBottomSheet(
              onSubmit: (rating, comment) async {
                await _submitReview(context, rating, comment);
              },
            ),
          ),
        );
        if (submitted == true) {
          messenger.showSnackBar(SnackBar(content: Text(successMessage)));
        }
      },
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, AppSizes.h(54)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.r(18)),
        ),
        side: const BorderSide(color: Color(0xFF1D3964)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.rate_review_outlined,
            size: AppSizes.w(18),
            color: const Color(0xFF1D3964),
          ),
          SizedBox(width: AppSizes.w(8)),
          Text(
            AppLocalizations.of(context).addReview,
            style: TextStyle(
              fontSize: AppSizes.sp(12),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
