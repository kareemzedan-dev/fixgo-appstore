import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/components/show_sort_bottom_sheet.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/search_and_filter.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/worker_card.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/filter_sort_bar.dart';
import 'package:fixgo/features/offers/presentation/manager/search_cubit/search_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/search_cubit/search_state.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class SearchResultsView extends StatefulWidget {
  final String query;

  const SearchResultsView({super.key, required this.query});

  @override
  State<SearchResultsView> createState() => _SearchResultsViewState();
}

class _SearchResultsViewState extends State<SearchResultsView> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();

    searchController = TextEditingController(text: widget.query);

    /// 🔥 أهم سطر
    context.read<SearchCubit>().search(widget.query);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _submitSearch(String query) {
    if (query.trim().isEmpty) return;

    context.read<SearchCubit>().search(query.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.p16,
                  vertical: AppSizes.p12,
                ),
                child: Column(
                  children: [
                    /// Search Bar فوق زي التصميم
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              context.go("/search"); // أو "/home" لو عايز
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context).cancel,
                            style: TextStyle(
                              fontSize: AppSizes.sp(14),
                              fontWeight: FontWeight.w500,
                              color: ColorsManager.darkGrey,
                            ),
                          ),
                        ),

                        SizedBox(width: AppSizes.w(12)),

                        Expanded(
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppSizes.r(14),
                              ),
                              color: Colors.grey.shade100,
                            ),
                            child: TextField(
                              controller: searchController,
                              autofocus: false,
                              textAlign: TextAlign.right,
                              textInputAction: TextInputAction.search,
                              onSubmitted: _submitSearch,
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context).search,
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
                      ],
                    ),

                    SizedBox(height: AppSizes.h(20)),

                    /// عدد النتائج
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: BlocBuilder<SearchCubit, SearchState>(
                        builder: (context, state) {
                          return Text(
                            AppLocalizations.of(context).searchResultsInArea(
                              state.results.length,
                              searchController.text,
                            ),
                            style: TextStyle(
                              fontSize: AppSizes.sp(12),
                              color: ColorsManager.darkGrey,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: AppSizes.h(16)),

                    /// Results
                    Expanded(
                      child: BlocBuilder<SearchCubit, SearchState>(
                        builder: (context, state) {
                          /// Loading
                          if (state.isLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          /// Error
                          if (state.error != null) {
                            return Center(child: Text(state.error!));
                          }

                          /// Empty
                          if (state.results.isEmpty) {
                            return Center(
                              child: Text(
                                AppLocalizations.of(context).noResults,
                              ),
                            );
                          }
                          print("🔥 UI RESULTS => ${state.results.length}");

                          for (final item in state.results) {
                            print("✅ UI ITEM => ${item.title}");
                          }

                          /// Worker Cards
                          return ListView.builder(
                            itemCount: state.results.length,
                            itemBuilder: (context, index) {
                              final offer = state.results[index];

                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: AppSizes.h(16),
                                ),
                                child: WorkerCard(
                                  userId: offer.userId,
                                  offerId: offer.id,
                                  name: offer.title ?? "",
                                  job: offer.profession ?? "",
                                  rating: offer.averageRating,
                                  experience: offer.yearsOfExperience
                                      .toString(),
                                  distance: offer.location.toString(),
                                  description: offer.description,
                                  image: offer.imageUrl,
                                  isSponsored: offer.isSponsored || offer.sp,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            FilterSortBar(
              onSort: () {
                final currentState = context.read<SearchCubit>().state;
                showSortBottomSheet(
                  context,
                  onApply: (sortType) {
                    context.read<SearchCubit>().applySort(sortType);
                  },
                  state: currentState,
                );
              },

              onFilter: () {
                final currentState = context.read<SearchCubit>().state;

                showFilterBottomSheet(
                  context,
                  state: currentState,
                  onApply:
                      ({
                        required minRating,
                        required maxRating,
                        required minExperience,
                        required maxExperience,
                        required minDistance,
                        required maxDistance,
                      }) {
                        context.read<SearchCubit>().applyFilter(
                          minRating: minRating,
                          maxRating: maxRating,
                          minExperience: minExperience,
                          maxExperience: maxExperience,
                          minDistance: minDistance,
                          maxDistance: maxDistance,
                        );
                      },
                );
              },
            ),
            SizedBox(height: AppSizes.h(16)),
          ],
        ),
      ),
    );
  }
}
