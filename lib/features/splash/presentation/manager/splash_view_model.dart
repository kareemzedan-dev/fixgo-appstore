// import 'package:flutter/foundation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:injectable/injectable.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
//
//
// @injectable
// class SplashViewModel extends Cubit<SplashViewModelStates> {
//
//   SplashViewModel( )
//     : super(SplashInitial());
//
//   Future<void> start() async {
//     await Future.delayed(const Duration(seconds: 2));
//
//     if (!kIsWeb) {
//       final skipped = SharedPrefHelper.getBool('onboarding_skipped') ?? false;
//
//       if (!skipped) {
//         emit(SplashGoToOnboarding());
//         return;
//       }
//     }
//
//     final auth = Supabase.instance.client.auth;
//     final session = auth.currentSession;
//     if (session == null) {
//       if (kIsWeb) {
//         emit(SplashGoToCustomerHome());
//       } else {
//         emit(SplashGoToLogin());
//       }
//       return;
//     }
//
//     try {
//       await auth.refreshSession();
//     } catch (_) {
//       emit(SplashGoToLogin());
//       return;
//     }
//
//     final accessToken = auth.currentSession?.accessToken;
//     if (accessToken == null) {
//       emit(SplashGoToLogin());
//       return;
//     }
//
//     final result = await getCurrentUserUseCase.getCurrentUser(
//       accessToken: accessToken,
//     );
//
//     result.fold(
//       (failure) {
//         if (failure is NetworkFailure) {
//           emit(SplashGoToCustomerHome());
//         } else {
//           emit(SplashGoToLogin());
//         }
//       },
//       (profile) {
//         getIt<AppUserCubit>().setUser(profile);
//
//         if (profile.role == UserRole.customer.name) {
//           emit(SplashGoToCustomerHome());
//         } else if (profile.role == UserRole.technician.name) {
//           emit(SplashGoToTechnicianHome());
//         } else {
//           emit(SplashGoToLogin());
//         }
//       },
//     );
//   }
// }
