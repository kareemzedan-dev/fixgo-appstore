import 'package:injectable/injectable.dart';

import '../entities/plan_entity.dart';
import '../repos/plans_repo.dart';

@injectable
class GetPlansUseCase {
  final PlansRepo repository;

  GetPlansUseCase(this.repository);

  Future<List<PlanEntity>> call() => repository.getPlans();
}
