import 'package:flutter/material.dart';
import 'package:fixgo/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fixgo/core/di/di.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/service_details_area_section.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/service_details_description_section.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/service_details_gallery_section.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/service_details_provider_card.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/service_details_reviews_section.dart';
import 'package:fixgo/features/reviews/presentation/manager/reviews_cubit/reviews_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/update_offer_cubit/update_offer_cubit.dart';

class OwnerServiceTabsView extends StatefulWidget {
  final dynamic offer;

  const OwnerServiceTabsView({super.key, required this.offer});

  @override
  State<OwnerServiceTabsView> createState() => _OwnerServiceTabsViewState();
}

class _OwnerServiceTabsViewState extends State<OwnerServiceTabsView> {
  int selectedIndex = 0;

  /// 🔥 الصور المحلية (عشان نعمل refresh)
  late List<String> images;

  bool isUploading = false;

  @override
  void initState() {
    super.initState();

    /// خد الصور الحالية
    images = List<String>.from(widget.offer.images ?? []);
  }

  /// =========================
  /// 🔥 رفع صورة + تحديث
  /// =========================
  Future<void> addImage() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (file == null) return;
    if (!mounted) return;

    setState(() => isUploading = true);

    try {
      final updateOfferCubit = context.read<UpdateOfferCubit>();
      final url = await updateOfferCubit.uploadOfferImage(file);
      if (!mounted) return;

      /// ضيف الصورة
      images.add(url);

      /// 🔥 update firestore
      await updateOfferCubit.updateOffer(
        offerId: widget.offer.id,
        title: widget.offer.title,
        description: widget.offer.description,
        category: widget.offer.category,
        serviceCategory: widget.offer.serviceCategory,
        yearsOfExperience: widget.offer.yearsOfExperience,
        imageUrl: widget.offer.imageUrl,
        images: images,
        location: widget.offer.location,
      );

      if (!mounted) return;
      setState(() {});
    } catch (e) {
      debugPrint("Upload Error: $e");
    }

    if (mounted) {
      setState(() => isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final offer = widget.offer;
    final l10n = AppLocalizations.of(context);
    final tabs = [
      l10n.businessGallery,
      l10n.serviceAreas,
      l10n.reviewsAndRatings,
    ];
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// =========================
        /// Provider
        /// =========================
        Text(
          AppLocalizations.of(context).serviceProvider,
          style: TextStyle(
            fontSize: AppSizes.sp(14),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: AppSizes.h(14)),

        ServiceDetailsProviderCard(offer: offer),
        SizedBox(height: AppSizes.h(14)),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.serviceTitle,
              style: TextStyle(
                fontSize: AppSizes.sp(14),
                fontWeight: FontWeight.w700,
                height: 1.60,
              ),
            ),
            SizedBox(height: AppSizes.h(12)),
            Text(
              offer.title,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: ColorsManager.darkGrey,
                fontSize: AppSizes.sp(12),
                fontFamily: 'Alyamama',
                fontWeight: FontWeight.w400,
                height: 1.60,
              ),
            ),
          ],
        ),
        SizedBox(height: AppSizes.h(24)),
        ServiceDetailsDescriptionSection(description: offer.description),
        SizedBox(height: AppSizes.h(16)),

        /// =========================
        /// 🔥 Tabs
        /// =========================
        Row(
          children: List.generate(tabs.length, (index) {
            final isSelected = selectedIndex == index;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.symmetric(horizontal: AppSizes.w(4)),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? isDark
                              ? const Color(0Xff1E1E1E)
                              : Colors.grey.shade200
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? isDark
                                ? const Color(0Xff1E1E1E)
                                : Colors.transparent
                          : Colors.grey.shade400,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      tabs[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),

        SizedBox(height: AppSizes.h(16)),

        /// =========================
        /// 🔥 Content
        /// =========================
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: _buildContent(offer),
        ),
      ],
    );
  }

  /// =========================
  /// TAB CONTENT
  /// =========================
  Widget _buildContent(dynamic offer) {
    switch (selectedIndex) {
      case 0:
        return ServiceDetailsGallerySection(
          key: const ValueKey(0),

          /// 👇 أهم حاجة
          images: images,

          mainImage: offer.imageUrl,
          isOwner: true,

          /// 👇 الربط
          onAddImage: addImage,
          isLoading: isUploading,
        );

      case 1:
        return ServiceDetailsAreaSection(
          key: const ValueKey(1),
          isOwner: true,
          offer: offer,
        );

      case 2:
        return BlocProvider(
          key: const ValueKey(2),
          create: (_) => getIt<ReviewsCubit>()..fetchReviews(offer.id),
          child: ServiceDetailsReviewsSection(
            offer: offer,
            offerId: offer.id,
            offerOwnerId: offer.userId,
          ),
        );

      default:
        return const SizedBox();
    }
  }
}
