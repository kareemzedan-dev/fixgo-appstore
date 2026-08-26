import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/offers/domain/entities/boost_offer_status_entity.dart';
import 'package:fixgo/features/offers/domain/use_cases/watch_boost_offer_status_use_case.dart';

import 'boost_offer_state.dart';

@injectable
class BoostOfferCubit extends Cubit<BoostOfferState> {
  final WatchBoostOfferStatusUseCase watchBoostOfferStatusUseCase;
  StreamSubscription<BoostOfferStatusEntity>? _subscription;

  BoostOfferCubit(this.watchBoostOfferStatusUseCase)
    : super(const BoostOfferLoading());

  void watch(String offerId) {
    emit(const BoostOfferLoading());
    _subscription?.cancel();
    _subscription = watchBoostOfferStatusUseCase(offerId).listen(
      (status) => emit(BoostOfferLoaded(status)),
      onError: (Object error, StackTrace stackTrace) {
        emit(BoostOfferFailure(error.toString()));
      },
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
