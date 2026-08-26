import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class ProviderCardDetails extends StatelessWidget {
  final dynamic offer;
  final bool isOwner;
  final bool isFollowing;
  final bool isDark;
  final VoidCallback onFollow;

  const ProviderCardDetails({
    super.key,
    required this.offer,
    required this.isOwner,
    required this.isFollowing,
    required this.isDark,
    required this.onFollow,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                offer.userName ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: AppSizes.sp(14),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(width: AppSizes.w(6)),
            if (offer.isVerified)
              Image.asset(
                AssetsManager.verified,
                width: AppSizes.w(16),
                height: AppSizes.h(16),
              ),
            if (!isOwner) ...[
              const SizedBox(width: 8),
              Row(
                children: [
                  Image.asset(
                    AssetsManager.experience,
                    height: AppSizes.w(14),
                    width: AppSizes.w(14),
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    AppLocalizations.of(
                      context,
                    ).yearValue(offer.yearsOfExperience),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : ColorsManager.darkGrey,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
        SizedBox(height: AppSizes.h(8)),
        if (isOwner)
          Row(
            children: [
              Flexible(
                child: Text(
                  offer.category ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ColorsManager.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: AppSizes.sp(12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(
                offer.averageRating.toString(),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          )
        else ...[
          Row(
            children: [
              Flexible(
                child: Text(
                  offer.category ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ColorsManager.secondaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: AppSizes.sp(10),
                  ),
                ),
              ),
              SizedBox(width: AppSizes.w(6)),
              Icon(Icons.star, color: Colors.amber, size: AppSizes.w(18)),
              SizedBox(width: AppSizes.w(4)),
              Text(offer.averageRating.toStringAsFixed(1)),
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      AssetsManager.distance,
                      height: AppSizes.w(14),
                      width: AppSizes.w(14),
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        offer.location ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isDark ? Colors.white : ColorsManager.darkGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.h(8)),
          GestureDetector(
            onTap: onFollow,
            child: Container(
              width: AppSizes.w(120),
              height: AppSizes.h(28),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.r16),
                border: Border.all(
                  color: isFollowing ? Colors.green : const Color(0xFF1D3964),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isFollowing
                      ? const Icon(Icons.check, size: 12, color: Colors.green)
                      : Image.asset(
                          AssetsManager.personAddAlt,
                          width: 12,
                          height: 12,
                        ),
                  const SizedBox(width: 4),
                  Text(
                    isFollowing
                        ? AppLocalizations.of(context).following
                        : AppLocalizations.of(context).follow,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class ProviderOwnerExperience extends StatelessWidget {
  final dynamic offer;

  const ProviderOwnerExperience({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              AssetsManager.experience,
              height: AppSizes.w(14),
              width: AppSizes.w(14),
            ),
            const SizedBox(width: 4),
            Text(
              AppLocalizations.of(context).yearValue(offer.yearsOfExperience),
            ),
          ],
        ),
        Text(
          AppLocalizations.of(context).practicalExperience,
          style: TextStyle(color: ColorsManager.darkGrey),
        ),
      ],
    );
  }
}
