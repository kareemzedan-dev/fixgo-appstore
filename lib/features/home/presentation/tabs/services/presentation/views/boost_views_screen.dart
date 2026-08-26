import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/components/custom_app_bar.dart';
import 'package:fixgo/core/di/di.dart';
import 'package:fixgo/core/services/contact_launcher_service.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/boost_active_package_view.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/boost_packages_view.dart';
import 'package:fixgo/features/offers/presentation/manager/boost_offer_cubit/boost_offer_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/boost_offer_cubit/boost_offer_state.dart';
import 'package:fixgo/features/view_packages/presentation/manager/get_all_boost_package_view_model/get_all_boost_package_view_model.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class BoostViewsScreen extends StatelessWidget {
  final String offerId;

  const BoostViewsScreen({super.key, required this.offerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BoostOfferCubit>()..watch(offerId),
      child: BlocBuilder<BoostOfferCubit, BoostOfferState>(
        builder: (context, state) {
          if (state is! BoostOfferLoaded) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final status = state.status;
          return Scaffold(
            appBar: CustomAppBar(
              title: AppLocalizations.of(context).managePackages,
            ),
            body: status.isViewSponsored
                ? BoostActivePackageView(
                    remainingViews: status.remainingViews,
                    totalViews: status.totalViews,
                    viewsExpireAt: status.viewsExpireAt,
                  )
                : BlocProvider(
                    create: (_) =>
                        getIt<GetAllBoostPackageViewModel>()
                          ..getBoostPackages(),
                    child: BoostPackagesView(
                      onSubscribe: (title) {
                        ContactLauncherService.openWhatsApp(
                          phone: "+201068331194",
                          message: AppLocalizations.of(
                            context,
                          ).whatsappSubscribeMessage(title),
                        );
                      },
                    ),
                  ),
          );
        },
      ),
    );
  }
}
