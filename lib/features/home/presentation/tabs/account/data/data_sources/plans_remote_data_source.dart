import '../models/plan.dart';

abstract class PlansRemoteDataSource {
  Future<List<Plan>> getPlans();
}
