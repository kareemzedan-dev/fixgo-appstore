import 'package:flutter/material.dart';
import 'package:fixgo/features/stories/domain/entities/story_entity.dart';

class StoryContent extends StatelessWidget {
  const StoryContent({super.key, required this.story});

  final StoryEntity story;

  @override
  Widget build(BuildContext context) {
    final image = story.storyImage ?? story.userImage;
    return Center(
      child: Stack(
        children: [
          if (image != null && image.isNotEmpty)
            Positioned.fill(child: Image.network(image, fit: BoxFit.contain)),
          if (story.text.isNotEmpty)
            if (image != null && image.isNotEmpty)
              Positioned(
                bottom: 60,
                left: 20,
                right: 20,
                child: _StoryText(text: story.text),
              )
            else
              Positioned.fill(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: _StoryText(text: story.text),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class _StoryText extends StatelessWidget {
  const _StoryText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
