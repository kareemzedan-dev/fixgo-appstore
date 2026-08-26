/// ===============================
/// domain/repos/stories_repo.dart
/// النسخة الكاملة
/// ===============================

library;

import 'package:image_picker/image_picker.dart';

import '../entities/story_entity.dart';

abstract class StoriesRepo {
  /// GET
  Future<List<StoryEntity>> getStories();

  /// ADD
  Future<void> addStory({
    required String text,
    String? storyImage,
  });

  /// DELETE
  Future<void> deleteStory(
    String storyId,
  );

  /// COUNT VIEW
  Future<void> incrementView({
    required String storyId,
    required String viewerId,
  });

  /// CHECK VIEWED
  Future<bool> hasViewedStory({
    required String storyId,
    required String viewerId,
  });

  Future<String> uploadStoryImage({
    required XFile image,
    required String folderName,
  });
}