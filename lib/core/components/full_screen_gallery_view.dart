 

import 'package:flutter/material.dart';

class FullScreenGalleryView extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const FullScreenGalleryView({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<FullScreenGalleryView> createState() =>
      _FullScreenGalleryViewState();
}

class _FullScreenGalleryViewState
    extends State<FullScreenGalleryView> {
  late final PageController pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();

    currentIndex = widget.initialIndex;

    pageController = PageController(
      initialPage: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              itemCount: widget.images.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  child: Center(
                    child: Hero(
                      tag:
                          "${widget.images[index]}_$index",
                      child: Image.network(
                        widget.images[index],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),

            /// زر الإغلاق
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            /// عداد الصور
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: Text(
                    "${currentIndex + 1} / ${widget.images.length}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}