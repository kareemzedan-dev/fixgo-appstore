import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fixgo/core/components/custom_app_bar.dart';
import 'package:fixgo/core/components/custom_top_error_message.dart';
import 'package:fixgo/core/constants/service_categories.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/edit_service_form.dart';
import 'package:fixgo/features/offers/domain/entities/offer_entity.dart';
import 'package:fixgo/features/offers/presentation/manager/offers_cubit/offers_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/update_offer_cubit/update_offer_cubit.dart';
import 'package:fixgo/features/offers/presentation/manager/update_offer_cubit/update_offer_states.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class EditServiceView extends StatefulWidget {
  final OfferEntity offer;

  const EditServiceView({super.key, required this.offer});

  @override
  State<EditServiceView> createState() => _EditServiceViewState();
}

class _EditServiceViewState extends State<EditServiceView> {
  late String selectedCategory;
  late String selectedService;
  late String selectedExperience;
  late TextEditingController descriptionController;
  late String imageUrl;
  bool isLoading = false;

  final List<String> experiences = ["1", "2", "3", "5", "8", "10+"];

  List<String> get currentServices =>
      ServiceCategories.getServicesByCategory(selectedCategory);

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.offer.category.isNotEmpty
        ? widget.offer.category
        : ServiceCategories.mainCategories.first;

    final availableServices = ServiceCategories.getServicesByCategory(
      selectedCategory,
    );
    selectedService = availableServices.contains(widget.offer.serviceCategory)
        ? widget.offer.serviceCategory
        : availableServices.first;
    selectedExperience = widget.offer.yearsOfExperience.toString().isNotEmpty
        ? widget.offer.yearsOfExperience.toString()
        : "1";
    descriptionController = TextEditingController(
      text: widget.offer.description,
    );
    imageUrl = widget.offer.imageUrl;
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (image == null || !mounted) return;

    setState(() => isLoading = true);
    try {
      final uploadedUrl = await context
          .read<UpdateOfferCubit>()
          .uploadOfferImage(image);
      if (!mounted) return;
      setState(() => imageUrl = uploadedUrl);
      CustomTopErrorMessage.show(
        context,
        message: AppLocalizations.of(context).imageUpdatedSuccess,
        isSuccess: true,
      );
    } catch (_) {
      if (!mounted) return;
      CustomTopErrorMessage.show(
        context,
        message: AppLocalizations.of(context).imageUploadFailed,
      );
    }

    if (!mounted) return;
    setState(() => isLoading = false);
  }

  void updateService() {
    if (descriptionController.text.trim().isEmpty) {
      CustomTopErrorMessage.show(
        context,
        message: AppLocalizations.of(context).serviceBioRequired,
      );
      return;
    }

    context.read<UpdateOfferCubit>().updateOffer(
      offerId: widget.offer.id,
      title: descriptionController.text.trim(),
      description: descriptionController.text.trim(),
      category: selectedCategory,
      serviceCategory: selectedService,
      yearsOfExperience:
          int.tryParse(selectedExperience.replaceAll("+", "")) ?? 1,
      imageUrl: imageUrl,
      images: widget.offer.images,
      location: widget.offer.location,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateOfferCubit, UpdateOfferStates>(
      listener: _handleUpdateState,
      child: Scaffold(
        appBar: CustomAppBar(title: AppLocalizations.of(context).editService),
        body: EditServiceForm(
          selectedCategory: selectedCategory,
          selectedService: selectedService,
          selectedExperience: selectedExperience,
          categories: ServiceCategories.mainCategories,
          services: currentServices,
          experiences: experiences,
          imageUrl: imageUrl,
          descriptionController: descriptionController,
          isLoading: isLoading,
          onCategoryChanged: (value) {
            if (value == null) return;
            setState(() {
              selectedCategory = value;
              selectedService = ServiceCategories.getServicesByCategory(
                value,
              ).first;
            });
          },
          onServiceChanged: (value) {
            if (value == null) return;
            setState(() => selectedService = value);
          },
          onExperienceChanged: (value) {
            if (value == null) return;
            setState(() => selectedExperience = value);
          },
          onPickImage: pickImage,
          onSubmit: updateService,
        ),
      ),
    );
  }

  Future<void> _handleUpdateState(
    BuildContext context,
    UpdateOfferStates state,
  ) async {
    if (state is UpdateOfferLoading) {
      setState(() => isLoading = true);
    }
    if (state is UpdateOfferSuccess) {
      setState(() => isLoading = false);
      final offersCubit = context.read<OffersCubit>();
      await offersCubit.getOffers();
      await offersCubit.getNearbyOffers();
      await offersCubit.getRecommendedOffers();

      if (!context.mounted) return;
      CustomTopErrorMessage.show(
        context,
        message: AppLocalizations.of(context).serviceUpdatedSuccess,
        isSuccess: true,
      );
      context.pop(true);
      return;
    }
    if (state is UpdateOfferFailure) {
      setState(() => isLoading = false);
      if (context.mounted) {
        CustomTopErrorMessage.show(context, message: state.message);
      }
    }
  }
}
