import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/components/custom_app_bar.dart';
import 'package:fixgo/core/di/di.dart';
import 'package:fixgo/features/reviews/domain/entities/review_entity.dart';
import 'package:fixgo/features/reviews/presentation/manager/reviews_cubit/reviews_cubit.dart';
import 'package:fixgo/features/reviews/presentation/manager/reviews_cubit/reviews_state.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class RatingsAndReviewsView extends StatelessWidget {
  final String offerId;

  const RatingsAndReviewsView({super.key, required this.offerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ReviewsCubit>()..fetchReviews(offerId),
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppLocalizations.of(context).reviewsAndRatings,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<ReviewsCubit, ReviewsState>(
            builder: (context, state) {
              if (state is ReviewsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ReviewsFailure) {
                return Center(child: Text(state.message));
              }

              if (state is ReviewsLoaded) {
                final reviews = state.reviews;

                if (reviews.isEmpty) {
                  return Center(
                    child: Text(AppLocalizations.of(context).noReviewsYet),
                  );
                }

                return ListView.separated(
                  itemCount: reviews.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final review = reviews[index];

                    return ReviewItem(review: review);
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  final ReviewEntity review;

  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEAEAEA))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review.userName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                _formatDate(review.createdAt),
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Row(
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star,
                size: 18,
                color: index < (review.rating ?? 0).round()
                    ? Colors.amber
                    : Colors.grey.shade300,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            review.content,
            style: const TextStyle(
              fontSize: 13,
              height: 1.7,
              color: Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
