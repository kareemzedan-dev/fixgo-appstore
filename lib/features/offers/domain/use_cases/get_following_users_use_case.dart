import 'package:injectable/injectable.dart';
import '../repos/offers_repo.dart';

@injectable
class GetFollowingUsersUseCase {
  final OffersRepo repo;

  GetFollowingUsersUseCase(this.repo);

  Future<List<String>> call() {
    return repo.getFollowingUsers();
  }
}