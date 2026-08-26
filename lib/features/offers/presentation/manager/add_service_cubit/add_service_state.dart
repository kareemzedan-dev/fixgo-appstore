/// presentation/manager/add_service_cubit/add_service_state.dart
library;

abstract class AddServiceState {}

class AddServiceInitial extends AddServiceState {}

class AddServiceLoading extends AddServiceState {}

class AddServiceSuccess extends AddServiceState {
  final String message;

  AddServiceSuccess(
    this.message,
  );
}

class AddServiceFailure extends AddServiceState {
  final String message;

  AddServiceFailure(
    this.message,
  );
}