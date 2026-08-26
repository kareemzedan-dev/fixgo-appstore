import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:shimmer/shimmer.dart';

class WorkerCardShimmer extends StatelessWidget {
  final bool isHorizontal;

  const WorkerCardShimmer({super.key, this.isHorizontal = false});

  Widget _shimmerBox({
    required double height,
    required double width,
    double radius = 8,
    ShapeBorder? shape,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: shape != null
          ? ShapeDecoration(color: Colors.white, shape: shape)
          : BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: AppSizes.h(150),
          padding: EdgeInsets.all(AppSizes.w(12)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              /// =========================
              /// IMAGE
              /// =========================
              _shimmerBox(
                height: AppSizes.h(150),
                width: AppSizes.w(95),
                radius: 16,
              ),

              SizedBox(width: AppSizes.w(12)),

              /// =========================
              /// CONTENT
              /// =========================
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// =========================
                    /// NAME + RIGHT INFO
                    /// =========================
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// left section
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// name
                              _shimmerBox(
                                height: AppSizes.h(14),
                                width: AppSizes.w(110),
                              ),

                              SizedBox(height: AppSizes.h(8)),

                              /// job + rating
                              Row(
                                children: [
                                  _shimmerBox(
                                    height: AppSizes.h(12),
                                    width: AppSizes.w(60),
                                  ),

                                  SizedBox(width: AppSizes.w(8)),

                                  _shimmerBox(
                                    height: 14,
                                    width: 14,
                                    shape: const CircleBorder(),
                                  ),

                                  SizedBox(width: AppSizes.w(4)),

                                  _shimmerBox(
                                    height: AppSizes.h(12),
                                    width: AppSizes.w(30),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: AppSizes.w(12)),

                        /// right section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                _shimmerBox(
                                  height: 14,
                                  width: 14,
                                  shape: const CircleBorder(),
                                ),
                                SizedBox(width: AppSizes.w(4)),
                                _shimmerBox(
                                  height: AppSizes.h(11),
                                  width: AppSizes.w(45),
                                ),
                              ],
                            ),

                            SizedBox(height: AppSizes.h(8)),

                            Row(
                              children: [
                                _shimmerBox(
                                  height: 14,
                                  width: 14,
                                  shape: const CircleBorder(),
                                ),
                                SizedBox(width: AppSizes.w(4)),
                                _shimmerBox(
                                  height: AppSizes.h(11),
                                  width: AppSizes.w(45),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: AppSizes.h(12)),

                    /// =========================
                    /// DESCRIPTION
                    /// =========================
                    _shimmerBox(height: AppSizes.h(10), width: double.infinity),

                    SizedBox(height: AppSizes.h(8)),

                    _shimmerBox(height: AppSizes.h(10), width: AppSizes.w(160)),

                    const Spacer(),

                    /// =========================
                    /// BOTTOM ICONS
                    /// =========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        3,
                        (_) => _shimmerBox(
                          height: 18,
                          width: 18,
                          shape: const CircleBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
