import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

enum VerificationFailure {
  incompleteImages,
  submitFailed,
}

class VerificationState extends Equatable {
  final bool isLoading;
  final bool isSubmitting;
  final String status;
  final XFile? frontImage;
  final XFile? backImage;
  final VerificationFailure? failure;
  final bool submitSuccess;

  const VerificationState({
    this.isLoading = true,
    this.isSubmitting = false,
    this.status = 'not_verified',
    this.frontImage,
    this.backImage,
    this.failure,
    this.submitSuccess = false,
  });

  bool get canSubmit => frontImage != null && backImage != null;

  VerificationState copyWith({
    bool? isLoading,
    bool? isSubmitting,
    String? status,
    XFile? frontImage,
    XFile? backImage,
    VerificationFailure? failure,
    bool clearFailure = false,
    bool? submitSuccess,
    bool clearFrontImage = false,
    bool clearBackImage = false,
  }) {
    return VerificationState(
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      status: status ?? this.status,
      frontImage: clearFrontImage ? null : (frontImage ?? this.frontImage),
      backImage: clearBackImage ? null : (backImage ?? this.backImage),
      failure: clearFailure ? null : (failure ?? this.failure),
      submitSuccess: submitSuccess ?? this.submitSuccess,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSubmitting,
        status,
        frontImage,
        backImage,
        failure,
        submitSuccess,
      ];
}
