import 'package:injectable/injectable.dart';

import '../repos/offers_repo.dart';
@injectable
class ToggleFollowUseCase {
  final OffersRepo repo;

  ToggleFollowUseCase(this.repo);

  Future<void> call(String userId) {
    return repo.toggleFollow(
      userId: userId,
    );
  }
}