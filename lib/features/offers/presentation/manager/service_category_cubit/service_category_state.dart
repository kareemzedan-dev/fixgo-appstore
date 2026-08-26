library;

import 'package:fixgo/features/offers/domain/entities/offer_entity.dart';

abstract class ServiceCategoryState {}

class ServiceCategoryInitial extends ServiceCategoryState {}

class ServiceCategoryLoading extends ServiceCategoryState {}

class ServiceCategoryLoaded extends ServiceCategoryState {
  final List<OfferEntity> offers;

  ServiceCategoryLoaded(this.offers);
}

class ServiceCategoryFailure extends ServiceCategoryState {
  final String message;

  ServiceCategoryFailure(this.message);
}
