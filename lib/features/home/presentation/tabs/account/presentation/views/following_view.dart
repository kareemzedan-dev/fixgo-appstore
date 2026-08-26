import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/components/show_sort_bottom_sheet.dart';
import 'package:fixgo/features/chat/presentation/widgets/custom_chat_header.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/worker_card.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/filter_sort_bar.dart';
import 'package:fixgo/features/offers/presentation/manager/offers_cubit/offers_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/offers_cubit/offers_state.dart';
import 'package:fixgo/features/offers/presentation/manager/search_cubit/search_state.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class FollowingView extends StatelessWidget {
  const FollowingView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OffersCubit>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            CustomChatHeader(
              title: AppLocalizations.of(context).peopleYouFollow,
              showEditButton: false,
            ),

            const SizedBox(height: 24),

            Expanded(
              child: BlocBuilder<OffersCubit, OffersState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.followingOffers.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context).noFollowingUsers,
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.followingOffers.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final offer = state.followingOffers[index];

                      return WorkerCard(
                        userId: offer.userId,
                        name: offer.userName ?? "",
                        job: offer.profession ?? "",
                        description: offer.title,
                        image: offer.imageUrl,
                        rating: offer.averageRating,
                        experience: offer.yearsOfExperience.toString(),
                        distance: offer.distance != null
                            ? AppLocalizations.of(context).distanceKilometers(
                                (offer.distance / 1000).toStringAsFixed(1),
                              )
                            : AppLocalizations.of(context).unknown,
                        offerId: offer.id,
                      );
                    },
                  );
                },
              ),
            ),

            /// 🔥 SORT + FILTER
            FilterSortBar(
              onSort: () {
                showSortBottomSheet(
                  context,
                  state: cubit.searchState,
                  onApply: (type) {
                    cubit.sortFollowing(type);
                  },
                );
              },

              onFilter: () {
                showFilterBottomSheet(
                  context,
                  state: cubit.searchState,
                  onApply:
                      ({
                        required minRating,
                        required maxRating,
                        required minExperience,
                        required maxExperience,
                        required minDistance,
                        required maxDistance,
                      }) {
                        cubit.filterFollowing(
                          minRating: minRating,
                          maxRating: maxRating,
                          minExperience: minExperience,
                          maxExperience: maxExperience,
                          minDistance: minDistance,
                          maxDistance: maxDistance,
                        );
                      },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
