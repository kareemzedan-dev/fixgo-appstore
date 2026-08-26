import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/search_and_filter.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/worker_card.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/filter_sort_bar.dart';
import 'package:fixgo/features/offers/presentation/manager/service_category_cubit/service_category_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/service_category_cubit/service_category_state.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class ServiceDetailsViewBody extends StatefulWidget {
  final String category;

  const ServiceDetailsViewBody({super.key, required this.category});

  @override
  State<ServiceDetailsViewBody> createState() => _ServiceDetailsViewBodyState();
}

class _ServiceDetailsViewBodyState extends State<ServiceDetailsViewBody> {
  Timer? _debounce;
  @override
  void initState() {
    super.initState();

    context.read<ServiceCategoryCubit>().getOffersByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchAndFilter(
          openSearchPageOnly: false,
          onSearch: (value) {
            if (_debounce?.isActive ?? false) _debounce!.cancel();

            _debounce = Timer(const Duration(milliseconds: 300), () {
              context.read<ServiceCategoryCubit>().search(value);
            });
          },
          onFilter: () {},
          showfiler: false,
        ),

        SizedBox(height: AppSizes.p8),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<ServiceCategoryCubit, ServiceCategoryState>(
              builder: (context, state) {
                if (state is ServiceCategoryLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ServiceCategoryFailure) {
                  return Center(child: Text(state.message));
                }

                if (state is ServiceCategoryLoaded) {
                  if (state.offers.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context).noServiceProviders,
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: state.offers.length,
                    itemBuilder: (context, index) {
                      final offer = state.offers[index];

                      return WorkerCard(
                        userId: offer.userId,
                        name: offer.title ?? "",
                        job: offer.profession ?? "",
                        rating: offer.averageRating,
                        experience: offer.yearsOfExperience.toString(),
                        distance: offer.neighborhood,
                        description: "",
                        image: offer.imageUrl,
                        offerId: offer.id,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: AppSizes.p16),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ),

        SizedBox(height: AppSizes.p8),
      ],
    );
  }
}
