import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fixgo/core/components/custom_button.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class StoryImagePicker extends StatelessWidget {
  final XFile? selectedImage;
  final bool isUploading;
  final VoidCallback onTap;

  const StoryImagePicker({
    super.key,
    required this.selectedImage,
    required this.isUploading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: isUploading ? null : onTap,
        child: Container(
          width: AppSizes.w(120),
          height: AppSizes.h(140),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey),
          ),
          child: selectedImage == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.file_upload_outlined,
                      size: AppSizes.sp(30),
                      color: ColorsManager.primaryColor,
                    ),
                    SizedBox(height: AppSizes.h(10)),
                    Text(
                      AppLocalizations.of(context).verificationTapToUpload,
                      style: TextStyle(
                        fontSize: AppSizes.sp(12),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: kIsWeb
                      ? Image.network(
                          selectedImage!.path,
                          width: AppSizes.w(120),
                          height: AppSizes.h(20),
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(selectedImage!.path),
                          width: AppSizes.w(120),
                          height: AppSizes.h(20),
                          fit: BoxFit.cover,
                        ),
                ),
        ),
      ),
    );
  }
}

class StoryActionButtons extends StatelessWidget {
  final bool isUploading;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  const StoryActionButtons({
    super.key,
    required this.isUploading,
    required this.onSubmit,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: isUploading
                ? AppLocalizations.of(context).uploading
                : AppLocalizations.of(context).addStory,
            onPressed: isUploading ? () {} : onSubmit,
          ),
        ),
        SizedBox(width: AppSizes.w(16)),
        TextButton(
          onPressed: isUploading ? null : onCancel,
          child: Text(
            AppLocalizations.of(context).cancel,
            style: TextStyle(fontSize: AppSizes.sp(14)),
          ),
        ),
      ],
    );
  }
}
