import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/reviews/domain/entities/review_entity.dart';
import 'package:fixgo/core/utils/colors_manager.dart';

class ServiceDetailsReviewItem extends StatelessWidget {
  final ReviewEntity review;

  const ServiceDetailsReviewItem({Key? key, required this.review})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSizes.p16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEAEAEA))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review.userName,
                style: TextStyle(
                  fontSize: AppSizes.sp(16),
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${review.createdAt.day}/${review.createdAt.month}/${review.createdAt.year}",
                style: TextStyle(color: Colors.grey, fontSize: AppSizes.sp(13)),
              ),
            ],
          ),
          SizedBox(height: AppSizes.h(8)),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star,
                color: index < (review.rating ?? 0).round()
                    ? Colors.amber
                    : Colors.grey.shade300,
                size: AppSizes.w(18),
              ),
            ),
          ),
          SizedBox(height: AppSizes.h(10)),
          Text(
            review.content,
            style: TextStyle(
              color: ColorsManager.darkGrey,
              fontSize: AppSizes.sp(13),
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}
