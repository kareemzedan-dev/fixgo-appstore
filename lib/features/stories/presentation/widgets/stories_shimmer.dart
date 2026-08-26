import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StoriesShimmer extends StatelessWidget {
  final bool isWorker;

  const StoriesShimmer({
    super.key,
    required this.isWorker,
  });

  @override
  Widget build(BuildContext context) {
    final itemCount = isWorker ? 6 : 5;

    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: itemCount,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 50,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}