//==========================
// 2. service_details_header.dart
//==========================
import 'package:flutter/material.dart';
import 'package:fixgo/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/features/chat/presentation/widgets/custom_chat_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/features/offers/presentation/manager/offer_details_cubit/offer_details_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/offers_cubit/offers_cubit.dart';

class ServiceDetailsHeader extends StatelessWidget {
  final dynamic offer;
  const ServiceDetailsHeader({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    final isUserOwner =
        offer.userId == context.watch<AppSessionCubit>().currentUser?.uid;
    return isUserOwner
        ? CustomChatHeader(
            title: AppLocalizations.of(context).serviceDetails,
            showEditButton: true,
            onEdit: () async {
              final result = await context.push("/edit-service", extra: offer);
              if (!context.mounted) return;
              if (result == true) {
                context.read<OfferDetailsCubit>().getOfferDetails(offer.id);
                context.read<OffersCubit>().init();
              }
            },
          )
        : CustomChatHeader(
            title: AppLocalizations.of(context).serviceDetails,
            showEditButton: false,
          );
  }
}
