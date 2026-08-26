import 'package:flutter/material.dart';

class AddServiceLocationSection extends StatelessWidget {
  const AddServiceLocationSection({
    super.key,
    required this.controller,
    required this.hint,
    required this.onSelectLocation,
  });

  final TextEditingController controller;
  final String hint;
  final Future<void> Function() onSelectLocation;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      style: const TextStyle(fontSize: 12, fontFamily: 'Alyamama'),
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        suffixIcon: GestureDetector(
          onTap: onSelectLocation,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xff29466F),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.location_on, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
