import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/core/session/app_session_state.dart';
import 'package:fixgo/features/auth/presentation/views/choose_role_view.dart';
import 'package:fixgo/features/auth/presentation/views/confirm_location_view.dart';
import 'package:fixgo/features/auth/presentation/views/create_new_password_view.dart';
import 'package:fixgo/features/auth/presentation/views/forgot_password_view.dart';
import 'package:fixgo/features/auth/presentation/views/location_permission_view.dart';
import 'package:fixgo/features/auth/presentation/views/login_view.dart';
import 'package:fixgo/features/auth/presentation/views/otp_view.dart';
import 'package:fixgo/features/auth/presentation/views/register_view.dart';
import 'package:fixgo/features/chat/presentation/views/chat_details_view.dart';
import 'package:fixgo/features/chat/presentation/widgets/following_users_view.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/views/account_benefits_view.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/views/edit_profile_view.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/views/faq_view.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/views/following_view.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/views/my_services_view.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/views/privacy_view.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/models/service_model.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/views/search_results_view.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/views/search_view.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/filter_view.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/views/all_services_view.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/views/boost_views_screen.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/views/edit_service_view.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/views/more_services_view.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/views/provider_profile_view.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/views/ratings_and_reviews_view.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/views/service_category_details_view.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/views/service_details_view.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/views/services_by_category_view.dart';
import 'package:fixgo/features/notifications/presentation/views/notifications_view.dart';
import 'package:fixgo/features/offers/domain/entities/offer_entity.dart';
import 'package:fixgo/features/splash/presentation/views/splash_view.dart';
import 'package:fixgo/features/verification/presentation/views/verification_view.dart';

import '../../features/chat/presentation/views/chats_view.dart'
    hide ChatDetailsView;
