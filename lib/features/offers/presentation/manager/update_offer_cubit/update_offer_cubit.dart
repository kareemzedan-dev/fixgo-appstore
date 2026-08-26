library;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/offers/domain/use_cases/upload_offer_image_use_case.dart';

import '../../../domain/use_cases/update_offer_use_case.dart';
import 'update_offer_states.dart';

@injectable
class UpdateOfferCubit extends Cubit<UpdateOfferStates> {
  final UpdateOfferUseCase updateOfferUseCase;
  final UploadOfferImageUseCase uploadOfferImageUseCase;

  UpdateOfferCubit(this.updateOfferUseCase, this.uploadOfferImageUseCase)
    : super(UpdateOfferInitial());

  Future<String> uploadOfferImage(XFile image) {
    return uploadOfferImageUseCase(image: image, folderName: "offers_images");
  }

  Future<void> updateOffer({
    required String offerId,
    required String title,
    required String description,
    required String category,
    required String serviceCategory,
    required int yearsOfExperience,
    required String imageUrl,
    required List<String> images,
    required String location,
  }) async {
    emit(UpdateOfferLoading());

    try {
      await updateOfferUseCase.call(
        offerId: offerId,
        title: title,
        description: description,
        category: category,
        serviceCategory: serviceCategory,
        yearsOfExperience: yearsOfExperience,
        imageUrl: imageUrl,
        images: images,
        location: location,
      );

      emit(UpdateOfferSuccess());
    } catch (e) {
      emit(UpdateOfferFailure(e.toString()));
    }
  }
}
