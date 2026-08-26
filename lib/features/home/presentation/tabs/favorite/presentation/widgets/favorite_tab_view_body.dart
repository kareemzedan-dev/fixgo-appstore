import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/components/show_sort_bottom_sheet.dart';
import 'package:fixgo/core/di/di.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/worker_card.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/worker_shimmer_list_vertical.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/filter_sort_bar.dart';
import 'package:fixgo/features/offers/presentation/manager/search_cubit/search_cubit.dart';
import 'package:fixgo/l10n/app_localizations.dart';

import '../../../../../../favorite/presentation/manager/favorite_cubit/favorite_cubit.dart';
import '../../../../../../favorite/presentation/manager/favorite_cubit/favorite_state.dart';

class FavoriteTabViewBody extends StatelessWidget {
  const FavoriteTabViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      /// الصحيح هنا init() وليس getFavoriteOffers()
      create: (_) => getIt<FavoriteCubit>()..init(),

      child: Column(
        children: [
          // FilterSortBar(
          //   onSort: () {
          //     final searchState = context.read<SearchCubit>().state;

          //     showSortBottomSheet(
          //       context,
          //       state: searchState,
          //       onApply: (sortType) {
          //         context.read<FavoriteCubit>().sortOffers(sortType);
          //       },
          //     );
          //   },

          // onFilter: () {
          //   showFilterBottomSheet(
          //     context,
          //     state: context.read<SearchCubit>().state,
          //     onApply: ({
          //       required double minRating,
          //       required double maxRating,
          //       required int minExperience,
          //       required int maxExperience,
          //       required double minDistance,
          //       required double maxDistance,
          //     }) {
          //       print("FILTER: $minExperience"); // 👈 جرب دي

          //       context.read<FavoriteCubit>().filterOffers(
          //         minExperience: minExperience,
          //       );
          //     },
          //   );
          // },
          // ),
          SizedBox(height: AppSizes.p8),

          Expanded(
            child: BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                /// Loading
                if (state is FavoriteLoading) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: const Center(child: WorkerShimmerListVertical()),
                  );
                }

                /// Error
                if (state is FavoriteFailure) {
                  return Center(child: Text(state.message));
                }

                /// Success
                if (state is FavoriteSuccess) {
                  /// Empty State
                  if (state.offers.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context).noFavoriteServices,
                      ),
                    );
                  }

                  /// List
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.separated(
                      itemCount: state.offers.length,
                      itemBuilder: (context, index) {
                        final offer = state.offers[index];

                        return WorkerCard(
                          userId: offer.userId,
                          offerId: offer.id,

                          name: offer.userName ?? "",

                          job: offer.profession ?? "",

                          rating: offer.averageRating,

                          experience: offer.yearsOfExperience.toString(),

                          distance: offer.location,

                          description: offer.title,

                          image: offer.imageUrl,
                        );
                      },
                      separatorBuilder: (_, __) =>
                          SizedBox(height: AppSizes.p16),
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
