import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fixgo/core/helper/dashed_border_painter.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';

class AddServiceImagePicker extends StatelessWidget {
  const AddServiceImagePicker({
    super.key,
    required this.title,
    required this.uploadHint,
    required this.images,
    required this.onPickImages,
    required this.onRemoveImage,
  });

  final String title;
  final String uploadHint;
  final List<XFile> images;
  final VoidCallback onPickImages;
  final ValueChanged<int> onRemoveImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: AppSizes.h(150),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: images.length + 1,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              if (index == images.length) {
                return GestureDetector(
                  onTap: onPickImages,
                  child: Container(
                    width: AppSizes.w(110),
                    height: AppSizes.h(150),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: CustomPaint(
                      painter: DashedBorderPainter(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 18,
                            backgroundColor: Color(0xffF2F4F7),
                            child: Icon(
                              Icons.file_upload_outlined,
                              color: Color(0xff29466F),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            uploadHint,
                            style: const TextStyle(
                              color: ColorsManager.primaryColor,
                              fontSize: 12,
                              fontFamily: 'Alyamama',
                              fontWeight: FontWeight.w600,
                              height: 1.60,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return Stack(
                children: [
                  Container(
                    width: AppSizes.w(110),
                    height: AppSizes.h(150),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: kIsWeb
                          ? Image.network(
                              images[index].path,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            )
                          : Image.file(
                              File(images[index].path),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    left: 6,
                    child: GestureDetector(
                      onTap: () => onRemoveImage(index),
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
