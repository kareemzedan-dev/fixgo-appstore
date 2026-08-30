import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fixgo/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/components/custom_top_message.dart';

import 'package:fixgo/core/di/di.dart';
import 'package:fixgo/core/services/phone_service.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/core/session/app_session_state.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/contact_actions_section.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/owner_service_tabs_view.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/service_details_boost_button.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/service_details_bottom_actions.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/service_details_header.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/service_details_info_section.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/service_details_report_button.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/service_details_reviews_section.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/service_details_similar_services_section.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/service_details_shimmer.dart';

import 'package:fixgo/features/offers/presentation/manager/offer_details_cubit/offer_details_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/offer_details_cubit/offer_details_state.dart';
import 'package:fixgo/features/reviews/presentation/manager/reviews_cubit/reviews_cubit.dart';

/// ===============================
/// MAIN VIEW
/// ===============================
class ServiceDetailsView extends StatelessWidget {
  final String offerId, userId;

  const ServiceDetailsView({
    super.key,
    required this.offerId,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final appSessionCubit = context.watch<AppSessionCubit>();
    final sessionState = appSessionCubit.state;
    final isGuest = sessionState is! AppSessionAuthenticated;
    return BlocProvider(
      create: (_) => getIt<OfferDetailsCubit>()..getOfferDetails(offerId),
      child: Scaffold(
        bottomNavigationBar: const ServiceDetailsBottomActions(),
        body: BlocBuilder<OfferDetailsCubit, OfferDetailsState>(
          builder: (context, state) {
            if (state is OfferDetailsLoading) {
              return const Scaffold(
                body: Center(child: SafeArea(child: ServiceDetailsShimmer())),
              );
            }

            if (state is OfferDetailsFailure) {
              return Scaffold(body: Center(child: Text(state.message)));
            }

            if (state is OfferDetailsSuccess) {
              final offer = state.offer;

              final isOwner = offer.userId == appSessionCubit.currentUser?.uid;

              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: AppSizes.h(16)),

                            /// HEADER
                            ServiceDetailsHeader(offer: offer),

                            SizedBox(height: AppSizes.h(20)),

                            /// BOOST BUTTON (Owner only)
                            // if (isOwner)
                            //   Padding(
                            //     padding: EdgeInsets.all(AppSizes.p16),
                            //     child: ServiceDetailsBoostButton(offer: offer),
                            //   ),
                            // SizedBox(height: AppSizes.h(16)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.p20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// ======================
                                  /// 🔥 SWITCH UI
                                  /// ======================
                                  isOwner
                                      ? OwnerServiceTabsView(offer: offer)
                                      : ServiceDetailsInfoSection(offer: offer),

                                  SizedBox(height: AppSizes.h(28)),

                                  /// Reviews (for normal users)
                                  if (!isOwner)
                                    BlocProvider(
                                      create: (_) =>
                                          getIt<ReviewsCubit>()
                                            ..fetchReviews(offer.id),
                                      child: ServiceDetailsReviewsSection(
                                        offer: offer,
                                        offerId: offer.id,
                                        offerOwnerId: offer.userId,
                                      ),
                                    ),

                                  SizedBox(height: AppSizes.h(28)),

                                  ServiceDetailsSimilarServicesSection(
                                    offer: offer,
                                  ),

                                  SizedBox(height: AppSizes.h(28)),

                                  const ServiceDetailsReportButton(),

                                  SizedBox(height: AppSizes.h(28)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// ======================
                    /// 🔥 CONTACT (hide for owner)
                    /// ======================
                    if (!isOwner)
                      Column(
                        children: [
                          SizedBox(height: AppSizes.h(16)),
                          ContactActionsSection(
                            onCall: () {
                              PhoneService.makeCall(offer.phone);
                            },
                            onChat: () {
                              if (isGuest) {
                                _handleGuest(context);
                                return;
                              }

                              final id = Uri.encodeComponent(userId);

                              if (kIsWeb) {
                                context.go("${'/chat-details'}/$id");
                              } else {
                                context.push("${'/chat-details'}/$id");
                              }
                            },
                            onWhatsapp: () {
                              PhoneService.openWhatsApp(offer.phone);
                            },
                          ),
                          SizedBox(height: AppSizes.h(16)),
                        ],
                      ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  void _handleGuest(BuildContext context) {
    CustomTopMessage.show(
      context,
      message: AppLocalizations.of(context).loginRequiredFirst,
      type: MessageType.warning,
    );
  }
}
