import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/favorite/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/worker_card_content.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/worker_card_image.dart';

class WorkerCard extends StatelessWidget {
  final String name;
  final String job;
  final String description;
  final String image;
  final double rating;
  final String experience;
  final String distance;
  final bool showDistance;

  final bool showOnlyChat;
  final String offerId;
  final String userId;
  final bool isSponsored;
  final bool isMyService;
  final VoidCallback? onTap;
  const WorkerCard({
    super.key,
    required this.name,
    required this.job,
    required this.description,
    required this.image,
    required this.rating,
    required this.experience,
    required this.distance,
    this.showDistance = true,
    this.showOnlyChat = false,
    required this.offerId,
    required this.userId,
    this.isSponsored = false,
    this.isMyService = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap:
          onTap ??
          () {
            if (kIsWeb) {
              context.go("/service-details/$offerId/$userId");
            } else {
              context.push("/service-details/$offerId/$userId");
            }
          },
      child: Card(
        elevation: 2,
        color: Colors.transparent,
        shadowColor: isDark ? const Color(0Xff151515) : Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.r(20)),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0Xff151515) : Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.r(20)),
          ),
          child: Row(
            children: [
              WorkerCardImage(
                name: name,
                showOnlyChat: showOnlyChat,
                image: image,
                isSponsored: isSponsored,
              ),

              SizedBox(width: AppSizes.w(16)),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: AppSizes.p8,
                    right: AppSizes.p8,
                    top: AppSizes.p12,
                    bottom: AppSizes.p12,
                  ),

                  child: WorkerCardContent(
                    isMyService: isMyService,
                    name: name,
                    job: job,
                    rating: rating,
                    experience: experience,
                    distance: distance,
                    description: description,
                    showOnlyChat: showOnlyChat,
                    offerId: offerId,
                    userId: userId,
                    showDistance: showDistance,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
