import 'package:fixgo/features/offers/domain/entities/boost_offer_status_entity.dart';

sealed class BoostOfferState {
  const BoostOfferState();
}

class BoostOfferLoading extends BoostOfferState {
  const BoostOfferLoading();
}

class BoostOfferLoaded extends BoostOfferState {
  final BoostOfferStatusEntity status;

  const BoostOfferLoaded(this.status);
}

class BoostOfferFailure extends BoostOfferState {
  final String message;

  const BoostOfferFailure(this.message);
}
