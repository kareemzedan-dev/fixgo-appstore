import 'package:flutter/material.dart';
import 'package:fixgo/core/components/custom_button.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class FilterForm extends StatelessWidget {
  const FilterForm({
    super.key,
    required this.selectedCategory,
    required this.selectedService,
    required this.categories,
    required this.services,
    required this.ratingRange,
    required this.experienceRange,
    required this.distanceRange,
    required this.onCategoryChanged,
    required this.onServiceChanged,
    required this.onRatingChanged,
    required this.onExperienceChanged,
    required this.onDistanceChanged,
    required this.onApply,
  });

  final String? selectedCategory;
  final String? selectedService;
  final List<String> categories;
  final List<String> services;
  final RangeValues ratingRange;
  final RangeValues experienceRange;
  final RangeValues distanceRange;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<String?> onServiceChanged;
  final ValueChanged<RangeValues> onRatingChanged;
  final ValueChanged<RangeValues> onExperienceChanged;
  final ValueChanged<RangeValues> onDistanceChanged;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FilterDropdownSection(
          title: l10n.serviceCategory,
          hint: l10n.selectServiceCategory,
          value: selectedCategory,
          items: categories,
          onChanged: onCategoryChanged,
        ),
        SizedBox(height: AppSizes.h(24)),
        _FilterDropdownSection(
          title: l10n.service,
          hint: l10n.selectService,
          value: selectedService,
          items: services,
          onChanged: onServiceChanged,
        ),
        SizedBox(height: AppSizes.h(32)),
        _FilterRangeSection(
          title: l10n.workerRating,
          values: ratingRange,
          min: 0,
          max: 5,
          divisions: 5,
          leftLabel: '${ratingRange.start.toStringAsFixed(1)} ⭐',
          rightLabel: '${ratingRange.end.toStringAsFixed(1)} ⭐',
          onChanged: onRatingChanged,
        ),
        SizedBox(height: AppSizes.h(24)),
        _FilterRangeSection(
          title: l10n.yearsExperience,
          values: experienceRange,
          min: 1,
          max: 30,
          divisions: 29,
          leftLabel: l10n.yearValue(experienceRange.start.round()),
          rightLabel: '${experienceRange.end.round()}+',
          onChanged: onExperienceChanged,
        ),
        SizedBox(height: AppSizes.h(24)),
        _FilterRangeSection(
          title: l10n.distance,
          values: distanceRange,
          min: 1,
          max: 50,
          divisions: 49,
          leftLabel: l10n.kilometerValue(distanceRange.start.round()),
          rightLabel: l10n.kilometerValue(distanceRange.end.round()),
          onChanged: onDistanceChanged,
        ),
        SizedBox(height: AppSizes.h(40)),
        CustomButton(text: l10n.applyFilter, onPressed: onApply),
        SizedBox(height: AppSizes.h(20)),
      ],
    );
  }
}

class _FilterDropdownSection extends StatelessWidget {
  const _FilterDropdownSection({
    required this.title,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String title;
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FilterTitle(title),
        SizedBox(height: AppSizes.h(10)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(14),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              hint: Text(
                hint,
                style: TextStyle(fontSize: AppSizes.sp(14), color: Colors.grey),
              ),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items
                  .map(
                    (item) => DropdownMenuItem(value: item, child: Text(item)),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterRangeSection extends StatelessWidget {
  const _FilterRangeSection({
    required this.title,
    required this.values,
    required this.min,
    required this.max,
    required this.divisions,
    required this.leftLabel,
    required this.rightLabel,
    required this.onChanged,
  });

  final String title;
  final RangeValues values;
  final double min;
  final double max;
  final int divisions;
  final String leftLabel;
  final String rightLabel;
  final ValueChanged<RangeValues> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FilterTitle(title),
        SizedBox(height: AppSizes.h(12)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_RangeLabel(leftLabel), _RangeLabel(rightLabel)],
        ),
        RangeSlider(
          values: values,
          min: min,
          max: max,
          divisions: divisions,
          activeColor: ColorsManager.secondaryColor,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _FilterTitle extends StatelessWidget {
  const _FilterTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: AppSizes.sp(16), fontWeight: FontWeight.w600),
    );
  }
}

class _RangeLabel extends StatelessWidget {
  const _RangeLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(fontSize: AppSizes.sp(14), fontWeight: FontWeight.w600),
    );
  }
}
