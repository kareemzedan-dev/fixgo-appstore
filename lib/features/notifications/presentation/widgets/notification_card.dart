import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/features/notifications/domain/entities/notification_entity.dart';
import 'package:fixgo/features/notifications/presentation/manager/notifications_cubit.dart';
import 'package:fixgo/features/notifications/presentation/views/notifications_view.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class NotificationCard extends StatelessWidget {
  final NotificationEntity notification;
  final String userId;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final isUnread = !notification.isRead;
    final title = notification.localizedTitle(languageCode);
    final body = notification.localizedBody(languageCode);

    return GestureDetector(
      onTap: () async {
        await context.read<NotificationsCubit>().markAsRead(
          userId,
          notification.id,
        );
        if (!context.mounted) return;
        handleNotificationNavigation(context, notification);
      },
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (_) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.delete, color: Colors.red),
                    title: Text(
                      l10n.notificationsDeleteOne,
                      style: const TextStyle(color: Colors.red),
                    ),
                    tileColor: Colors.white,
                    splashColor: Colors.red.withOpacity(0.1),
                    onTap: () {
                      Navigator.pop(context);
                      context.read<NotificationsCubit>().deleteNotification(
                        userId,
                        notification.id,
                      );
                    },
                  ),
                  SizedBox(height: AppSizes.h(10)),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0Xff151515) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            width: AppSizes.w(1),
            color: isUnread
                ? ColorsManager.info
                : isDark
                ? const Color(0Xff1E1E13)
                : const Color(0xFFE5E5E5),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0Xff1E1E1E)
                        : const Color(0xFFF0F0F1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset(
                    AssetsManager.settings4,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(width: AppSizes.w(12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: AppSizes.h(6)),
                      _buildMessage(body, l10n),
                    ],
                  ),
                ),
                if (isUnread)
                  const CircleAvatar(radius: 4, backgroundColor: Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(String text, AppLocalizations l10n) {
    if (isNotificationImage(text)) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          text,
          height: 120,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }

    if (isNotificationFile(text)) {
      return Row(
        children: [
          const Icon(Icons.attach_file),
          SizedBox(width: AppSizes.w(6)),
          Expanded(
            child: Text(
              l10n.notificationsAttachedFile,
              style: const TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      );
    }

    return Text(text);
  }
}
