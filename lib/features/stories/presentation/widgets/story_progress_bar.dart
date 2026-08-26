import 'package:flutter/material.dart';

class StoryProgressBar extends StatelessWidget {
  const StoryProgressBar({
    super.key,
    required this.storyCount,
    required this.currentIndex,
    required this.animation,
  });

  final int storyCount;
  final int currentIndex;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(storyCount, (index) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                var value = 0.0;
                if (index < currentIndex) {
                  value = 1;
                } else if (index == currentIndex) {
                  value = animation.value;
                }

                return LinearProgressIndicator(
                  value: value,
                  backgroundColor: Colors.white30,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
