import 'package:flutter/material.dart';
import 'package:fixgo/core/components/custom_button.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/features/offers/presentation/manager/search_cubit/search_state.dart';
import 'package:fixgo/l10n/app_localizations.dart';

void showSortBottomSheet(
  BuildContext context, {
  required SearchState state,
  required Function(SortType) onApply,
}) {
  int selectedIndex = state.selectedSort == SortType.rating
      ? 0
      : state.selectedSort == SortType.experience
      ? 1
      : 2;
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final l10n = AppLocalizations.of(context);

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: isDark ? const Color(0Xff1E1E1E) : Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 70,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3A70),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.sort,
                      style: TextStyle(
                        fontSize: AppSizes.sp(20),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildRadioItem(
                  title: l10n.workerRating,
                  icon: Icons.star,
                  color: Colors.amber,
                  value: 0,
                  groupValue: selectedIndex,
                  onChanged: (value) {
                    setState(() {
                      selectedIndex = value!;
                    });
                  },
                ),
                _buildRadioItem(
                  title: l10n.yearsExperienceCount,
                  icon: Icons.workspace_premium_outlined,
                  color: ColorsManager.primaryColor,
                  value: 1,
                  groupValue: selectedIndex,
                  onChanged: (value) {
                    setState(() {
                      selectedIndex = value!;
                    });
                  },
                ),
                _buildRadioItem(
                  title: l10n.distance,
                  icon: Icons.location_on,
                  color: ColorsManager.primaryColor,
                  value: 2,
                  groupValue: selectedIndex,
                  onChanged: (value) {
                    setState(() {
                      selectedIndex = value!;
                    });
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: l10n.applySort,
                        onPressed: () {
                          onApply(
                            selectedIndex == 0
                                ? SortType.rating
                                : selectedIndex == 1
                                ? SortType.experience
                                : SortType.distance,
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        l10n.cancel,
                        style: TextStyle(
                          fontSize: AppSizes.sp(14),
                          color: const Color(0xFF9E9E9E),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

void showFilterBottomSheet(
  BuildContext context, {
  required SearchState state,
  required Function({
    required double minRating,
    required double maxRating,
    required int minExperience,
    required int maxExperience,
    required double minDistance,
    required double maxDistance,
  })
  onApply,
}) {
  final l10n = AppLocalizations.of(context);
  RangeValues ratingRange = RangeValues(state.minRating, state.maxRating);

  RangeValues experienceRange = RangeValues(
    state.minExperience.toDouble(),
    state.maxExperience.toDouble(),
  );

  final min = 1.0;
  final max = 50.0;
  final isDark = Theme.of(context).brightness == Brightness.dark;

  double start = state.minDistance.clamp(min, max);
  double end = state.maxDistance.clamp(min, max);

  if (start > end) {
    final temp = start;
    start = end;
    end = temp;
  }

  RangeValues distanceRange = RangeValues(start, end);
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: isDark ? const Color(0Xff1E1E1E) : Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 70,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3A70),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.filter,
                      style: TextStyle(
                        fontSize: AppSizes.sp(20),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildRangeSection(
                  context: context,
                  reverseValues: false,
                  title: l10n.workerRating,
                  start: "${ratingRange.start.toStringAsFixed(1)} ⭐",
                  end: "${ratingRange.end.toStringAsFixed(1)} ⭐",
                  slider: RangeSlider(
                    values: ratingRange,
                    min: 0,
                    max: 5,
                    divisions: 5,
                    onChanged: (value) {
                      setState(() {
                        ratingRange = value;
                      });
                    },
                  ),
                ),
                _buildRangeSection(
                  context: context,
                  reverseValues: true,
                  title: l10n.yearsExperience,
                  start: l10n.experiencePlusYears(experienceRange.end.toInt()),
                  end: l10n.yearValue(experienceRange.start.toInt()),
                  slider: RangeSlider(
                    values: experienceRange,
                    min: 1,
                    max: 30,
                    divisions: 29,
                    onChanged: (value) {
                      setState(() {
                        experienceRange = value;
                      });
                    },
                  ),
                ),
                _buildRangeSection(
                  context: context,
                  reverseValues: true,
                  title: l10n.distance,
                  start: l10n.kilometerValue(distanceRange.end.toInt()),
                  end: l10n.kilometerValue(distanceRange.start.toInt()),
                  slider: RangeSlider(
                    values: distanceRange,
                    min: 1,
                    max: 50,
                    divisions: 49,
                    onChanged: (value) {
                      setState(() {
                        distanceRange = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: l10n.applyFilter,
                        onPressed: () {
                          onApply(
                            minRating: ratingRange.start,
                            maxRating: ratingRange.end,
                            minExperience: experienceRange.start.toInt(),
                            maxExperience: experienceRange.end.toInt(),
                            minDistance: distanceRange.start,
                            maxDistance: distanceRange.end,
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        l10n.cancel,
                        style: TextStyle(
                          fontSize: AppSizes.sp(14),
                          color: const Color(0xFF9E9E9E),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _buildRadioItem({
  required String title,
  required IconData icon,
  required int value,
  required int groupValue,
  required ValueChanged<int?> onChanged,
  required Color color,
}) {
  return Row(
    children: [
      Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            title,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ],
      ),
      const Spacer(),
      Radio<int>(value: value, groupValue: groupValue, onChanged: onChanged),
    ],
  );
}

Widget _buildRangeSection({
  required BuildContext context,
  required String title,
  required String start,
  required String end,
  required Widget slider,
  bool reverseValues = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      const SizedBox(height: 8),
      Row(
        children: [
          Text(reverseValues ? end : start),
          const Spacer(),
          Text(reverseValues ? start : end),
        ],
      ),
      SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: ColorsManager.primaryColor,
          inactiveTrackColor: Colors.grey.shade300,
          thumbColor: ColorsManager.primaryColor,
          overlayColor: ColorsManager.primaryColor.withOpacity(0.2),
          rangeThumbShape: const RoundRangeSliderThumbShape(
            enabledThumbRadius: 8,
          ),
          rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
        ),
        child: slider,
      ),
      const SizedBox(height: 12),
    ],
  );
}
