import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fixgo/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/add_review_button.dart';
import 'package:fixgo/features/offers/domain/entities/offer_entity.dart';
import 'package:fixgo/features/reviews/presentation/manager/reviews_cubit/reviews_cubit.dart';
import 'package:fixgo/features/reviews/presentation/manager/reviews_cubit/reviews_state.dart';
import 'service_details_review_item.dart';

class ServiceDetailsReviewsSection extends StatelessWidget {
  final String offerId;

  /// الجديد
  final String offerOwnerId;
  final OfferEntity offer;

  const ServiceDetailsReviewsSection({
    super.key,
    required this.offerId,
    required this.offer,

    /// الجديد
    required this.offerOwnerId,
  });

  @override
  Widget build(BuildContext context) {
    final isOwner =
        offer.userId == context.watch<AppSessionCubit>().currentUser?.uid;
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        if (state is ReviewsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ReviewsFailure) {
          return Center(child: Text(state.message));
        }

        if (state is ReviewsLoaded) {
          final reviews = state.reviews;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context).reviewsAndRatings,
                    style: TextStyle(
                      fontSize: AppSizes.sp(14),
                      fontWeight: FontWeight.w700,
                      height: 1.60,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (kIsWeb) {
                        context.go("/ratings-and-reviews/$offerId");
                      } else {
                        context.push("/ratings-and-reviews/$offerId");
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context).showAll,
                      style: TextStyle(
                        fontSize: AppSizes.sp(12),
                        fontWeight: FontWeight.w600,
                        height: 1.60,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSizes.h(16)),

              if (reviews.isEmpty)
                Center(child: Text(AppLocalizations.of(context).noReviewsYet)),

              ...reviews
                  .take(3)
                  .map((review) => ServiceDetailsReviewItem(review: review)),

              SizedBox(height: AppSizes.h(20)),
              if (!isOwner)
                AddReviewButton(
                  offerId: offerId,

                  /// الجديد
                  offerOwnerId: offerOwnerId,
                ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}
