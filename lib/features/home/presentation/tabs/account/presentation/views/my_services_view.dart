import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/features/chat/presentation/widgets/custom_chat_header.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/worker_card.dart';
import 'package:fixgo/features/offers/presentation/manager/offers_cubit/offers_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/offers_cubit/offers_state.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class MyServicesView extends StatefulWidget {
  const MyServicesView({super.key});

  @override
  State<MyServicesView> createState() => _MyServicesViewState();
}

class _MyServicesViewState extends State<MyServicesView> {
  @override
  void initState() {
    super.initState();

    /// 👇 تحميل خدماتي
    context.read<OffersCubit>().getMyServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            /// Header
            CustomChatHeader(
              title: AppLocalizations.of(context).myServices,
              showEditButton: false,
              onBack: () {
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: 24),

            Expanded(
              child: BlocBuilder<OffersCubit, OffersState>(
                builder: (context, state) {
                  final offers = state.myServices;

                  /// 🔄 Loading
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  /// ❌ Empty
                  if (offers.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context).noServicesAddedYet,
                      ),
                    );
                  }

                  /// ✅ List
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: offers.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final offer = offers[index];

                      return WorkerCard(
                        userId: offer.userId,
                        offerId: offer.id,
                        name: offer.userName ?? "",
                        job: offer.serviceCategory ?? "",
                        description: offer.category,
                        image: offer.imageUrl,
                        rating: offer.averageRating,
                        experience: "${offer.yearsOfExperience}",
                        distance: offer.location, // مش مهم هنا
                        showOnlyChat: true,
                        isMyService: true,
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
