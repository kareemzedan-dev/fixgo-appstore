/// ===============================
/// add_story_bottom_sheet.dart
/// النسخة الكاملة بعد الربط الحقيقي
/// مربوط بـ StoriesCubit مع دعم Web + Mobile
/// ===============================

library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:image_picker/image_picker.dart';

import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/story_form_widgets.dart';
import 'package:fixgo/features/stories/presentation/manager/stories_cubit/stories_cubit.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class AddStoryBottomSheet extends StatefulWidget {
  const AddStoryBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<StoriesCubit>(),
          child: const AddStoryBottomSheet(),
        );
      },
    );
  }

  @override
  State<AddStoryBottomSheet> createState() => _AddStoryBottomSheetState();
}

class _AddStoryBottomSheetState extends State<AddStoryBottomSheet> {
  final TextEditingController storyController = TextEditingController();

  XFile? selectedImage;

  bool isUploading = false;

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  /// ===============================
  /// Pick Image
  /// ===============================

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  /// ===============================
  /// Submit Story
  /// ===============================

  Future<void> submitStory() async {
    final text = storyController.text.trim();

    if (text.isEmpty && selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).storyEmptyContent)),
      );
      return;
    }
    try {
      setState(() {
        isUploading = true;
      });

      /// إضافة الحالة
      await context.read<StoriesCubit>().addStory(
        text: text,
        storyImage: selectedImage,
      );

      if (!mounted) return;
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).storyAddedSuccess)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() {
          isUploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.only(
        left: AppSizes.w(20),
        right: AppSizes.w(20),
        top: AppSizes.h(16),
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSizes.h(20),
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0Xff1E1E1E) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Handle
          Center(
            child: Container(
              width: AppSizes.w(60),
              height: AppSizes.h(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          SizedBox(height: AppSizes.h(20)),

          /// Title
          Row(
            children: [
              Container(
                width: AppSizes.w(5),
                height: AppSizes.h(24),
                decoration: BoxDecoration(
                  color: ColorsManager.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(width: AppSizes.w(8)),
              Text(
                AppLocalizations.of(context).addStory,
                style: TextStyle(
                  fontSize: AppSizes.sp(16),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          SizedBox(height: AppSizes.h(24)),

          StoryImagePicker(
            selectedImage: selectedImage,
            isUploading: isUploading,
            onTap: pickImage,
          ),

          SizedBox(height: AppSizes.h(28)),

          /// Label
          Text(
            AppLocalizations.of(context).storyText,
            style: TextStyle(
              fontSize: AppSizes.sp(16),
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: AppSizes.h(12)),

          /// TextField
          TextField(
            controller: storyController,
            maxLines: 3,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context).storyTextHint,
              hintStyle: TextStyle(fontSize: AppSizes.sp(12)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          SizedBox(height: AppSizes.h(16)),

          /// Note
          Center(
            child: Text(
              AppLocalizations.of(context).storyVisible24Hours,
              style: TextStyle(fontSize: AppSizes.sp(13), color: Colors.grey),
            ),
          ),

          SizedBox(height: AppSizes.h(24)),

          StoryActionButtons(
            isUploading: isUploading,
            onSubmit: submitStory,
            onCancel: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
