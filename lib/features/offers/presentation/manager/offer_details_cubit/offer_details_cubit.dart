// ===============================
// presentation/manager/offer_details_cubit/offer_details_cubit.dart
// ===============================

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/get_offer_details_use_case.dart';
import 'offer_details_state.dart';

@injectable
class OfferDetailsCubit
    extends Cubit<
        OfferDetailsState> {
  final GetOfferDetailsUseCase
      getOfferDetailsUseCase;

  OfferDetailsCubit(
    this.getOfferDetailsUseCase,
  ) : super(
          OfferDetailsInitial(),
        );

  Future<void> getOfferDetails(
    String offerId,
  ) async {
    emit(
      OfferDetailsLoading(),
    );

    try {
      final result =
          await getOfferDetailsUseCase(
        offerId: offerId,
      );

      emit(
        OfferDetailsSuccess(
          result,
        ),
      );
    } catch (e) {
      emit(
        OfferDetailsFailure(
          e.toString(),
        ),
      );
    }
  }
}