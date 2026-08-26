import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

class ServiceItem extends StatelessWidget {
  final String title;
  final String image;
  final String? categoryId;

  const ServiceItem({
    super.key,
    required this.title,
    required this.image,
    this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        /// نرسل اسم الخدمة نفسها
        /// مثل: سباكة / نجارة / كهرباء

        final category = Uri.encodeComponent(categoryId ?? title);

        if (kIsWeb) {
          context.go("/service-category-details/$category");
        } else {
          context.push("/service-category-details/$category");
        }
      },

      borderRadius: BorderRadius.circular(16),

      child: Container(
        width: AppSizes.w(85),

        margin: const EdgeInsets.symmetric(horizontal: 6),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),

          border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset(image, height: AppSizes.h(70), width: AppSizes.w(70)),

            const SizedBox(height: 8),

            Text(
              title,
              style: TextStyle(
                fontSize: AppSizes.sp(12),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
