 

library;

abstract class UpdateOfferStates {}

class UpdateOfferInitial
    extends UpdateOfferStates {}

class UpdateOfferLoading
    extends UpdateOfferStates {}

class UpdateOfferSuccess
    extends UpdateOfferStates {}

class UpdateOfferFailure
    extends UpdateOfferStates {
  final String message;

  UpdateOfferFailure(
    this.message,
  );
}