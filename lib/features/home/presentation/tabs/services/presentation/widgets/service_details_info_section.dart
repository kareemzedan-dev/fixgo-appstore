//==========================
// 4. service_details_info_section.dart
//==========================
import 'package:flutter/material.dart';
import 'package:fixgo/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/service_details_description_section.dart';

import 'service_details_provider_card.dart';
import 'service_details_area_section.dart';
import 'service_details_gallery_section.dart';

class ServiceDetailsInfoSection extends StatelessWidget {
  final dynamic offer;
  const ServiceDetailsInfoSection({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    final bool isOwner =
        offer.userId == context.watch<AppSessionCubit>().currentUser?.uid;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              AppLocalizations.of(context).serviceTitle,
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
        SizedBox(height: AppSizes.h(24)),
        ServiceDetailsAreaSection(
          offer: offer,
          isOwner: isOwner, // 👈 الجديد
        ),
        SizedBox(height: AppSizes.h(28)),
        ServiceDetailsGallerySection(
          images: offer.images,
          mainImage: offer.imageUrl,
          isOwner: isOwner, // 👈 الجديد
        ),
      ],
    );
  }
}
