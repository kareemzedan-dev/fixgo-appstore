import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class FilterHeader extends StatelessWidget {
  const FilterHeader({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onBack,
          child: Container(
            width: AppSizes.w(42),
            height: AppSizes.h(42),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 18),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              AppLocalizations.of(context).filter,
              style: TextStyle(
                fontSize: AppSizes.sp18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: AppSizes.w(42)),
      ],
    );
  }
}
