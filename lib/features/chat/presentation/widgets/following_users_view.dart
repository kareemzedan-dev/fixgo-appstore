import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/features/chat/presentation/widgets/custom_chat_header.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/worker_card.dart';
import 'package:fixgo/features/offers/presentation/manager/offers_cubit/offers_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/offers_cubit/offers_state.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class FollowingUsersView extends StatefulWidget {
  const FollowingUsersView({super.key});

  @override
  State<FollowingUsersView> createState() => _FollowingUsersViewState();
}

class _FollowingUsersViewState extends State<FollowingUsersView> {
  @override
  void initState() {
    super.initState();

    /// ✅ الصح: نجيب المستخدمين مش الخدمات
    context.read<OffersCubit>().getFollowingUsersData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            CustomChatHeader(
              title: AppLocalizations.of(context).peopleYouFollow,
              showEditButton: false,
              onBack: () {
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: 24),

            Expanded(
              child: BlocBuilder<OffersCubit, OffersState>(
                builder: (context, state) {
                  final users = state.followingUsers;

                  /// =========================
                  /// EMPTY STATE
                  /// =========================
                  if (users.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context).noFollowingUsers,
                      ),
                    );
                  }

                  /// =========================
                  /// LIST
                  /// =========================
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: users.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final user = users[index];

                      return WorkerCard(
                        onTap: () {
                          if (kIsWeb) {
                            context.go("/provider-profile/${user.uid}");
                          } else {
                            context.push("/provider-profile/${user.uid}");
                          }
                        },
                        userId: user.uid,
                        name: user.name,
                        job: user.profession,
                        description: "",
                        image: user.imageUrl ?? "",
                        rating: 0,
                        experience: "${user.yearsOfExperience}",
                        distance: "",
                        showDistance: false,
                        showOnlyChat: true,

                        offerId: "",
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
