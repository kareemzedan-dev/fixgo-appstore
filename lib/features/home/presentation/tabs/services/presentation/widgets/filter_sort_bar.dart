import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/l10n/app_localizations.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

class FilterSortBar extends StatelessWidget {
  final VoidCallback onSort;
  final VoidCallback onFilter;

  const FilterSortBar({
    super.key,
    required this.onSort,
    required this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.w(16),
        vertical: AppSizes.h(14),
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0Xff1E1E1E) : Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.r(24)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          /// Sort
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onSort,
              icon: Icon(
                Icons.swap_vert,
                color: isDark ? Colors.white : Colors.black,
                size: AppSizes.sp(24),
              ),
              label: Text(
                AppLocalizations.of(context).sort,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: AppSizes.h(14)),
                side: const BorderSide(color: Color(0xff163E6E)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),

          SizedBox(width: AppSizes.w(12)),

          /// Filter
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onFilter,
              icon: Icon(
                Icons.tune,
                color: isDark ? Colors.white : Colors.black,
                size: AppSizes.sp(24),
              ),
              label: Text(
                AppLocalizations.of(context).filter,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: AppSizes.h(14)),
                side: const BorderSide(color: Color(0xff163E6E)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
