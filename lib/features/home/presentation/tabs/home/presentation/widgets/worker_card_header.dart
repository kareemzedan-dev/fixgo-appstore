import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/worker_card_attributes.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/worker_card_main_info.dart';

class WorkerCardHeader extends StatelessWidget {
  final String name;
  final String job;
  final double rating;
  final String experience;
  final String distance;
  final bool showDistance;
  final bool isMyService;

  const WorkerCardHeader({
    super.key,
    required this.name,
    required this.job,
    required this.rating,
    required this.experience,
    required this.distance,
    this.isMyService = false,
    this.showDistance = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: WorkerCardMainInfo(
            name: name,
            job: job,
            rating: rating,
            isMyService: isMyService,
            experience: experience,
          ),
        ),
        SizedBox(width: AppSizes.w(8)),
        if (!isMyService)
          WorkerCardAttributes(
            showDistance: showDistance,
            experience: experience,
            distance: distance,
          ),
      ],
    );
  }
}
