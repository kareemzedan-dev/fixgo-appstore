import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class SearchInputHeader extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onCancel;

  const SearchInputHeader({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.r(14)),
              color: Colors.grey.shade100,
            ),
            child: TextField(
              controller: controller,
              autofocus: true,
              textAlign: TextAlign.right,
              textInputAction: TextInputAction.search,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                hintText: l10n.searchForService,
                prefixIcon: const Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSizes.p16,
                  vertical: AppSizes.p12,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: AppSizes.w(12)),
        GestureDetector(
          onTap: onCancel,
          child: Text(
            l10n.cancel,
            style: TextStyle(
              fontSize: AppSizes.sp(14),
              fontWeight: FontWeight.w500,
              color: ColorsManager.darkGrey,
            ),
          ),
        ),
      ],
    );
  }
}

class RecentSearchesSection extends StatelessWidget {
  final List<String> history;
  final VoidCallback onClearAll;
  final ValueChanged<String> onSelect;
  final ValueChanged<String> onRemove;

  const RecentSearchesSection({
    super.key,
    required this.history,
    required this.onClearAll,
    required this.onSelect,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.searchHistory,
              style: TextStyle(
                color: ColorsManager.darkGrey,
                fontSize: AppSizes.sp(12),
                fontFamily: 'Alyamama',
                fontWeight: FontWeight.w500,
                height: 1.60,
              ),
            ),
            GestureDetector(
              onTap: onClearAll,
              child: Text(
                l10n.notificationsDeleteAll,
                style: TextStyle(
                  fontSize: AppSizes.sp(12),
                  fontWeight: FontWeight.w500,
                  color: ColorsManager.darkGrey,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppSizes.h(16)),
        ...history.map(
          (item) => Padding(
            padding: EdgeInsets.only(bottom: AppSizes.h(18)),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => onSelect(item),
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: AppSizes.sp(12),
                      fontWeight: FontWeight.w700,
                      height: 1.60,
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => onRemove(item),
                  child: const Icon(Icons.close, size: 20),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PopularSearchesSection extends StatelessWidget {
  final List<String> searches;
  final ValueChanged<String> onSelect;

  const PopularSearchesSection({
    super.key,
    required this.searches,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).popularSearches,
          style: TextStyle(
            fontSize: AppSizes.sp(12),
            fontWeight: FontWeight.w500,
            color: ColorsManager.darkGrey,
          ),
        ),
        SizedBox(height: AppSizes.h(16)),
        Wrap(
          spacing: 10,
          runSpacing: 12,
          alignment: WrapAlignment.start,
          children: searches
              .map(
                (item) => GestureDetector(
                  onTap: () => onSelect(item),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.h(14),
                      vertical: AppSizes.h(10),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.r(30)),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.north_west, size: 16),
                        SizedBox(width: AppSizes.w(6)),
                        Text(
                          item,
                          style: TextStyle(
                            fontSize: AppSizes.sp(12),
                            fontWeight: FontWeight.w500,
                            height: 1.60,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
