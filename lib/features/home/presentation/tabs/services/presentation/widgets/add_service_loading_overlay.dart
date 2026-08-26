import 'package:flutter/material.dart';

class AddServiceLoadingOverlay extends StatelessWidget {
  const AddServiceLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.message,
  });

  final bool isLoading;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isLoading ? 1 : 0,
      duration: const Duration(milliseconds: 200),
      child: isLoading
          ? Positioned.fill(
              child: AbsorbPointer(
                absorbing: true,
                child: Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 12),
                          Text(message),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
