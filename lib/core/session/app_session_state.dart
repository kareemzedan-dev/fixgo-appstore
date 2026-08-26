/// core/session/app_session_state.dart
library;

import '../../features/auth/data/models/user_model.dart';

abstract class AppSessionState {}

class AppSessionInitial extends AppSessionState {}

class AppSessionLoading extends AppSessionState {}

class AppSessionAuthenticated extends AppSessionState {
  final UserModel user;

  AppSessionAuthenticated(this.user);
}

class AppSessionUnauthenticated extends AppSessionState {}

class AppSessionFailure extends AppSessionState {
  final String message;

  AppSessionFailure(this.message);
}