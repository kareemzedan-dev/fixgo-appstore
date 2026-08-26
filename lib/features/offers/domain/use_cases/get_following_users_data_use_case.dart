import 'package:injectable/injectable.dart';
import 'package:fixgo/features/auth/data/models/user_model.dart';
import 'package:fixgo/features/offers/domain/repos/offers_repo.dart';

@injectable
class GetFollowingUsersDataUseCase {
  final OffersRepo repo;

  GetFollowingUsersDataUseCase(this.repo);

  Future<List<UserModel>> call() {
    return repo.getFollowingUsersData();
  }
}
