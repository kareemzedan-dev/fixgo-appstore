import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {

  final int currentIndex;
  final int count;

  const PageIndicator({
    super.key,
    required this.currentIndex,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
            (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentIndex == index ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? const Color(0xff1E3A5F)
                : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}