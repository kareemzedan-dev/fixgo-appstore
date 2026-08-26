 

library;

import 'package:injectable/injectable.dart';
import '../repos/stories_repo.dart';

@injectable
class IncrementStoryViewUseCase {
  final StoriesRepo repo;

  IncrementStoryViewUseCase(
    this.repo,
  );

  Future<void> call({
    required String storyId,
    required String viewerId,
  }) async {
    await repo.incrementView(
      storyId: storyId,
      viewerId: viewerId,
    );
  }
}