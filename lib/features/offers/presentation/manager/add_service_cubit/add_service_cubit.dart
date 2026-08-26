/// presentation/manager/add_service_cubit/add_service_cubit.dart
library;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/offers/domain/entities/add_service_entity.dart';
import 'package:fixgo/features/offers/domain/use_cases/add_service_use_case.dart';
import 'package:fixgo/features/offers/domain/use_cases/upload_offer_images_use_case.dart';

import 'add_service_state.dart';

@injectable
class AddServiceCubit extends Cubit<AddServiceState> {
  final AddServiceUseCase addServiceUseCase;
  final UploadOfferImagesUseCase uploadOfferImagesUseCase;

  AddServiceCubit(this.addServiceUseCase, this.uploadOfferImagesUseCase)
    : super(AddServiceInitial());

  Future<void> addService({
    required String title,
    required String description,
    required String city,
    required String neighborhood,
    required String category,
    required String serviceCategory,
    required double latitude,
    required double longitude,
    required List<XFile> images,
    required int yearsOfExperience,
  }) async {
    emit(AddServiceLoading());

    try {
      final uploadedImages = await uploadOfferImagesUseCase(
        images: images,
        folderName: "offers",
      );

      if (uploadedImages.isEmpty) {
        emit(AddServiceFailure('image_upload_failed'));
        return;
      }

      final service = AddServiceEntity(
        title: title,
        description: description,
        city: city,
        neighborhood: neighborhood,
        category: category,
        serviceCategory: serviceCategory,
        latitude: latitude,
        longitude: longitude,
        images: uploadedImages,
        yearsOfExperience: yearsOfExperience,
      );

      await addServiceUseCase.call(service: service);

      emit(AddServiceSuccess('service_added'));
    } catch (e) {
      emit(AddServiceFailure(e.toString()));
    }
  }

  void resetState() {
    emit(AddServiceInitial());
  }
}
