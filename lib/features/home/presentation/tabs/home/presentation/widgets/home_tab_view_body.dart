import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/home_slider_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/core/session/app_session_state.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/filter_view.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/home_offers_section.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/home_service_categories_section.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/search_and_filter.dart';
import 'package:fixgo/features/home/presentation/widgets/home_header.dart';
import 'package:fixgo/features/stories/presentation/widgets/Stories_bar.dart';
import 'package:fixgo/l10n/app_localizations.dart';

import '../../../../../../offers/presentation/manager/offers_cubit/offers_cubit.dart';
import '../../../../../../offers/presentation/manager/offers_cubit/offers_state.dart';

class HomeTabViewBody extends StatelessWidget {
  const HomeTabViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final userCity =
        context
            .read<AppSessionCubit>()
            .currentUser
            ?.city
            ?.trim()
            .toLowerCase() ??
        '';

    return SingleChildScrollView(
      child: Column(
        children: [
          const HomeHeader(),

          SizedBox(height: AppSizes.p8),
          SearchAndFilter(
            onSearch: (query) => _openSearch(context, query),
            onFilter: () => _openFilter(context),
          ),

          SizedBox(height: AppSizes.p8),
          HomeSliderView(),
          SizedBox(height: AppSizes.p16),

          // BlocSelector<AppSessionCubit, AppSessionState, bool>(
          //   selector: (state) {
          //     if (state is AppSessionAuthenticated) {
          //       return state.user.type.toLowerCase().trim() == "worker";
          //     }
          //     return false;
          //   },
          //   builder: (context, isWorker) {
          //     return StoriesBar(isWorker: isWorker);
          //   },
          // ),
          // SizedBox(height: AppSizes.p8),
          HomeServiceCategoriesSection(
            onShowAll: () => _openRoute(context, '/home/services'),
            onCategorySelected: (category) {
              final encodedCategory = Uri.encodeComponent(category);
              _openRoute(context, '/service-category-details/$encodedCategory');
            },
          ),

          SizedBox(height: AppSizes.p16),

          BlocBuilder<OffersCubit, OffersState>(
            builder: (context, state) {
              final l10n = AppLocalizations.of(context);
              return HomeOffersSection(
                title: l10n.nearbyServices,
                emptyMessage: l10n.noNearbyServices,
                offers: state.nearbyOffers,
                isLoading: state.isLoading,
                centerLoading: true,
                userCity: userCity,
                onShowAll: () => _openOffers(
                  context,
                  route: '/all-services/nearby',
                  title: l10n.nearbyServices,
                  offers: state.nearbyOffersOriginal,
                  isNear: true,
                ),
              );
            },
          ),

          SizedBox(height: AppSizes.p16),

          BlocBuilder<OffersCubit, OffersState>(
            builder: (context, state) {
              final l10n = AppLocalizations.of(context);
              return HomeOffersSection(
                title: l10n.recommendedServices,
                emptyMessage: l10n.noRecommendedServices,
                offers: state.recommendedOffers,
                isLoading: state.isLoading,
                centerLoading: false,
                userCity: userCity,
                onShowAll: () => _openOffers(
                  context,
                  route: '/all-services/recommended',
                  title: l10n.recommendedServices,
                  offers: state.recommendedOffersOriginal,
                  isNear: false,
                ),
              );
            },
          ),

          SizedBox(height: AppSizes.p24),
          SizedBox(height: AppSizes.p24),
        ],
      ),
    );
  }

  void _openSearch(BuildContext context, String query) {
    if (kIsWeb) {
      context.go('/search', extra: query);
    } else {
      context.push('/search', extra: query);
    }
  }

  Future<void> _openFilter(BuildContext context) async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const FilterView()),
    );
    if (result == null || !context.mounted) return;

    print(result);
    context.read<OffersCubit>().applyFilter(
      category: result['category'],
      service: result['service'],
      minRating: result['ratingStart'],
      maxRating: result['ratingEnd'],
      minExperience: result['experienceStart'].toInt(),
      maxExperience: result['experienceEnd'].toInt(),
      minDistance: result['distanceStart'],
      maxDistance: result['distanceEnd'],
    );
  }

  void _openRoute(BuildContext context, String route) {
    if (kIsWeb) {
      context.go(route);
    } else {
      context.push(route);
    }
  }

  void _openOffers(
    BuildContext context, {
    required String route,
    required String title,
    required Object offers,
    required bool isNear,
  }) {
    final data = {'title': title, 'offers': offers, 'isNear': isNear};
    if (kIsWeb) {
      context.go(route, extra: data);
    } else {
      context.push(route, extra: data);
    }
  }
}
