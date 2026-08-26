import 'package:injectable/injectable.dart';

import '../../domain/entities/plan_entity.dart';
import '../../domain/repos/plans_repo.dart';
import '../data_sources/plans_remote_data_source.dart';

@Injectable(as: PlansRepo)
class PlansRepoImpl implements PlansRepo {
  final PlansRemoteDataSource remoteDataSource;

  PlansRepoImpl(this.remoteDataSource);

  @override
  Future<List<PlanEntity>> getPlans() async {
    final plans = await remoteDataSource.getPlans();
    return plans.map((plan) => plan.toEntity()).toList();
  }
}
