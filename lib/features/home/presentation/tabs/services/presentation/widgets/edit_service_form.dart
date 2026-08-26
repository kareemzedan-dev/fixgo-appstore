import 'package:flutter/material.dart';
import 'package:fixgo/core/components/custom_button.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class EditServiceForm extends StatelessWidget {
  final String selectedCategory;
  final String selectedService;
  final String selectedExperience;
  final List<String> categories;
  final List<String> services;
  final List<String> experiences;
  final String imageUrl;
  final TextEditingController descriptionController;
  final bool isLoading;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<String?> onServiceChanged;
  final ValueChanged<String?> onExperienceChanged;
  final VoidCallback onPickImage;
  final VoidCallback onSubmit;

  const EditServiceForm({
    super.key,
    required this.selectedCategory,
    required this.selectedService,
    required this.selectedExperience,
    required this.categories,
    required this.services,
    required this.experiences,
    required this.imageUrl,
    required this.descriptionController,
    required this.isLoading,
    required this.onCategoryChanged,
    required this.onServiceChanged,
    required this.onExperienceChanged,
    required this.onPickImage,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.w(20),
        vertical: AppSizes.h(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _ServiceDropdown(
                  title: AppLocalizations.of(context).serviceCategory,
                  value: selectedCategory,
                  items: categories,
                  onChanged: onCategoryChanged,
                ),
              ),
              SizedBox(width: AppSizes.w(12)),
              Expanded(
                child: _ServiceDropdown(
                  title: AppLocalizations.of(context).service,
                  value: selectedService,
                  items: services,
                  onChanged: onServiceChanged,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.h(20)),
          _ServiceDropdown(
            title: AppLocalizations.of(context).yearsExperience,
            value: selectedExperience,
            items: experiences,
            onChanged: onExperienceChanged,
          ),
          SizedBox(height: AppSizes.h(24)),
          Text(
            AppLocalizations.of(context).serviceImage,
            style: TextStyle(
              fontSize: AppSizes.sp(15),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppSizes.h(12)),
          InkWell(
            onTap: isLoading ? null : onPickImage,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: AppSizes.r(42),
                  backgroundImage: imageUrl.isNotEmpty
                      ? NetworkImage(imageUrl)
                      : null,
                  child: imageUrl.isEmpty ? const Icon(Icons.image) : null,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: AppSizes.w(30),
                    height: AppSizes.h(30),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1D3964),
                      shape: BoxShape.circle,
                    ),
                    child: isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(6),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(
                            Icons.camera_alt_outlined,
                            size: 18,
                            color: Colors.white,
                          ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSizes.h(24)),
          Text(
            AppLocalizations.of(context).serviceBio,
            style: TextStyle(
              fontSize: AppSizes.sp(15),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppSizes.h(12)),
          TextFormField(
            controller: descriptionController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context).writeServiceBio,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
              ),
            ),
          ),
          SizedBox(height: AppSizes.h(32)),
          CustomButton(
            text: AppLocalizations.of(context).editService,
            onPressed: onSubmit,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }
}

class _ServiceDropdown extends StatelessWidget {
  final String title;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _ServiceDropdown({
    required this.title,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: AppSizes.sp(14),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: AppSizes.h(8)),
        DropdownButtonFormField<String>(
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          initialValue: value,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizes.w(14),
              vertical: AppSizes.h(14),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
            ),
          ),
          items: items
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: AppSizes.sp(13)),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
