import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/components/custom_top_message.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/core/session/app_session_state.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/provider_card_details.dart';
import 'package:fixgo/features/offers/presentation/manager/offers_cubit/offers_cubit.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class ServiceDetailsProviderCard extends StatelessWidget {
  final dynamic offer;

  const ServiceDetailsProviderCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    final offersCubit = context.watch<OffersCubit>();
    final appSessionCubit = context.watch<AppSessionCubit>();
    final isOwner = offer.userId == appSessionCubit.currentUser?.uid;
    final isFollowing = offersCubit.state.followingIds.contains(offer.userId);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isGuest = appSessionCubit.state is! AppSessionAuthenticated;

    return InkWell(
      onTap: () {
        final path = "/provider-profile/${offer.userId}";
        if (kIsWeb) {
          context.go(path);
        } else {
          context.push(path);
        }
      },
      child: Container(
        padding: EdgeInsets.all(AppSizes.w(14)),
        decoration: BoxDecoration(
          color: isDark ? const Color(0Xff1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.r(18)),
          border: Border.all(
            color: isDark ? const Color(0Xff1E1E1E) : const Color(0xFFE5E5E5),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(radius: AppSizes.r(40)),
            SizedBox(width: AppSizes.w(12)),
            Expanded(
              child: ProviderCardDetails(
                offer: offer,
                isOwner: isOwner,
                isFollowing: isFollowing,
                isDark: isDark,
                onFollow: () async {
                  if (isGuest) {
                    _handleGuest(context);
                  } else {
                    await context.read<OffersCubit>().toggleFollow(
                      offer.userId,
                    );
                  }
                },
              ),
            ),
            SizedBox(width: AppSizes.w(16)),
            if (isOwner) ProviderOwnerExperience(offer: offer),
            SizedBox(width: AppSizes.w(12)),
            Icon(Icons.arrow_forward_ios_outlined, size: AppSizes.w(18)),
          ],
        ),
      ),
    );
  }

  void _handleGuest(BuildContext context) {
    CustomTopMessage.show(
      context,
      message: AppLocalizations.of(context).loginRequiredFirst,
      type: MessageType.warning,
    );
  }
}
