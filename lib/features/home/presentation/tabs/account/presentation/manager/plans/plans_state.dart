import 'package:fixgo/features/home/presentation/tabs/account/domain/entities/plan_entity.dart';

abstract class PlansState {}

class PlansInitial extends PlansState {}

class PlansLoading extends PlansState {}

class PlansLoaded extends PlansState {
  final List<PlanEntity> plans;

  PlansLoaded(this.plans);
}

class PlansError extends PlansState {
  final String message;

  PlansError(this.message);
}
