 

library;

import 'package:injectable/injectable.dart';
import '../repos/stories_repo.dart';

@injectable
class AddStoryUseCase {
  final StoriesRepo repo;

  AddStoryUseCase(
    this.repo,
  );

  Future<void> call({
    required String text,
    String? storyImage,
  }) async {
    await repo.addStory(
      text: text,
      storyImage: storyImage,
    );
  }
}