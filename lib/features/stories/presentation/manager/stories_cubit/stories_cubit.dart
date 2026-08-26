/// ===============================
/// presentation/manager/stories_cubit/stories_cubit.dart
/// النسخة الكاملة الاحترافية
/// ===============================

library;

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/add_story_use_case.dart';
import '../../../domain/use_cases/delete_story_use_case.dart';
import '../../../domain/use_cases/get_stories_use_case.dart';
import '../../../domain/use_cases/has_viewed_story_use_case.dart';
import '../../../domain/use_cases/increment_story_view_use_case.dart';
import '../../../domain/use_cases/upload_story_image_use_case.dart';
import 'stories_state.dart';

@injectable
class StoriesCubit extends Cubit<StoriesState> {
  final GetStoriesUseCase getStoriesUseCase;

  final AddStoryUseCase addStoryUseCase;

  final DeleteStoryUseCase deleteStoryUseCase;

  final IncrementStoryViewUseCase incrementStoryViewUseCase;

  final HasViewedStoryUseCase hasViewedStoryUseCase;
  final UploadStoryImageUseCase uploadStoryImageUseCase;

  StoriesCubit(
    this.getStoriesUseCase,
    this.addStoryUseCase,
    this.deleteStoryUseCase,
    this.incrementStoryViewUseCase,
    this.hasViewedStoryUseCase,
    this.uploadStoryImageUseCase,
  ) : super(const StoriesInitial());

  /// ===============================
  /// GET STORIES
  /// ===============================

  Future<void> getStories() async {
    emit(const StoriesLoading());

    try {
      final stories = await getStoriesUseCase.call();

      log("========== STORIES ==========");
      log("Stories Count = ${stories.length}");
      for (final s in stories) {
        log("Story => ${s.storyId} | userId=${s.userId} | name=${s.name}");
      }

      emit(StoriesSuccess(stories));
    } catch (e) {
      log("GET STORIES ERROR => $e");
      emit(StoriesFailure(e.toString()));
    }
  }

  /// ===============================
  /// ADD STORY
  /// ===============================

  Future<void> addStory({required String text, XFile? storyImage}) async {
    emit(const AddStoryLoading());

    String? imageUrl;
    try {
      imageUrl = storyImage == null
          ? null
          : await uploadStoryImageUseCase(
              image: storyImage,
              folderName: "stories",
            );
    } catch (e) {
      emit(StoriesFailure(e.toString()));
      rethrow;
    }

    try {
      await addStoryUseCase.call(text: text, storyImage: imageUrl);

      emit(const AddStorySuccess());

      /// refresh
      await getStories();
    } catch (e) {
      emit(StoriesFailure(e.toString()));
    }
  }

  /// ===============================
  /// DELETE STORY
  /// ===============================

  Future<void> deleteStory(String storyId) async {
    try {
      await deleteStoryUseCase.call(storyId);

      emit(const DeleteStorySuccess());

      /// refresh
      await getStories();
    } catch (e) {
      emit(StoriesFailure(e.toString()));
    }
  }

  /// ===============================
  /// COUNT VIEW
  /// ===============================

  Future<void> incrementView({
    required String storyId,
    required String viewerId,
  }) async {
    try {
      final alreadyViewed = await hasViewedStoryUseCase.call(
        storyId: storyId,
        viewerId: viewerId,
      );

      if (alreadyViewed) return;

      await incrementStoryViewUseCase.call(
        storyId: storyId,
        viewerId: viewerId,
      );

      /// 🔥 update local state بدل refresh كامل
      if (state is StoriesSuccess) {
        final current = state as StoriesSuccess;

        final updatedStories = current.stories.map((story) {
          if (story.storyId == storyId) {
            return story.copyWith(
              viewsCount: story.viewsCount + 1,
              viewedBy: [
                ...story.viewedBy,
                {"userId": viewerId},
              ],
            );
          }
          return story;
        }).toList();

        emit(StoriesSuccess(updatedStories));
      }
    } catch (e) {
      emit(StoriesFailure(e.toString()));
    }
  }

  /// ===============================
  /// CHECK VIEWED
  /// ===============================

  Future<bool> hasViewed({
    required String storyId,
    required String viewerId,
  }) async {
    try {
      return await hasViewedStoryUseCase.call(
        storyId: storyId,
        viewerId: viewerId,
      );
    } catch (e) {
      return false;
    }
  }
}
