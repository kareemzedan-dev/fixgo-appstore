import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fixgo/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/offers/presentation/manager/offers_cubit/offers_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/offers_cubit/offers_state.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/worker_card.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

class ServiceDetailsSimilarServicesSection extends StatefulWidget {
  final dynamic offer;
  const ServiceDetailsSimilarServicesSection({Key? key, required this.offer})
    : super(key: key);

  @override
  State<ServiceDetailsSimilarServicesSection> createState() =>
      _ServiceDetailsSimilarServicesSectionState();
}

class _ServiceDetailsSimilarServicesSectionState
    extends State<ServiceDetailsSimilarServicesSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OffersCubit>().getSimilarOffers(
        offerId: widget.offer.id,
        serviceCategory: widget.offer.serviceCategory,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<OffersCubit, OffersState>(
      builder: (context, state) {
        if (state.isSimilarLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final similarOffers = state.similarOffers;
        if (similarOffers.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).similarServices,
                style: TextStyle(
                  fontSize: AppSizes.sp(14),
                  fontWeight: FontWeight.w700,
                  height: 1.60,
                ),
              ),
              SizedBox(height: AppSizes.h(16)),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.p20,
                  horizontal: AppSizes.p16,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0Xff1E1E1E)
                      : const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(AppSizes.r16),
                  border: Border.all(color: const Color(0xFFE5E5E5)),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).noSimilarServices,
                    style: TextStyle(
                      fontSize: AppSizes.sp(14),
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).similarServices,
                  style: TextStyle(
                    fontSize: AppSizes.sp(14),
                    fontWeight: FontWeight.w700,
                    height: 1.60,
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (kIsWeb) {
                      context.go(
                        "/service-category-details/${widget.offer.serviceCategory}",
                      );
                    } else {
                      context.push(
                        "/service-category-details/${widget.offer.serviceCategory}",
                      );
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
            SizedBox(
              height: AppSizes.h(160),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: similarOffers.length > 5 ? 5 : similarOffers.length,
                separatorBuilder: (_, __) => SizedBox(width: AppSizes.w(12)),
                itemBuilder: (context, index) {
                  final item = similarOffers[index];
                  return SizedBox(
                    width: AppSizes.w(320),
                    child: WorkerCard(
                      userId: item.userId,
                      name: item.title ?? "",
                      job: item.profession ?? "",
                      description: item.title,
                      image: item.imageUrl,
                      rating: item.averageRating,
                      experience: "${item.yearsOfExperience}",
                      distance: item.location,
                      offerId: item.id,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
