// ===============================
// presentation/manager/offer_details_cubit/offer_details_state.dart
// ===============================

import '../../../domain/entities/offer_entity.dart';

abstract class OfferDetailsState {}

class OfferDetailsInitial
    extends OfferDetailsState {}

class OfferDetailsLoading
    extends OfferDetailsState {}

class OfferDetailsSuccess
    extends OfferDetailsState {
  final OfferEntity offer;

  OfferDetailsSuccess(
    this.offer,
  );
}

class OfferDetailsFailure
    extends OfferDetailsState {
  final String message;

  OfferDetailsFailure(
    this.message,
  );
}