import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/services/location_service/location_service.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/components/custom_app_bar.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/worker_card.dart';
import 'package:fixgo/features/offers/presentation/manager/offers_cubit/offers_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/offers_cubit/offers_state.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class ServicesByCategoryView extends StatefulWidget {
  final String serviceCategory;

  const ServicesByCategoryView({super.key, required this.serviceCategory});

  @override
  State<ServicesByCategoryView> createState() => _ServicesByCategoryViewState();
}

class _ServicesByCategoryViewState extends State<ServicesByCategoryView> {
  String? userCity;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadUserCity();

      context.read<OffersCubit>().getSimilarOffers(
        offerId: "",
        serviceCategory: widget.serviceCategory,
      );
    });
  }

  Future<void> loadUserCity() async {
    userCity = context.read<OffersCubit>().appSessionCubit.currentUser?.city;

    if (userCity == null || userCity!.trim().isEmpty) {
      userCity = await LocationService.getCurrentCity(context);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.serviceCategory),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.w(16)),
        child: BlocBuilder<OffersCubit, OffersState>(
          builder: (context, state) {
            if (state.isSimilarLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final offers = state.similarOffers.where((offer) {
              // لو لسه المدينة متجابِتش أو فاضية، اعرض الكل
              if (userCity == null || userCity!.trim().isEmpty) {
                return true;
              }

              final offerLocation = offer.location.trim().toLowerCase();

              return offerLocation.contains(userCity!.trim().toLowerCase());
            }).toList();

            if (offers.isEmpty) {
              return Center(
                child: Text(
                  AppLocalizations.of(context).noServicesCurrently,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              );
            }

            return ListView.separated(
              itemCount: offers.length,
              separatorBuilder: (_, __) => SizedBox(height: AppSizes.h(14)),
              itemBuilder: (context, index) {
                final item = offers[index];

                return WorkerCard(
                  userId: item.userId,

                  name: item.title ?? "",

                  job: item.profession ?? "",

                  description: item.title,

                  image: item.imageUrl,

                  rating: item.averageRating,

                  experience: AppLocalizations.of(
                    context,
                  ).yearValue(item.yearsOfExperience),

                  distance: item.location,

                  offerId: item.id,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
