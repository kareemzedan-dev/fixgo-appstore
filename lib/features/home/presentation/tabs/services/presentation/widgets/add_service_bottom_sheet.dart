/// presentation/views/widgets/add_service_bottom_sheet.dart
/// مربوط بالكامل مع AddServiceCubit
/// بدون تقليل أي UI
/// Clean Architecture + MVVM
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fixgo/core/components/custom_top_error_message.dart';
import 'package:fixgo/core/services/location_service/get_address_from_lat_lng.dart';
import 'package:fixgo/core/services/location_service/location_service.dart';
import 'package:fixgo/features/offers/presentation/manager/add_service_cubit/add_service_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/add_service_cubit/add_service_state.dart';
import 'package:fixgo/features/offers/presentation/manager/offers_cubit/offers_cubit.dart';
import 'package:fixgo/l10n/app_localizations.dart';

import '../../../../../../../core/session/app_session_cubit.dart';
import '../../../../../../../core/session/app_session_state.dart';
import 'add_service_actions.dart';
import 'add_service_details_fields.dart';
import 'add_service_form_fields.dart';
import 'add_service_image_picker.dart';
import 'add_service_loading_overlay.dart';
import 'add_service_location_section.dart';
import 'add_service_sheet_header.dart';

String _localizeAddServiceMessage(AppLocalizations l10n, String key) {
  switch (key) {
    case 'service_added':
      return l10n.serviceAddedSuccess;
    case 'image_upload_failed':
      return l10n.imageUploadFailed;
    default:
      return key;
  }
}

class AddServiceBottomSheet {
  static Future<void> show(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<AddServiceCubit>(),
          child: const _AddServiceSheet(),
        );
      },
    );
  }
}

class _AddServiceSheet extends StatefulWidget {
  const _AddServiceSheet();

  @override
  State<_AddServiceSheet> createState() => _AddServiceSheetState();
}

class _AddServiceSheetState extends State<_AddServiceSheet> {
  bool _isSubmitting = false;
  List<XFile> selectedImages = [];

  Future<void> pickImage() async {
    final images = await ImagePicker().pickMultiImage();

    if (images.isNotEmpty) {
      setState(() {
        selectedImages.addAll(images);
      });
    }
  }

  void removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String? selectedCategory;
  String? selectedService;
  String? selectedYears;
  double? selectedLat;
  double? selectedLng;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    if (_isSubmitting) return;
    final l10n = AppLocalizations.of(context);

    setState(() {
      _isSubmitting = true;
    });

    try {
      if (selectedCategory == null) {
        showError(l10n.selectServiceCategory);
        return;
      }

      if (selectedService == null) {
        showError(l10n.selectService);
        return;
      }
      if (titleController.text.trim().isEmpty) {
        showError(l10n.enterServiceTitle);
        return;
      }
      if (selectedYears == null) {
        showError(l10n.enterYearsOfExperience);
        return;
      }

      if (descriptionController.text.trim().isEmpty) {
        showError(l10n.enterServiceDescription);
        return;
      }

      if (selectedImages.isEmpty) {
        showError(l10n.selectServiceImage);
        return;
      }
      if (selectedLat == null || selectedLng == null) {
        showError(l10n.selectCurrentLocation);
        return;
      }
      showError(l10n.uploadingImages, isSuccess: true);
      final sessionState = context.read<AppSessionCubit>().state;

      if (sessionState is! AppSessionAuthenticated) {
        showError(l10n.loginRequiredFirst);
        return;
      }

      final user = sessionState.user;

      await context.read<AddServiceCubit>().addService(
        yearsOfExperience: int.parse(selectedYears!.replaceAll("+", "")),
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),

        category: selectedCategory!,
        serviceCategory: selectedService!,

        city: user.city ?? "",
        neighborhood: user.district ?? "",
        latitude: selectedLat!,
        longitude: selectedLng!,

        images: selectedImages,
      );
    } catch (e) {
      showError(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void showError(String message, {bool isSuccess = false}) {
    CustomTopErrorMessage.show(context, message: message, isSuccess: isSuccess);
  }

  Future<void> selectLocation() async {
    final l10n = AppLocalizations.of(context);
    final position = await LocationService.getCurrentLocation(context);

    if (position != null) {
      final address = await getAddressFromLatLng(position);

      setState(() {
        selectedLat = position.latitude;
        selectedLng = position.longitude;
        locationController.text = address;
      });

      showError(l10n.locationSelected, isSuccess: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    return BlocConsumer<AddServiceCubit, AddServiceState>(
      listener: (context, state) {
        if (state is AddServiceSuccess) {
          context.read<OffersCubit>().init();

          showError(
            _localizeAddServiceMessage(
              AppLocalizations.of(context),
              state.message,
            ),
            isSuccess: true,
          );

          Navigator.pop(context);
        }

        if (state is AddServiceFailure) {
          showError(
            _localizeAddServiceMessage(
              AppLocalizations.of(context),
              state.message,
            ),
            isSuccess: false,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AddServiceLoading || _isSubmitting;
        return Stack(
          children: [
            Container(
              padding: EdgeInsetsDirectional.only(
                start: 20,
                end: 20,
                top: 12,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              decoration: BoxDecoration(
                color: isDark ? Color(0Xff1E1E1E) : Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddServiceSheetHeader(title: l10n.addService),
                    const SizedBox(height: 24),
                    AddServiceFormFields(
                      selectedCategory: selectedCategory,
                      selectedService: selectedService,
                      selectedYears: selectedYears,
                      onCategoryChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                      onServiceChanged: (value) {
                        setState(() {
                          selectedService = value;
                        });
                      },
                      onYearsChanged: (value) {
                        setState(() {
                          selectedYears = value;
                        });
                      },
                    ),
                    const SizedBox(height: 18),
                    AddServiceImagePicker(
                      title: l10n.serviceImage,
                      uploadHint: l10n.tapToUploadImage,
                      images: selectedImages,
                      onPickImages: pickImage,
                      onRemoveImage: removeImage,
                    ),
                    const SizedBox(height: 20),

                    AddServiceDetailsFields(
                      titleController: titleController,
                      descriptionController: descriptionController,
                    ),
                    const SizedBox(height: 24),
                    AddServiceLocationSection(
                      controller: locationController,
                      hint: l10n.selectLocation,
                      onSelectLocation: selectLocation,
                    ),
                    const SizedBox(height: 24),

                    AddServiceActions(
                      submitLabel: l10n.addService,
                      cancelLabel: l10n.cancel,
                      isLoading: isLoading,
                      onSubmit: submit,
                      onCancel: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),
            AddServiceLoadingOverlay(
              isLoading: isLoading,
              message: l10n.uploadingService,
            ),
          ],
        );
      },
    );
  }
}
