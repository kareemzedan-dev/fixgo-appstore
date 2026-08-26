/// core/session/app_session_cubit.dart
library;

import 'package:fixgo/features/auth/domain/use_cases/check_user_state_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../features/auth/data/models/user_model.dart';
import 'app_session_state.dart';
import 'session_local_data_source.dart';

@injectable
class AppSessionCubit extends Cubit<AppSessionState> {
  final SessionLocalDataSource local;
  final CheckUserStateUsecase checkUserStateUsecase;

  AppSessionCubit(this.local, this.checkUserStateUsecase)
    : super(AppSessionInitial());
  UserModel? get currentUser {
    if (state is AppSessionAuthenticated) {
      return (state as AppSessionAuthenticated).user;
    }
    return null;
  }

  /// Load user on app start
  Future<void> loadUser() async {
    emit(AppSessionLoading());

    try {
      final user = await local.getUser();

      if (user != null) {
        if (await checkUserStateUsecase.call(user.uid)) {
          await logout();
          emit(AppSessionUnauthenticated());
        } else {
          emit(AppSessionAuthenticated(user));
        }
      } else {
        emit(AppSessionUnauthenticated());
      }
    } catch (e) {
      emit(AppSessionFailure(e.toString()));
    }
  }

  /// Save current user after login/register
  Future<void> saveUser(UserModel user) async {
    try {
      await local.saveUser(user);

      emit(AppSessionAuthenticated(user));
    } catch (e) {
      emit(AppSessionFailure(e.toString()));
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      await local.clearUser();

      emit(AppSessionUnauthenticated());
    } catch (e) {
      emit(AppSessionFailure(e.toString()));
    }
  }
}
