/// ===============================
/// data/data_sources/stories_remote_data_source.dart
/// ===============================

library;

import 'package:image_picker/image_picker.dart';

import '../models/story_model.dart';

abstract class StoriesRemoteDataSource {
  /// GET STORIES
  Future<List<StoryModel>> getStories();

  /// ADD STORY
  Future<void> addStory({
    required String text,
    String? storyImage,
  });

  /// DELETE STORY
  Future<void> deleteStory(
    String storyId,
  );

  /// INCREMENT VIEW
  Future<void> incrementView({
    required String storyId,
    required String viewerId,
  });

  /// CHECK VIEWED BEFORE
  Future<bool> hasViewedStory({
    required String storyId,
    required String viewerId,
  });

  Future<String> uploadStoryImage({
    required XFile image,
    required String folderName,
  });
}