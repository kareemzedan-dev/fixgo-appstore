/// domain/use_cases/get_stories_use_case.dart
library;

import 'package:injectable/injectable.dart';

import '../entities/story_entity.dart';
import '../repos/stories_repo.dart';
@injectable
class GetStoriesUseCase {
  final StoriesRepo repo;

  GetStoriesUseCase(this.repo);

  Future<List<StoryEntity>> call() async {
    return await repo.getStories();
  }
}