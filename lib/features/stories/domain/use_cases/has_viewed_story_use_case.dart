 

library;

import 'package:injectable/injectable.dart';
import '../repos/stories_repo.dart';

@injectable
class HasViewedStoryUseCase {
  final StoriesRepo repo;

  HasViewedStoryUseCase(
    this.repo,
  );

  Future<bool> call({
    required String storyId,
    required String viewerId,
  }) async {
    return await repo.hasViewedStory(
      storyId: storyId,
      viewerId: viewerId,
    );
  }
}