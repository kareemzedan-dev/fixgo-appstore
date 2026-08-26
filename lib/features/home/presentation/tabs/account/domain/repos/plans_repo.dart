import '../entities/plan_entity.dart';

abstract class PlansRepo {
  Future<List<PlanEntity>> getPlans();
}
