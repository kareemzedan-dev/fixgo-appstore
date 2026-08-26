import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatDocumentMessage extends StatelessWidget {
  final String fileUrl;
  final String fileName;
  final int fileSize;
  final String extension;
  final bool isMe;

  const ChatDocumentMessage({
    super.key,
    required this.fileUrl,
    required this.fileName,
    required this.fileSize,
    required this.extension,
    required this.isMe,
  });

  String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return "$bytes B";
    } else if (bytes < 1024 * 1024) {
      return "${(bytes / 1024).toStringAsFixed(1)} KB";
    } else {
      return "${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB";
    }
  }

  IconData getFileIcon() {
    final ext = extension.toLowerCase();
    if (ext == "pdf") return Icons.picture_as_pdf;
    if (ext == "doc" || ext == "docx") return Icons.description;
    if (ext == "xls" || ext == "xlsx") return Icons.table_chart;
    if (ext == "ppt" || ext == "pptx") return Icons.slideshow;
    if (ext == "zip" || ext == "rar") return Icons.folder_zip;
    return Icons.insert_drive_file;
  }

  Future<void> openFile() async {
    final uri = Uri.parse(fileUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: AppSizes.w(220),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF1E3A6D) : Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.r(20)),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: AppSizes.r(10),
              offset: Offset(0, AppSizes.h(4)),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Preview Header
            Container(
              height: AppSizes.h(120),
              width: double.infinity,
              decoration: BoxDecoration(
                color: isMe ? const Color(0xFF29466F) : const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.r(20)),
                  topRight: Radius.circular(AppSizes.r(20)),
                ),
              ),
              child: Center(
                child: Icon(
                  getFileIcon(),
                  size: AppSizes.w(52),
                  color: isMe ? Colors.white : ColorsManager.primaryColor,
                ),
              ),
            ),
            // File Info
            Padding(
              padding: EdgeInsets.all(AppSizes.p14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fileName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black87,
                      fontSize: AppSizes.sp(15),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: AppSizes.h(8)),
                  Row(
                    children: [
                      Text(
                        extension.toUpperCase(),
                        style: TextStyle(
                          color: isMe ? Colors.white70 : Colors.grey.shade600,
                          fontSize: AppSizes.sp(12),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: AppSizes.w(8)),
                      Container(
                        width: AppSizes.w(4),
                        height: AppSizes.h(4),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.white54 : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: AppSizes.w(8)),
                      Text(
                        formatFileSize(fileSize),
                        style: TextStyle(
                          color: isMe ? Colors.white70 : Colors.grey.shade600,
                          fontSize: AppSizes.sp(12),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.h(16)),
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: openFile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isMe
                                ? Colors.white
                                : ColorsManager.primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppSizes.r(14),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.download,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: AppSizes.sp(14),
                                  color: isMe
                                      ? ColorsManager.primaryColor
                                      : Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: AppSizes.w(10)),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: openFile,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: isMe
                                  ? Colors.white54
                                  : ColorsManager.primaryColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppSizes.r(14),
                              ),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.open,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: AppSizes.sp(14),
                              color: isMe
                                  ? Colors.white
                                  : ColorsManager.primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
