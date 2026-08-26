import 'package:flutter/material.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/worker_card.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class AllServicesList extends StatelessWidget {
  final List offers;
  final bool isLoading;

  const AllServicesList({
    super.key,
    required this.offers,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (offers.isEmpty) {
      return Center(child: Text(AppLocalizations.of(context).noServices));
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: offers.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final offer = offers[index];
        return WorkerCard(
          userId: offer.userId,
          offerId: offer.id,
          name: offer.title ?? "",
          job: offer.profession ?? "",
          description: offer.description,
          image: offer.imageUrl,
          rating: offer.averageRating,
          experience: "${offer.yearsOfExperience}",
          isSponsored: offer.isSponsored || offer.sp,
          distance: AppLocalizations.of(
            context,
          ).distanceKilometers((offer.distance / 1000).toStringAsFixed(1)),
        );
      },
    );
  }
}
