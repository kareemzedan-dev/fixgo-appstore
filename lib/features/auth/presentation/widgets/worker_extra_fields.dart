/// widgets/worker_extra_fields.dart

library;

import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class WorkerExtraFields extends StatelessWidget {
  final String? selectedService;
  final String? selectedCategory;
  final String? selectedYears;

  final List<String> services;
  final List<String> categories;
  final List<String> yearsList;

  final Function(String?) onServiceChanged;
  final Function(String?) onCategoryChanged;
  final Function(String?) onYearsChanged;

  const WorkerExtraFields({
    super.key,
    required this.selectedService,
    required this.selectedCategory,
    required this.selectedYears,
    required this.services,
    required this.categories,
    required this.yearsList,
    required this.onServiceChanged,
    required this.onCategoryChanged,
    required this.onYearsChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        /// الخدمة + تصنيف الخدمة
        Row(
          children: [
            Expanded(
              child: _buildDropdown(
                title: l10n.serviceCategory,
                hint: l10n.selectServiceCategory,
                value: selectedCategory,
                items: categories,
                onChanged: onCategoryChanged,
              ),
            ),

            SizedBox(width: AppSizes.w(16)),

            Expanded(
              child: _buildDropdown(
                title: l10n.service,
                hint: l10n.selectService,
                value: selectedService,
                items: services,
                onChanged: onServiceChanged,
              ),
            ),
          ],
        ),

        SizedBox(height: AppSizes.h(22)),

        /// سنين الخبرة
        _buildDropdown(
          title: l10n.yearsExperience,
          hint: l10n.enterYearsOfExperience,
          value: selectedYears,
          items: yearsList,
          onChanged: onYearsChanged,
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String title,
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            title,
            style: TextStyle(
              fontSize: AppSizes.sp(16),
              fontWeight: FontWeight.w400,
              height: 1.60,
            ),
          ),
        ),

        const SizedBox(height: 8),

        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,

          dropdownColor: ColorsManager.white,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE8E8E8)),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE8E8E8)),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE8E8E8)),
            ),
          ),

          hint: Text(
            hint,
            style: TextStyle(
              fontSize: AppSizes.sp(12),
              fontWeight: FontWeight.w500,
            ),
          ),

          icon: const Icon(Icons.keyboard_arrow_down),

          items: items.map((item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),

          onChanged: (value) {
            onChanged(value);

            debugPrint("$title => $value");
          },
        ),
      ],
    );
  }
}
