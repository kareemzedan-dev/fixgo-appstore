import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/verification/domain/use_cases/get_verification_status_use_case.dart';
import 'package:fixgo/features/verification/domain/use_cases/pick_verification_image_use_case.dart';
import 'package:fixgo/features/verification/domain/use_cases/submit_verification_use_case.dart';
import 'package:fixgo/features/verification/presentation/manager/verification_cubit/verification_state.dart';

@injectable
class VerificationCubit extends Cubit<VerificationState> {
  final GetVerificationStatusUseCase getVerificationStatusUseCase;
  final SubmitVerificationUseCase submitVerificationUseCase;
  final PickVerificationImageUseCase pickVerificationImageUseCase;

  VerificationCubit(
    this.getVerificationStatusUseCase,
    this.submitVerificationUseCase,
    this.pickVerificationImageUseCase,
  ) : super(const VerificationState());

  Future<void> loadStatus() async {
    emit(
      state.copyWith(isLoading: true, clearFailure: true, submitSuccess: false),
    );

    try {
      final status = await getVerificationStatusUseCase();
      emit(state.copyWith(isLoading: false, status: status));
    } catch (_) {
      emit(state.copyWith(isLoading: false, status: 'not_verified'));
    }
  }

  Future<void> pickFrontImage() async {
    final image = await pickVerificationImageUseCase();
    if (image == null) return;

    emit(
      state.copyWith(
        frontImage: image,
        clearFailure: true,
        submitSuccess: false,
      ),
    );
  }

  Future<void> pickBackImage() async {
    final image = await pickVerificationImageUseCase();
    if (image == null) return;

    emit(
      state.copyWith(
        backImage: image,
        clearFailure: true,
        submitSuccess: false,
      ),
    );
  }

  Future<void> submitVerification() async {
    if (!state.canSubmit) {
      emit(
        state.copyWith(
          failure: VerificationFailure.incompleteImages,
          submitSuccess: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isSubmitting: true,
        clearFailure: true,
        submitSuccess: false,
      ),
    );

    try {
      await submitVerificationUseCase(
        frontImage: state.frontImage!,
        backImage: state.backImage!,
      );

      emit(
        state.copyWith(
          isSubmitting: false,
          submitSuccess: true,
          status: 'pending',
          clearFrontImage: true,
          clearBackImage: true,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isSubmitting: false,
          failure: VerificationFailure.submitFailed,
          submitSuccess: false,
        ),
      );
    }
  }

  void clearFeedback() {
    emit(state.copyWith(clearFailure: true, submitSuccess: false));
  }
}
