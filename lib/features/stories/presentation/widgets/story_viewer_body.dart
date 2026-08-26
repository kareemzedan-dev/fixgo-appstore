import 'package:flutter/material.dart';
import 'package:fixgo/features/stories/domain/entities/story_entity.dart';
import 'package:fixgo/features/stories/presentation/widgets/story_content.dart';
import 'package:fixgo/features/stories/presentation/widgets/story_progress_bar.dart';
import 'package:fixgo/features/stories/presentation/widgets/story_viewer_actions.dart';

class StoryViewerBody extends StatelessWidget {
  const StoryViewerBody({
    super.key,
    required this.story,
    required this.storyCount,
    required this.currentIndex,
    required this.progressAnimation,
    required this.isOwner,
    required this.viewsCount,
    required this.onNext,
    required this.onPrevious,
    required this.onOwnerSwipeUp,
    required this.onClose,
  });

  final StoryEntity story;
  final int storyCount;
  final int currentIndex;
  final Animation<double> progressAnimation;
  final bool isOwner;
  final int viewsCount;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onOwnerSwipeUp;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapUp: (details) {
        final screenWidth = MediaQuery.of(context).size.width;
        if (details.globalPosition.dx < screenWidth / 2) {
          onNext();
        } else {
          onPrevious();
        }
      },
      onVerticalDragUpdate: (details) {
        if (isOwner && details.delta.dy < -10) {
          onOwnerSwipeUp();
        }
      },
      child: Stack(
        children: [
          StoryContent(story: story),
          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: StoryProgressBar(
              storyCount: storyCount,
              currentIndex: currentIndex,
              animation: progressAnimation,
            ),
          ),
          Positioned.fill(
            child: StoryViewerActions(
              isOwner: isOwner,
              viewsCount: viewsCount,
              onClose: onClose,
            ),
          ),
        ],
      ),
    );
  }
}
