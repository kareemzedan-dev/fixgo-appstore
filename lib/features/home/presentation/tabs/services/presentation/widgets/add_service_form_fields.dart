import 'package:flutter/material.dart';
import 'package:fixgo/core/constants/service_categories.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class AddServiceFormFields extends StatelessWidget {
  const AddServiceFormFields({
    super.key,
    required this.selectedCategory,
    required this.selectedService,
    required this.selectedYears,
    required this.onCategoryChanged,
    required this.onServiceChanged,
    required this.onYearsChanged,
  });

  final String? selectedCategory;
  final String? selectedService;
  final String? selectedYears;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<String?> onServiceChanged;
  final ValueChanged<String?> onYearsChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _CustomDropDownField(
                title: l10n.serviceCategory,
                hint: l10n.selectCategory,
                value: selectedCategory,
                items: ServiceCategories.mainCategories,
                onChanged: onCategoryChanged,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _CustomDropDownField(
                title: l10n.service,
                hint: l10n.selectService,
                value: selectedService,
                items: selectedCategory == null
                    ? []
                    : ServiceCategories.getServicesByCategory(
                        selectedCategory!,
                      ),
                onChanged: onServiceChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        _CustomDropDownField(
          title: l10n.yearsExperience,
          hint: l10n.enterYearsOfExperience,
          value: selectedYears,
          items: const ["1", "2", "3", "4", "5", "10+"],
          itemLabelBuilder: (value) => value == "10+"
              ? l10n.tenPlusYears
              : l10n.yearValue(int.parse(value)),
          onChanged: onYearsChanged,
        ),
      ],
    );
  }
}

class _CustomDropDownField extends StatelessWidget {
  const _CustomDropDownField({
    required this.title,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    this.itemLabelBuilder,
  });

  final String title;
  final String hint;
  final String? value;
  final List<String> items;
  final String Function(String)? itemLabelBuilder;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.60,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          isExpanded: true,
          initialValue: value,
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(
                itemLabelBuilder?.call(item) ?? item,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Alyamama',
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          hint: Text(hint),
        ),
      ],
    );
  }
}