import '../../features/home/presentation/views/home_view.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: "/",

    routes: [
      /// =========================
      /// Splash & Auth
      /// =========================
      GoRoute(path: "/", builder: (_, __) => const SplashView()),
      GoRoute(path: "/onboarding", builder: (_, __) => const OnboardingView()),
      GoRoute(path: "/login", builder: (_, __) => const LoginView()),
      GoRoute(
        path: "/forgot_password",
        builder: (_, __) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: "/forgot_password_otp",
        builder: (context, state) {
          final phone = state.extra as String;

          return ForgotPasswordOtpView(phone: phone);
        },
      ),

      GoRoute(
        path: "/create_new_password",
        builder: (context, state) {
          final phone = state.extra as String;

          return CreateNewPasswordView(phone: phone);
        },
      ),
      GoRoute(
        path: "/register",
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?;
          return RegisterView(isWorker: data?["isWorker"] ?? false);
        },
      ),

      // GoRoute(
      //   path: "/otp",
      //   builder: (context, state) {
      //     final data = state.extra as Map<String, dynamic>;

      //     return OtpView(

      //     );
      //   },
      // ),
      GoRoute(
        path: "/role_selection",
        builder: (_, __) => const ChooseRoleView(),
      ),

      /// =========================
      /// Home Tabs (FIXED)
      /// =========================
      GoRoute(
        path: "/home/:tab",
        builder: (context, state) {
          final tab = state.pathParameters["tab"];

          int index = 0;

          switch (tab) {
            case "favorite":
              index = 1;
              break;
            case "services":
              index = 2;
              break;
            case "account":
              index = 3;
              break;
          }

          return HomeView(initialIndex: index);
        },
      ),

      /// =========================
      /// Services (FIXED WEB)
      /// =========================
      GoRoute(
        path: "/service-category-details/:category",
        builder: (context, state) {
          final category = state.pathParameters["category"]!;

          return ServiceCategoryDetailsView(category: category);
        },
      ),

      GoRoute(
        path: "/service-details/:offerId/:userId",
        builder: (context, state) {
          final offerId = state.pathParameters["offerId"]!;
          final userId = state.pathParameters["userId"]!;

          return ServiceDetailsView(offerId: offerId, userId: userId);
        },
      ),

      GoRoute(
        path: "/ratings-and-reviews/:offerId",
        builder: (context, state) {
          final offerId = state.pathParameters["offerId"]!;
          return RatingsAndReviewsView(offerId: offerId);
        },
      ),

      GoRoute(
        path: "/provider-profile/:userId",
        builder: (context, state) {
          final userId = state.pathParameters["userId"]!;

          return ProviderProfileView(userId: userId);
        },
      ),
      GoRoute(
        path: "/services-by-category/:category",
        builder: (context, state) {
          final category = Uri.decodeComponent(
            state.pathParameters["category"]!,
          );

          return ServicesByCategoryView(serviceCategory: category);
        },
      ),
      GoRoute(
        path: "/more-services/:type",
        builder: (context, state) {
          final type = state.pathParameters["type"]!;

          return MoreServicesView(type: type);
        },
      ),
      GoRoute(
        path: "/all-services/:type",
        builder: (context, state) {
          final type = state.pathParameters["type"]!;
          final data = state.extra as Map<String, dynamic>?;
          final isNear = data?["isNear"] ?? false;

          return AllServicesView(
            isnear: isNear,
            title: data?["title"] ?? "",
            offers: data?["offers"] ?? [],
            type: type,
          );
        },
      ),

      GoRoute(
        path: "/edit-service",
        builder: (context, state) {
          final offer = state.extra as OfferEntity;
          return EditServiceView(offer: offer);
        },
      ),

      GoRoute(
        path: "/offer/boost/:offerId",
        builder: (context, state) {
          final offerId = state.pathParameters["offerId"]!;
          return BoostViewsScreen(offerId: offerId);
        },
      ),

      /// =========================
      /// Chat (FIXED)
      /// =========================
      GoRoute(path: "/chats", builder: (_, __) => const ChatsView()),

      GoRoute(
        path: "/chat-details/:userId",
        builder: (context, state) {
          final userId = state.pathParameters["userId"]!;
          return ChatDetailsView(otherUserId: userId);
        },
      ),

      GoRoute(
        path: "/following_users",
        builder: (_, __) => const FollowingUsersView(),
      ),

      GoRoute(path: "/following", builder: (_, __) => const FollowingView()),

      /// =========================
      /// Account
      /// =========================
      GoRoute(path: "/my-services", builder: (_, __) => const MyServicesView()),

      GoRoute(
        path: "/edit-profile",
        builder: (_, __) => const EditProfileView(),
      ),

      GoRoute(
        path: "/account/benefits",
        builder: (_, __) => const AccountBenefitsPage(),
      ),

      GoRoute(path: "/privacy", builder: (_, __) => const PrivacyView()),

      GoRoute(path: "/faq", builder: (_, __) => const FaqView()),

      GoRoute(
        path: "/account/verification",
        builder: (_, __) => const VerificationView(),
      ),

      /// =========================
      /// Location
      /// =========================
      GoRoute(
        path: "/location-permission",
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return LocationPermissionView(type: data["type"]);
        },
      ),

      GoRoute(
        path: "/confirm-location",
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;

          return ConfirmLocationView(
            type: data["type"],
            latitude: data["latitude"],
            longitude: data["longitude"],
          );
        },
      ),

      /// =========================
      /// Search
      /// =========================
      GoRoute(path: "/search", builder: (_, __) => const SearchView()),

      GoRoute(
        path: "/search-results/:query",
        builder: (context, state) {
          final query = state.pathParameters["query"]!;

          return SearchResultsView(query: query);
        },
      ),
      GoRoute(path: "/filter", builder: (_, __) => const FilterView()),

      /// =========================
      /// Notifications
      /// =========================
      GoRoute(
        path: "/notifications",
        builder: (context, state) {
          final sessionState = context.read<AppSessionCubit>().state;

          if (sessionState is AppSessionAuthenticated) {
            return NotificationsView(userId: sessionState.user.uid);
          }

          return const Scaffold(body: Center(child: Text("غير مسجل")));
        },
      ),
    ],
  );
}
