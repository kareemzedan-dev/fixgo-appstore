import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class SearchAndFilter extends StatefulWidget {
  final Function(String) onSearch;
  final VoidCallback onFilter;

  /// لو true → مجرد ضغط فقط بدون كتابة
  /// لو false → TextField عادي قابل للكتابة
  final bool openSearchPageOnly;

  final bool? showfiler;

  const SearchAndFilter({
    super.key,
    required this.onSearch,
    required this.onFilter,
    this.showfiler = true,
    this.openSearchPageOnly = true,
  });

  @override
  State<SearchAndFilter> createState() => _SearchAndFilterState();
}

class _SearchAndFilterState extends State<SearchAndFilter> {
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          /// Search Field
          Expanded(
            child: Container(
              height: AppSizes.h(60),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),

              /// لو مجرد فتح صفحة فقط
              child: widget.openSearchPageOnly
                  ? InkWell(
                      onTap: () {
                        context.push("/search");
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.w(16),
                        ),
                        decoration: BoxDecoration(
                          color: ColorsManager.darkGrey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              AssetsManager.search,
                              width: AppSizes.w(22),
                            ),

                            SizedBox(width: AppSizes.w(12)),

                            Text(
                              AppLocalizations.of(context).searchForService,
                              style: TextStyle(
                                fontSize: AppSizes.sp(14),
                                color: ColorsManager.darkGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : TextField(
                      controller: searchController,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      textInputAction: TextInputAction.search,
                      cursorColor: ColorsManager.primaryColor,

                      onChanged: (value) {
                        if (!widget.openSearchPageOnly) {
                          widget.onSearch(value);
                        }
                      },

                      /// ✅ Submit
                      onSubmitted: (value) {
                        if (widget.openSearchPageOnly) {
                          context.push("/search", extra: value);
                        } else {
                          widget.onSearch(value);
                        }
                      },

                      decoration: InputDecoration(
                        fillColor: ColorsManager.darkGrey.withOpacity(0.1),
                        hintText: AppLocalizations.of(context).searchForService,
                        hintStyle: TextStyle(
                          fontSize: AppSizes.sp(14),
                          color: ColorsManager.darkGrey,
                        ),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(AppSizes.w(14)),
                          child: Image.asset(
                            AssetsManager.search,
                            width: AppSizes.w(22),
                          ),
                        ),
                      ),
                    ),
            ),
          ),

          if (widget.showfiler == true) ...[
            const SizedBox(width: 12),

            /// Filter Button
            GestureDetector(
              onTap: widget.onFilter,
              child: Container(
                width: AppSizes.w(46),
                height: AppSizes.h(52),
                decoration: BoxDecoration(
                  color: const Color(0xff2A4365),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.tune, color: Colors.white, size: 26),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
