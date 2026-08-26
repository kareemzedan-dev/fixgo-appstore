library;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/offers/domain/entities/offer_entity.dart';
import 'package:fixgo/features/offers/domain/use_cases/get_offers_by_category_use_case.dart';

import 'service_category_state.dart';

@injectable
class ServiceCategoryCubit extends Cubit<ServiceCategoryState> {
  final GetOffersByCategoryUseCase getOffersByCategoryUseCase;

  ServiceCategoryCubit(this.getOffersByCategoryUseCase)
    : super(ServiceCategoryInitial());

  /// 👇 نخزن البيانات الأصلية
  List<OfferEntity> _allOffers = [];

  /// ===============================
  /// GET OFFERS
  /// ===============================
  Future<void> getOffersByCategory(String category) async {
    emit(ServiceCategoryLoading());

    try {
      final result = await getOffersByCategoryUseCase(category);

      _allOffers = result; // ✅ حفظ الأصل

      emit(ServiceCategoryLoaded(result));
    } catch (e) {
      emit(ServiceCategoryFailure(e.toString()));
    }
  }

  /// ===============================
  /// SEARCH
  /// ===============================
  void search(String query) {
    if (state is! ServiceCategoryLoaded) return;

    if (query.trim().isEmpty) {
      emit(ServiceCategoryLoaded(_allOffers));
      return;
    }

    final q = query.toLowerCase();

    final filtered = _allOffers.where((offer) {
      final name = (offer.userName ?? "").toLowerCase();
      final job = (offer.profession ?? "").toLowerCase();
      final location = (offer.neighborhood ?? "").toLowerCase();

      return name.contains(q) || job.contains(q) || location.contains(q);
    }).toList();

    emit(ServiceCategoryLoaded(filtered));
  }
}
