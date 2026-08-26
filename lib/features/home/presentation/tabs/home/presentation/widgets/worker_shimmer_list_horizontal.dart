import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

import 'worker_card_shimmer.dart';

class WorkerShimmerListHorizontal extends StatelessWidget {
  const WorkerShimmerListHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.h(160),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (_, __) => SizedBox(
          width: AppSizes.w(320),
          child: const WorkerCardShimmer(isHorizontal: true),
        ),
        separatorBuilder: (_, __) => SizedBox(width: AppSizes.w(8)),
      ),
    );
  }
}
