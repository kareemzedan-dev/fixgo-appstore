import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/features/stories/domain/entities/story_entity.dart';
import 'package:fixgo/features/stories/presentation/manager/stories_cubit/stories_cubit.dart';
import 'package:fixgo/features/stories/presentation/manager/stories_cubit/stories_state.dart';
import 'package:fixgo/features/stories/presentation/widgets/story_viewer_body.dart';
import 'package:fixgo/features/stories/presentation/widgets/story_views_sheet.dart';

class StoryViewerScreen extends StatefulWidget {
  const StoryViewerScreen({
    super.key,
    required this.stories,
    this.initialIndex = 0,
  });

  final List<StoryEntity> stories;
  final int initialIndex;

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen>
    with SingleTickerProviderStateMixin {
  late int currentIndex;
  late AnimationController _progressController;
  Timer? _timer;
  int viewsCount = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _loadViews();
    _startStory();
  }

  @override
  Widget build(BuildContext context) {
    final story = widget.stories[currentIndex];
    final uid = context.read<AppSessionCubit>().currentUser?.uid;
    final isOwner = uid == story.userId;

    return Scaffold(
      backgroundColor: Colors.black,
      body: StoryViewerBody(
        story: story,
        storyCount: widget.stories.length,
        currentIndex: currentIndex,
        progressAnimation: _progressController,
        isOwner: isOwner,
        viewsCount: viewsCount,
        onNext: _nextStory,
        onPrevious: _previousStory,
        onOwnerSwipeUp: () => showStoryViewsSheet(context, story: story),
        onClose: () => Navigator.pop(context),
      ),
    );
  }

  Future<void> _loadViews() async {
    final currentStory = widget.stories[currentIndex];
    final uid = context.read<AppSessionCubit>().currentUser?.uid;

    if (uid != null && uid != currentStory.userId) {
      await context.read<StoriesCubit>().incrementView(
        storyId: currentStory.storyId,
        viewerId: uid,
      );
    }

    final state = context.read<StoriesCubit>().state;
    if (state is StoriesSuccess) {
      final updatedStory = state.stories.firstWhere(
        (story) => story.storyId == currentStory.storyId,
      );
      viewsCount = updatedStory.viewsCount;
    }

    if (mounted) setState(() {});
  }

  void _startStory() {
    _progressController
      ..stop()
      ..reset()
      ..forward();
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 5), _nextStory);
  }

  void _nextStory() {
    if (currentIndex < widget.stories.length - 1) {
      setState(() => currentIndex++);
      _loadViews();
      _startStory();
    } else {
      Navigator.pop(context);
    }
  }

  void _previousStory() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
      _loadViews();
      _startStory();
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
