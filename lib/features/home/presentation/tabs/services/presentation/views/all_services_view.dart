import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/constants/cities.dart';
import 'package:fixgo/core/di/di.dart';
import 'package:fixgo/core/services/location_service/location_service.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/features/chat/presentation/widgets/custom_chat_header.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/search_and_filter.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/all_services_list.dart';
import 'package:fixgo/features/offers/domain/use_cases/count_offer_view_use_case.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class AllServicesView extends StatefulWidget {
  final String title;
  final List offers;
  final String type;
  final bool? isnear;

  const AllServicesView({
    super.key,
    required this.title,
    required this.offers,
    required this.type,
    required this.isnear,
  });

  @override
  State<AllServicesView> createState() => _AllServicesViewState();
}

class _AllServicesViewState extends State<AllServicesView> {
  List localOffers = [];

  final Set<String> currentlyVisibleSponsored = {};
  bool isLoading = true;
  String? userCity;

  @override
  void initState() {
    super.initState();
    print("USER CITY: $userCity");

    for (final e in widget.offers) {
      print("OFFER LOCATION: ${e.location}");
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userCity = getIt<AppSessionCubit>().currentUser?.city
          ?.trim()
          .toLowerCase();

      if (userCity == null || userCity!.isEmpty) {
        userCity = await LocationService.getCurrentCity(context);
        userCity = userCity?.trim().toLowerCase();
      }

      final isInOman =
          userCity != null &&
          cities.map((e) => e.toLowerCase()).contains(userCity);

      setState(() {
        if (!isInOman) {
          // خارج السعودية -> اعرض كل الخدمات
          localOffers = widget.offers
              .where((e) => e.isSponsored != true)
              .toList();
        } else {
          // داخل السعودية -> فلتر حسب المدينة
          localOffers = widget.offers.where((e) {
            return e.isSponsored != true &&
                e.location.toString().toLowerCase().contains(userCity!);
          }).toList();
        }
      });
    });
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final finalTitle = widget.title.isNotEmpty
        ? widget.title
        : (widget.type == "nearby"
              ? AppLocalizations.of(context).nearbyServices
              : AppLocalizations.of(context).recommendedServices);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            /// =========================
            /// HEADER
            /// =========================
            CustomChatHeader(
              title: finalTitle,

              showEditButton: false,

              onBack: () {
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: 12),

            /// =========================
            /// SEARCH
            /// =========================
            SearchAndFilter(
              openSearchPageOnly: false,

              onSearch: (value) async {
                final query = value.trim().toLowerCase();

                /// =========================
                /// RESET
                /// =========================

                if (query.isEmpty) {
                  currentlyVisibleSponsored.clear();

                  setState(() {
                    localOffers = widget.offers
                        .where((e) => e.isSponsored != true)
                        .toList();
                  });

                  return;
                }

                /// =========================
                /// FILTER
                /// =========================

                final filtered = widget.offers.where((offer) {
                  final name = (offer.userName ?? "").toLowerCase();

                  final job = (offer.profession ?? "").toLowerCase();

                  final title = (offer.title ?? "").toLowerCase();

                  return name.contains(query) ||
                      job.contains(query) ||
                      title.contains(query);
                }).toList();

                /// =========================
                /// NEARBY
                /// =========================

                if (widget.type == "nearby") {
                  /// الأقرب أولًا
                  filtered.sort((a, b) => a.distance.compareTo(b.distance));
                }
                /// =========================
                /// RECOMMENDED
                /// =========================
                else {
                  final sponsored = filtered.where((e) {
                    return e.isSponsored == true ||
                        e.sp == true ||
                        e.isViewSponsored == true;
                  }).toList();

                  final normal = filtered.where((e) {
                    return !(e.isSponsored == true ||
                        e.sp == true ||
                        e.isViewSponsored == true);
                  }).toList();

                  /// 🔥 shuffle ads
                  sponsored.shuffle();

                  /// ترتيب العادي
                  normal.sort(
                    (a, b) => b.averageRating.compareTo(a.averageRating),
                  );

                  filtered
                    ..clear()
                    ..addAll(sponsored)
                    ..addAll(normal);
                }

                /// =========================
                /// CURRENT VISIBLE ADS
                /// =========================

                final currentSponsoredIds = filtered
                    .where((e) => e.isViewSponsored == true)
                    .map<String>((e) => e.id.toString())
                    .toSet();

                /// =========================
                /// COUNT VIEWS
                /// =========================

                for (final offer in filtered) {
                  final isSponsored = offer.isViewSponsored == true;

                  if (!isSponsored) {
                    continue;
                  }

                  /// 👇 ظهر لأول مرة
                  final isNewAppearance = !currentlyVisibleSponsored.contains(
                    offer.id.toString(),
                  );

                  if (isNewAppearance) {
                    try {
                      await getIt<CountOfferViewUseCase>()(
                        offerId: offer.id,
                        offerOwnerId: offer.userId,
                        userId: context
                            .read<AppSessionCubit>()
                            .currentUser
                            ?.uid,
                      );
                    } catch (_) {}
                  }
                }

                /// =========================
                /// UPDATE TRACKING
                /// =========================

                currentlyVisibleSponsored
                  ..clear()
                  ..addAll(currentSponsoredIds);

                /// =========================
                /// UPDATE UI
                /// =========================

                setState(() {
                  localOffers = filtered;
                });
              },

              onFilter: () {},

              showfiler: false,
            ),

            const SizedBox(height: 16),

            /// =========================
            /// LIST
            /// =========================
            Expanded(
              child: AllServicesList(offers: localOffers, isLoading: isLoading),
            ),
          ],
        ),
      ),
    );
  }
}
