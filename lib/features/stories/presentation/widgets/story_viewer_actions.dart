import 'package:flutter/material.dart';

class StoryViewerActions extends StatelessWidget {
  const StoryViewerActions({
    super.key,
    required this.isOwner,
    required this.viewsCount,
    required this.onClose,
  });

  final bool isOwner;
  final int viewsCount;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 35,
          right: 10,
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: onClose,
          ),
        ),
        if (isOwner)
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.remove_red_eye, color: Colors.white),
                const SizedBox(width: 6),
                Text(
                  '$viewsCount',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
