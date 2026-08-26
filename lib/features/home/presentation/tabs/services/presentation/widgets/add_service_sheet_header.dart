import 'package:flutter/material.dart';

class AddServiceSheetHeader extends StatelessWidget {
  const AddServiceSheetHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: 52,
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xffD9D9D9),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Container(
              width: 4,
              height: 22,
              decoration: BoxDecoration(
                color: const Color(0xff29466F),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
  }
}
