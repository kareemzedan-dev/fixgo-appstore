import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fixgo/config/routes/routes_manager.dart';
import 'package:fixgo/config/theme/app_theme.dart';
import 'package:fixgo/config/theme/theme_cubit.dart';
import 'package:fixgo/core/di/di.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/chat/presentation/manager/chat_details_cubit/chat_details_cubit.dart';
import 'package:fixgo/features/chat/presentation/manager/chats_cubit/chats_cubit.dart';
import 'package:fixgo/features/favorite/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'package:fixgo/features/notifications/presentation/manager/notifications_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/add_service_cubit/add_service_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/offers_cubit/offers_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/provider_cubit/provider_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/search_cubit/search_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/update_offer_cubit/update_offer_cubit.dart';
import 'package:fixgo/features/stories/presentation/manager/stories_cubit/stories_cubit.dart';
import 'core/session/app_session_cubit.dart';
import 'core/session/locale_cubit.dart';
import 'features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'firebase_options.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:fixgo/l10n/app_localizations.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setUrlStrategy(const HashUrlStrategy());

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (!kIsWeb) {
    await FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    // providerAndroid: ,
    // providerApple: AppleDeviceCheckProvider(),
    appleProvider: AppleProvider.appAttest,
  );
  configureDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AppSessionCubit>()..loadUser()),

        BlocProvider(create: (_) => getIt<SearchCubit>()),

        BlocProvider(create: (_) => getIt<AuthCubit>()),

        BlocProvider(create: (_) => getIt<StoriesCubit>()),

        BlocProvider(create: (_) => getIt<UpdateOfferCubit>()),

        BlocProvider(create: (_) => getIt<FavoriteCubit>()..init()),

        BlocProvider(create: (_) => ThemeCubit()),

        BlocProvider(create: (_) => LocaleCubit()),

        BlocProvider(create: (_) => getIt<OffersCubit>()..init()),

        BlocProvider(create: (_) => getIt<AddServiceCubit>()),

        BlocProvider(create: (_) => getIt<ChatsCubit>()..getChats()),

        BlocProvider(create: (_) => getIt<ChatDetailsCubit>()),

        BlocProvider(create: (_) => getIt<NotificationsCubit>()),

        BlocProvider(create: (_) => getIt<ProviderCubit>()),
      ],

      child: const MyApp(),
    ),
  );
}

Future<void> saveFcmToken() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) return;

  final token = await FirebaseMessaging.instance.getToken();

  if (token != null) {
    await FirebaseFirestore.instance.collection("users").doc(user.uid).update({
      "fcmToken": token,
    });

    debugPrint("FCM TOKEN SAVED: $token");
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    if (!kIsWeb) {
      FirebaseMessaging.onMessage.listen((message) {
        debugPrint("📩 notification");
      });

      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        final otherUserId = message.data["otherUserId"];

        if (otherUserId != null) {
          AppRouter.router.push("/chat-details", extra: otherUserId);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppSizes.init(context);

    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Fixgo',
              locale: locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              routerConfig: AppRouter.router,
            );
          },
        );
      },
    );
  }
}
