import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/components/custom_top_error_message.dart';
import 'package:fixgo/core/components/custom_top_message.dart';
import 'package:fixgo/core/services/phone_service.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/core/session/app_session_state.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/contact_actions_section.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/provider_profile_card.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/provider_profile_header.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/provider_services_section.dart';
import 'package:fixgo/features/offers/presentation/manager/offers_cubit/offers_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/provider_cubit/provider_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/provider_cubit/provider_states.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class ProviderProfileView extends StatefulWidget {
  final String userId;

  const ProviderProfileView({super.key, required this.userId});

  @override
  State<ProviderProfileView> createState() => _ProviderProfileViewState();
}

class _ProviderProfileViewState extends State<ProviderProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<ProviderCubit>().getProviderData(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final sessionState = context.watch<AppSessionCubit>().state;
    final isGuest = sessionState is! AppSessionAuthenticated;
    final myId = isGuest ? null : sessionState.user.uid;

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProviderCubit, ProviderState>(
          builder: (context, state) {
            final provider = state.provider;
            if (provider == null) {
              return const Center(child: CircularProgressIndicator());
            }

            final isFollowing =
                (provider["following"] as List?)?.contains(myId) ?? false;
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(height: AppSizes.h(20)),
                  ProviderProfileHeader(
                    title: provider["name"] ?? "",
                    isFollowing: isFollowing,
                    onFollow: () {
                      if (isGuest) {
                        _handleGuest(context);
                        return;
                      }
                      context.read<OffersCubit>().toggleFollow(provider["id"]);
                    },
                  ),
                  ProviderProfileCard(provider: provider),
                  ProviderServicesSection(
                    services: state.services,
                    yearsOfExperience: provider["yearsOfExperience"] ?? 0,
                    onServiceTap: (service) {
                      final route =
                          "/service-details/${service.id}/${service.userId}";
                      if (kIsWeb) {
                        context.go(route);
                      } else {
                        context.push(route);
                      }
                    },
                  ),
                  ContactActionsSection(
                    onCall: () => PhoneService.makeCall(provider["phone"]),
                    onChat: () => _openChat(context, provider, isGuest),
                    onWhatsapp: () =>
                        PhoneService.openWhatsApp(provider["phone"]),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _openChat(BuildContext context, Map provider, bool isGuest) {
    if (isGuest) {
      _handleGuest(context);
      return;
    }

    final currentUserId = context.read<AppSessionCubit>().currentUser?.uid;
    final userId = provider["id"];
    if (userId == null || userId.toString().isEmpty) {
      debugPrint("❌ userId فاضي");
      return;
    }
    if (userId == currentUserId) {
      CustomTopErrorMessage.show(
        context,
        message: AppLocalizations.of(context).cannotChatWithSelf,
      );
      return;
    }
    context.push("${'/chat-details'}/$userId");
  }

  void _handleGuest(BuildContext context) {
    CustomTopMessage.show(
      context,
      message: AppLocalizations.of(context).loginRequiredFirst,
      type: MessageType.warning,
    );
  }
}
