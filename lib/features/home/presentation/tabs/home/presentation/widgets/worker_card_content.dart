import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/worker_card_actions.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/worker_card_header.dart';

class WorkerCardContent extends StatelessWidget {
  final String name;
  final String job;
  final double rating;
  final String experience;
  final String distance;
  final String description;
  final bool showOnlyChat;
  final String offerId;
  final String userId;
  final bool isMyService;
  final bool showDistance;

  const WorkerCardContent({
    super.key,
    required this.name,
    required this.job,
    required this.rating,
    required this.experience,
    required this.distance,
    required this.description,
    required this.showOnlyChat,
    required this.offerId,
    required this.userId,
    this.isMyService = false,
    this.showDistance = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WorkerCardHeader(
          name: name,
          job: job,
          rating: rating,
          experience: experience,
          distance: distance,
          isMyService: isMyService,
          showDistance: showDistance,
        ),
        SizedBox(height: AppSizes.h(8)),
        Text(
          description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: AppSizes.sp(10),
            fontWeight: FontWeight.w500,
          ),
        ),

        if (!showOnlyChat) ...[
          SizedBox(height: AppSizes.h(16)),
          WorkerCardActions(offerId: offerId, userId: userId),
        ],
        SizedBox(height: AppSizes.h(8)),
      ],
    );
  }
}
