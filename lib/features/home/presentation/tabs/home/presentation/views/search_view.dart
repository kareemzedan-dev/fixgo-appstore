import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/search_view_sections.dart';
import 'package:fixgo/features/offers/presentation/manager/search_cubit/search_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/search_cubit/search_state.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    /// تحميل سجل البحث من SharedPreferences
    context.read<SearchCubit>().loadHistory();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _submitSearch(String query) {
    if (query.trim().isEmpty) return;

    final encodedQuery = Uri.encodeComponent(query.trim());

    if (kIsWeb) {
      context.go("/search-results/$encodedQuery");
    } else {
      context.push("/search-results/$encodedQuery");
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final popularSearches = [
      l10n.popularSearchPlumber,
      l10n.popularSearchHomeElectrician,
      l10n.popularSearchProfessionalBlacksmith,
      l10n.popularSearchGypsumBoardInstaller,
      l10n.popularSearchFinishingContractor,
      l10n.popularSearchRenovationContractor,
      l10n.popularSearchAcTechnician,
      l10n.popularSearchHomePainter,
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.p16,
            vertical: AppSizes.p16,
          ),
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchInputHeader(
                      controller: searchController,
                      onSubmitted: _submitSearch,
                      onCancel: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go("/home/home");
                        }
                      },
                    ),
                    SizedBox(height: AppSizes.h(24)),
                    RecentSearchesSection(
                      history: state.searchHistory,
                      onClearAll: () {
                        context.read<SearchCubit>().clearAllHistory();
                      },
                      onSelect: _submitSearch,
                      onRemove: (item) {
                        context.read<SearchCubit>().removeHistoryItem(item);
                      },
                    ),
                    SizedBox(height: AppSizes.h(16)),
                    PopularSearchesSection(
                      searches: popularSearches,
                      onSelect: _submitSearch,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
