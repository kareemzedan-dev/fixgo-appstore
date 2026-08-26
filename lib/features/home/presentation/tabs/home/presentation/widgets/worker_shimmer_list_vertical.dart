import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

import 'worker_card_shimmer.dart';

class WorkerShimmerListVertical extends StatelessWidget {
  const WorkerShimmerListVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 6,
      itemBuilder: (_, __) => const WorkerCardShimmer(),
      separatorBuilder: (_, __) => SizedBox(height: AppSizes.p16),
    );
  }
}
