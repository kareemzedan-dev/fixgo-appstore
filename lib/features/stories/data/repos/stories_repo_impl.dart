/// ===============================
/// data/repos/stories_repo_impl.dart
/// النسخة الكاملة
/// ===============================

library;

import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/story_entity.dart';
import '../../domain/repos/stories_repo.dart';
import '../data_sources/stories_remote_data_source.dart';

@LazySingleton(
  as: StoriesRepo,
)
class StoriesRepoImpl
    implements StoriesRepo {
  final StoriesRemoteDataSource
      remoteDataSource;

  StoriesRepoImpl(
    this.remoteDataSource,
  );

  @override
  Future<List<StoryEntity>>
      getStories() async {
    return await remoteDataSource
        .getStories();
  }

  @override
  Future<void> addStory({
    required String text,
    String? storyImage,
  }) async {
    await remoteDataSource.addStory(
      text: text,
      storyImage: storyImage,
    );
  }

  @override
  Future<void> deleteStory(
    String storyId,
  ) async {
    await remoteDataSource
        .deleteStory(
      storyId,
    );
  }

  @override
  Future<void> incrementView({
    required String storyId,
    required String viewerId,
  }) async {
    await remoteDataSource
        .incrementView(
      storyId: storyId,
      viewerId: viewerId,
    );
  }

  @override
  Future<bool>
      hasViewedStory({
    required String storyId,
    required String viewerId,
  }) async {
    return await remoteDataSource
        .hasViewedStory(
      storyId: storyId,
      viewerId: viewerId,
    );
  }

  @override
  Future<String> uploadStoryImage({
    required XFile image,
    required String folderName,
  }) {
    return remoteDataSource.uploadStoryImage(
      image: image,
      folderName: folderName,
    );
  }
}