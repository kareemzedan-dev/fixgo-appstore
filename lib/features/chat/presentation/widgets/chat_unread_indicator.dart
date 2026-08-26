import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class ChatUnreadIndicator extends StatelessWidget {
  final int unreadCount;
  final Future<void> Function()? onDelete;

  const ChatUnreadIndicator({
    super.key,
    required this.unreadCount,
    this.onDelete,
  });

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              /// delete
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: Text(
                  AppLocalizations.of(context).deleteChat,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                tileColor: Colors.white,
                splashColor: Colors.red.withOpacity(0.1),
                onTap: () async {
                  Navigator.pop(bottomSheetContext);

                  /// show loading
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                  );

                  try {
                    await onDelete?.call();

                    Navigator.pop(context); // close loading

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            AppLocalizations.of(context).chatDeleted,
                          ),
                        ),
                      );
                    }
                  } catch (e) {
                    Navigator.pop(context);

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            AppLocalizations.of(context).genericError,
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: unreadCount == 0 ? () => _showOptions(context) : null,
      child: unreadCount == 0
          ? Icon(Icons.more_vert, size: AppSizes.w(18))
          : Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.p6,
                vertical: AppSizes.p4,
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  unreadCount > 99 ? "99+" : unreadCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppSizes.sp(10),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
    );
  }
}
