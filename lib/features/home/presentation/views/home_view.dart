import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/services/location_service/location_service.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/core/session/app_session_state.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/views/account_tab_view.dart';
import 'package:fixgo/features/home/presentation/tabs/favorite/presentation/views/favorite_tab_view.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/views/home_tab_view.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/custom_nav_bar.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/worker_required_bottom_sheet.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/views/services_tab_view.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/add_service_bottom_sheet.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class HomeView extends StatefulWidget {
  final int initialIndex;

  const HomeView({super.key, this.initialIndex = 0});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late int currentIndex;

  final List<Widget> pages = [
    HomeTabView(),
    FavoriteTabView(),
    ServicesTabView(),
    AccountTabView(),
  ];

  @override
  void initState() {
    super.initState();

    currentIndex = widget.initialIndex;

    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    final position = await LocationService.getCurrentLocation(context);

    if (position != null) {
      print("Latitude: ${position.latitude}");
      print("Longitude: ${position.longitude}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    final location = GoRouterState.of(context).uri.toString();

    int index = 0;

    if (location.contains("favorite")) index = 1;
    if (location.contains("services")) index = 2;
    if (location.contains("account")) index = 3;

    return Scaffold(
      body: pages[index],
      extendBody: true,

      floatingActionButton: isKeyboardOpen
          ? null
          : PhysicalModel(
              color: Colors.transparent,
              elevation: 12,
              shadowColor: Colors.black54,
              shape: BoxShape.circle,
              child: FloatingActionButton(
                mini: true,
                onPressed: () {
                  final sessionState = context.read<AppSessionCubit>().state;

                  if (sessionState is AppSessionAuthenticated) {
                    final userType = sessionState.user.type;

                    if (userType == "worker" || userType == 'company') {
                      AddServiceBottomSheet.show(context);
                    } else {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) {
                          return const WorkerRequiredBottomSheet();
                        },
                      );
                    }
                  } else {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) {
                        return const WorkerRequiredBottomSheet();
                      },
                    );
                  }
                },
                backgroundColor: const Color(0xff29466F),
                elevation: 0,
                shape: const CircleBorder(),
                child: Icon(
                  Icons.add,
                  size: AppSizes.w(24),
                  color: Colors.white,
                ),
              ),
            ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: CustomNavBar(
        currentIndex: index,
        items: [
          NavItemModel(
            icon: AssetsManager.home,
            label: AppLocalizations.of(context).home,
          ),
          NavItemModel(
            icon: AssetsManager.favorite,
            label: AppLocalizations.of(context).favoritesTitle,
          ),
          NavItemModel(
            icon: AssetsManager.services,
            label: AppLocalizations.of(context).services,
          ),
          NavItemModel(
            icon: AssetsManager.account,
            label: AppLocalizations.of(context).myAccount,
          ),
        ],
        onTap: (index) {
          final routes = ["home", "favorite", "services", "account"];

          final tab = routes[index];

          context.go("/home/$tab");
        },
        onCenterTap: () {},
      ),
    );
  }
}
