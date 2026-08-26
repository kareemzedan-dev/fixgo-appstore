/// ===============================
/// SearchState
/// ===============================

import '../../../domain/entities/offer_entity.dart';

enum SortType {
  rating,
  experience,
  distance,
}

class SearchState {
  final bool isLoading;
  final List<OfferEntity> results;
  final List<OfferEntity> originalResults;
  final List<String> searchHistory;
  final String query;
  final String? error;

  /// sorting
  final SortType selectedSort;

  /// filtering
  final double minRating;
  final double maxRating;

  final int minExperience;
  final int maxExperience;

  final double minDistance;
  final double maxDistance;

  const SearchState({
    this.isLoading = false,
    this.results = const [],
    this.originalResults = const [],
    this.searchHistory = const [],
    this.query = "",
    this.error,

    this.selectedSort = SortType.rating,

    this.minRating = 0,
    this.maxRating = 5,

    this.minExperience = 1,
    this.maxExperience = 30,

    this.minDistance = 0,
    this.maxDistance = 50,
  });

  SearchState copyWith({
    bool? isLoading,
    List<OfferEntity>? results,
    List<OfferEntity>? originalResults,
    List<String>? searchHistory,
    String? query,
    String? error,

    SortType? selectedSort,

    double? minRating,
    double? maxRating,

    int? minExperience,
    int? maxExperience,

    double? minDistance,
    double? maxDistance,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      results: results ?? this.results,
      originalResults:
          originalResults ?? this.originalResults,
      searchHistory:
          searchHistory ?? this.searchHistory,
      query: query ?? this.query,
      error: error,

      selectedSort:
          selectedSort ?? this.selectedSort,

      minRating: minRating ?? this.minRating,
      maxRating: maxRating ?? this.maxRating,

      minExperience:
          minExperience ?? this.minExperience,
      maxExperience:
          maxExperience ?? this.maxExperience,

      minDistance:
          minDistance ?? this.minDistance,
      maxDistance:
          maxDistance ?? this.maxDistance,
    );
  }
}