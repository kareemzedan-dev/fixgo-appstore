import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/colors_manager.dart';

class AddServiceActions extends StatelessWidget {
  const AddServiceActions({
    super.key,
    required this.submitLabel,
    required this.cancelLabel,
    required this.isLoading,
    required this.onSubmit,
    required this.onCancel,
  });

  final String submitLabel;
  final String cancelLabel;
  final bool isLoading;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: isLoading ? null : onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Center(
                      child: Text(
                        submitLabel,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Alyamama',
                        ),
                      ),
                    ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextButton(
            onPressed: onCancel,
            child: Text(
              cancelLabel,
              style: const TextStyle(
                color: Color(0xFF737373),
                fontSize: 14,
                fontFamily: 'Alyamama',
                fontWeight: FontWeight.w500,
                height: 1.60,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
