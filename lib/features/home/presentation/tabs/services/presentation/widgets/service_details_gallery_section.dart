import 'package:flutter/material.dart';
import 'package:fixgo/l10n/app_localizations.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/helper/dashed_border_painter.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'service_details_gallery_item.dart';

class ServiceDetailsGallerySection extends StatelessWidget {
  final List<String> images;
  final String mainImage;
  final bool isOwner;

  /// 🔥 الجديد
  final VoidCallback? onAddImage;
  final bool isLoading;

  const ServiceDetailsGallerySection({
    Key? key,
    required this.images,
    required this.mainImage,
    this.isOwner = false,
    this.onAddImage,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allImages = images.isNotEmpty ? images : [mainImage];

    final displayImages = [...allImages, if (isOwner) "ADD_BUTTON"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// =========================
        /// Title
        /// =========================
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context).businessGallery,
              style: TextStyle(
                fontSize: AppSizes.sp(14),
                fontWeight: FontWeight.w700,
                height: 1.60,
              ),
            ),
          ],
        ),

        SizedBox(height: AppSizes.h(14)),

        /// =========================
        /// Gallery List
        /// =========================
        SizedBox(
          height: AppSizes.h(110),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,

            /// 🔥 أهم سطر
            itemCount: displayImages.length,

            separatorBuilder: (_, __) => SizedBox(width: AppSizes.w(10)),

            itemBuilder: (context, index) {
              final item = displayImages[index];

              /// =========================
              /// ➕ ADD BUTTON
              /// =========================
              if (item == "ADD_BUTTON") {
                return GestureDetector(
                  onTap: isLoading ? null : onAddImage,
                  child: SizedBox(
                    width: AppSizes.w(125),
                    height: AppSizes.h(104),
                    child: CustomPaint(
                      painter: DashedBorderPainter(),
                      child: Center(
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.add,
                                    size: 22,
                                    color: Color(0xFF737373),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    AppLocalizations.of(context).addImage,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF737373),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                );
              }

              /// =========================
              /// 🖼️ IMAGE ITEM
              /// =========================
              return SizedBox(
                width: AppSizes.w(125),
                child: ServiceDetailsGalleryItem(
                  image: item,
                  images: allImages,
                  index: index,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
