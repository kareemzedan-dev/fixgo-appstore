/// core/components/custom_top_error_message.dart
library;

import 'package:flutter/material.dart';

class CustomTopErrorMessage {
  static void show(
    BuildContext context, {
    required String message,
    bool isSuccess = false,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _TopMessageWidget(
        message: message,
        isSuccess: isSuccess,
        onDismiss: () {
          overlayEntry.remove();
        },
      ),
    );

    overlay.insert(overlayEntry);
  }
}

class _TopMessageWidget extends StatefulWidget {
  final String message;
  final bool isSuccess;
  final VoidCallback onDismiss;

  const _TopMessageWidget({
    required this.message,
    required this.isSuccess,
    required this.onDismiss,
  });

  @override
  State<_TopMessageWidget> createState() => _TopMessageWidgetState();
}

class _TopMessageWidgetState extends State<_TopMessageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () async {
      await _controller.reverse();
      widget.onDismiss();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get backgroundColor {
    if (widget.isSuccess) {
      return const Color(0xFF2E7D32);
    }
    return const Color(0xFFD32F2F);
  }

  IconData get icon {
    if (widget.isSuccess) {
      return Icons.check_circle;
    }
    return Icons.error_outline;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(icon, color: Colors.white, size: 22),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Alyamama',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
