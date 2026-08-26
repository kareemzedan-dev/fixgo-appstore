//==========================
// 10. service_details_gallery_item.dart
//==========================
import 'package:flutter/material.dart';
import 'package:fixgo/core/components/full_screen_gallery_view.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

class ServiceDetailsGalleryItem extends StatelessWidget {
  final String image;
  final List<String> images;
  final int index;

  const ServiceDetailsGalleryItem({
    required this.image,
    required this.images,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                FullScreenGalleryView(images: images, initialIndex: index),
          ),
        );
      },
      child: Hero(
        tag: "${image}_$index",
        child: Container(
          width: AppSizes.w(125),
          height: AppSizes.h(104),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.r16),
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
