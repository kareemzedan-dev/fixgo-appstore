import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fixgo/core/helper/dashed_border_painter.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class VerificationUploadCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final XFile? image;
  final VoidCallback onTap;

  const VerificationUploadCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: Color(0xFFE5E5E5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.badge_outlined,
                  size: 18,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: AppSizes.w(10)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: AppSizes.sp(14),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: AppSizes.h(4)),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: AppSizes.sp(12),
                        color: ColorsManager.darkGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.h(16)),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: GestureDetector(
              onTap: onTap,
              child: image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: kIsWeb
                          ? Image.network(
                              image!.path,
                              width: 140,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(image!.path),
                              width: 140,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                    )
                  : CustomPaint(
                      painter: DashedBorderPainter(),
                      child: Container(
                        width: 140,
                        height: 100,
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.file_upload_outlined,
                              color: Color(0xFF1D3964),
                              size: 28,
                            ),
                            SizedBox(height: AppSizes.h(8)),
                            Text(
                              l10n.verificationTapToUpload,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: AppSizes.sp(12),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
