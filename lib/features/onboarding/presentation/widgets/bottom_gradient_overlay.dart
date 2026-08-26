import 'package:flutter/material.dart';
import '../../../../../../../core/utils/colors_manager.dart';

class BottomGradientOverlay extends StatelessWidget {
  const BottomGradientOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFFDFE9FF), const Color(0xFFE0EAFF)],
        ),
      ),
    );
  }
}
