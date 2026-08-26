import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fixgo/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/components/custom_top_message.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/core/session/app_session_state.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/features/favorite/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/offers_cubit/offers_cubit.dart';

class WorkerCardActions extends StatelessWidget {
  final String offerId;
  final String userId;

  const WorkerCardActions({
    super.key,
    required this.offerId,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final offersCubit = context.watch<OffersCubit>();
    final sessionState = context.watch<AppSessionCubit>().state;

    final isGuest = sessionState is! AppSessionAuthenticated;
    final isFollowing = offersCubit.state.followingIds.contains(userId);
    void _handleGuest(BuildContext context) {
      CustomTopMessage.show(
        context,
        message: AppLocalizations.of(context).loginRequiredFirst,
        type: MessageType.warning,
      );
    }

    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        /// =========================
        /// FOLLOW (أيقونة فقط)
        /// =========================
        GestureDetector(
          onTap: () {
            if (isGuest) {
              _handleGuest(context);
              return;
            }

            context.read<OffersCubit>().toggleFollow(userId);
          },
          child: isFollowing
              ? Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: AppSizes.w(18),
                )
              : Image.asset(
                  AssetsManager.personAddAlt,
                  height: AppSizes.w(16),
                  width: AppSizes.w(16),
                  fit: BoxFit.contain,
                  color: isDark ? Colors.white : Colors.black,
                ),
        ),

        /// =========================
        /// CHAT
        /// =========================
        GestureDetector(
          onTap: () {
            if (isGuest) {
              _handleGuest(context);
              return;
            }

            if (kIsWeb) {
              context.go("${'/chat-details'}/$userId");
            } else {
              context.push("${'/chat-details'}/$userId");
            }
          },
          child: Image.asset(
            AssetsManager.chatBubbleOutline,
            height: AppSizes.w(16),
            width: AppSizes.w(16),
            fit: BoxFit.contain,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),

        /// =========================
        /// FAVORITE
        /// =========================
        GestureDetector(
          onTap: () {
            if (isGuest) {
              _handleGuest(context);
              return;
            }

            context.read<FavoriteCubit>().toggleFavorite(offerId);
          },
          child: Icon(
            context.watch<FavoriteCubit>().isFavorite(offerId)
                ? Icons.favorite
                : Icons.favorite_border,
            color: Colors.red,
            size: AppSizes.w(20),
          ),
        ),
      ],
    );
  }
}
