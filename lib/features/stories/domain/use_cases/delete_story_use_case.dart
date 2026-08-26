 

library;

import 'package:injectable/injectable.dart';
import '../repos/stories_repo.dart';

@injectable
class DeleteStoryUseCase {
  final StoriesRepo repo;

  DeleteStoryUseCase(
    this.repo,
  );

  Future<void> call(
    String storyId,
  ) async {
    await repo.deleteStory(
      storyId,
    );
  }
}