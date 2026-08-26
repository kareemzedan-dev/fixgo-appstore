// service_details_shimmer.dart

import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:shimmer/shimmer.dart';

class ServiceDetailsShimmer extends StatelessWidget {
  const ServiceDetailsShimmer({super.key});

  Widget _box({
    required double height,
    required double width,
    double radius = 12,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  Widget _circle({required double size}) {
    return Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// header
            _box(height: 20, width: 160),

            SizedBox(height: AppSizes.h(24)),

            /// provider title
            _box(height: 16, width: 120),

            SizedBox(height: AppSizes.h(16)),

            /// provider card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  _circle(size: 80),

                  SizedBox(width: AppSizes.w(12)),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _box(height: 14, width: 120),

                        SizedBox(height: AppSizes.h(10)),

                        _box(height: 12, width: 90),

                        SizedBox(height: AppSizes.h(12)),

                        _box(height: 28, width: 110, radius: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSizes.h(28)),

            /// description title
            _box(height: 16, width: 160),

            SizedBox(height: AppSizes.h(14)),

            _box(height: 12, width: double.infinity),

            SizedBox(height: AppSizes.h(10)),

            _box(height: 12, width: 250),

            SizedBox(height: AppSizes.h(28)),

            /// work areas
            _box(height: 16, width: 120),

            SizedBox(height: AppSizes.h(14)),

            _box(height: 36, width: 100, radius: 18),

            SizedBox(height: AppSizes.h(28)),

            /// gallery
            _box(height: 16, width: 140),

            SizedBox(height: AppSizes.h(14)),

            Row(
              children: List.generate(
                3,
                (_) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: _box(
                      height: 100,
                      width: double.infinity,
                      radius: 16,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: AppSizes.h(28)),

            /// reviews
            _box(height: 16, width: 150),

            SizedBox(height: AppSizes.h(20)),

            Column(
              children: List.generate(
                3,
                (_) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _box(height: 14, width: 120),
                      SizedBox(height: AppSizes.h(10)),
                      _box(height: 12, width: double.infinity),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: AppSizes.h(28)),

            /// similar services
            _box(height: 16, width: 150),

            SizedBox(height: AppSizes.h(16)),

            SizedBox(
              height: AppSizes.h(160),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                separatorBuilder: (_, __) => SizedBox(width: AppSizes.w(12)),
                itemBuilder: (_, __) => Container(
                  width: AppSizes.w(300),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      _box(height: 120, width: 90, radius: 14),
                      SizedBox(width: AppSizes.w(12)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _box(height: 14, width: 100),
                            SizedBox(height: AppSizes.h(10)),
                            _box(height: 12, width: 80),
                            SizedBox(height: AppSizes.h(10)),
                            _box(height: 12, width: 130),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: AppSizes.h(28)),

            _box(height: 54, width: double.infinity, radius: 18),
          ],
        ),
      ),
    );
  }
}
