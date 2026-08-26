import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';

class WorkerCardImage extends StatelessWidget {
  final bool showOnlyChat;
  final String image;
  final bool isSponsored;
  final String name;
  const WorkerCardImage({
    super.key,
    required this.showOnlyChat,
    required this.image,
    required this.isSponsored,
    required this.name,
  });
  @override
  Widget build(BuildContext context) {
    final hasImage = image.isNotEmpty;

    if (showOnlyChat) {
      return CircleAvatar(
        radius: AppSizes.r(40),
        backgroundColor: Colors.grey.shade200,
        backgroundImage: hasImage ? NetworkImage(image) : null,
        child: !hasImage
            ? Text(
                name.isNotEmpty ? name[0].toUpperCase() : "?",
                style: TextStyle(
                  fontSize: AppSizes.sp(18),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
            : null,
      );
    }

    return SizedBox(
      width: AppSizes.w(48) * 2,
      height: AppSizes.h(56) * 2 + AppSizes.h(40),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppSizes.r(20)),
              bottomRight: Radius.circular(AppSizes.r(20)),
            ),
            child: hasImage
                ? Image.network(
                    image,
                    width: AppSizes.w(48) * 2,
                    height: AppSizes.h(56) * 2 + AppSizes.h(40),
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return _buildFallback();
                    },
                  )
                : _buildFallback(),
          ),

          if (isSponsored)
            Positioned(
              top: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(AppSizes.r(20)),
                ),
                child: Image.asset(
                  AssetsManager.sponsored,
                  width: AppSizes.w(40) + AppSizes.w(8) + AppSizes.w(8),
                  fit: BoxFit.contain,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFallback() {
    return Container(
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : "?",
        style: TextStyle(
          fontSize: AppSizes.sp(18),
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
