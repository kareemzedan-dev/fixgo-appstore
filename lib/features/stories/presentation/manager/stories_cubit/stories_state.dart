/// ===============================
/// presentation/manager/stories_cubit/stories_state.dart
/// النسخة الكاملة الاحترافية
/// ===============================

library;

import '../../../domain/entities/story_entity.dart';

abstract class StoriesState {
  const StoriesState();
}

/// ===============================
/// INITIAL
/// ===============================

class StoriesInitial extends StoriesState {
  const StoriesInitial();
}

/// ===============================
/// LOADING
/// ===============================

class StoriesLoading extends StoriesState {
  const StoriesLoading();
}

/// ===============================
/// SUCCESS
/// ===============================

class StoriesSuccess extends StoriesState {
  final List<StoryEntity> stories;

  const StoriesSuccess(
    this.stories,
  );
}

/// ===============================
/// FAILURE
/// ===============================

class StoriesFailure extends StoriesState {
  final String message;

  const StoriesFailure(
    this.message,
  );
}

/// ===============================
/// ADD STORY LOADING
/// ===============================

class AddStoryLoading extends StoriesState {
  const AddStoryLoading();
}

/// ===============================
/// ADD STORY SUCCESS
/// ===============================

class AddStorySuccess extends StoriesState {
  const AddStorySuccess();
}

/// ===============================
/// DELETE STORY SUCCESS
/// ===============================

class DeleteStorySuccess extends StoriesState {
  const DeleteStorySuccess();
}

/// ===============================
/// VIEW COUNT UPDATED
/// ===============================

class StoryViewUpdated extends StoriesState {
  const StoryViewUpdated();
}