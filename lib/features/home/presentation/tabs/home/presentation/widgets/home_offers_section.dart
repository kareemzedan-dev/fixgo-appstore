import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/worker_card.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/worker_shimmer_list_horizontal.dart';
import 'package:fixgo/features/offers/domain/entities/offer_entity.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class HomeOffersSection extends StatelessWidget {
  const HomeOffersSection({
    super.key,
    required this.title,
    required this.emptyMessage,
    required this.offers,
    required this.isLoading,
    required this.centerLoading,
    required this.userCity,
    required this.onShowAll,
  });

  final String title;
  final String emptyMessage;
  final List<OfferEntity> offers;
  final bool isLoading;
  final bool centerLoading;
  final String userCity;
  final VoidCallback onShowAll;

  @override
  Widget build(BuildContext context) {
    final visibleOffers = offers
        .where(
          (offer) =>
              !offer.isSponsored &&
              (userCity.isEmpty ||
                  offer.location.toLowerCase().contains(userCity)),
        )
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: AppSizes.p16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: onShowAll,
                child: Text(AppLocalizations.of(context).showAll),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSizes.p8),
        if (isLoading && offers.isEmpty)
          Padding(
            padding: const EdgeInsets.all(24),
            child: centerLoading
                ? const Center(child: WorkerShimmerListHorizontal())
                : const WorkerShimmerListHorizontal(),
          )
        else if (offers.isEmpty)
          Padding(
            padding: const EdgeInsets.all(24),
            child: Center(child: Text(emptyMessage)),
          )
        else
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              height: AppSizes.h(160),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: visibleOffers.length,
                itemBuilder: (context, index) {
                  final offer = visibleOffers[index];
                  return SizedBox(
                    width: AppSizes.w(320),
                    child: WorkerCard(
                      userId: offer.userId,
                      offerId: offer.id,
                      name: offer.title,
                      job: offer.profession ?? '',
                      rating: offer.averageRating,
                      experience: offer.yearsOfExperience.toString(),
                      distance: AppLocalizations.of(context).distanceKilometers(
                        (offer.distance / 1000).toStringAsFixed(1),
                      ),
                      description: offer.title,
                      image: offer.imageUrl,
                    ),
                  );
                },
                separatorBuilder: (_, __) => SizedBox(width: AppSizes.p8),
              ),
            ),
          ),
      ],
    );
  }
}
