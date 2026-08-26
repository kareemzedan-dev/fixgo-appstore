import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/chat/presentation/widgets/custom_chat_header.dart';
import 'package:fixgo/features/notifications/domain/entities/notification_entity.dart';
import 'package:fixgo/features/notifications/presentation/manager/notifications_cubit.dart';
import 'package:fixgo/features/notifications/presentation/widgets/notification_card.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class NotificationsView extends StatefulWidget {
  final String userId;

  const NotificationsView({super.key, required this.userId});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationsCubit>().listen(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSizes.h(16)),
            CustomChatHeader(
              title: l10n.notificationsTitle,
              showEditButton: false,
            ),
            SizedBox(height: AppSizes.h(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: GestureDetector(
                      onTap: () {
                        context.read<NotificationsCubit>().markAllAsRead(
                          widget.userId,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE8E8E8)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          l10n.notificationsMarkAllRead,
                          style: const TextStyle(
                            color: Color(0xFF2876E4),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      context.read<NotificationsCubit>().deleteAllNotifications(
                        widget.userId,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        l10n.notificationsDeleteAll,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.h(14)),
            Expanded(
              child: BlocBuilder<NotificationsCubit, List<NotificationEntity>>(
                builder: (context, notifications) {
                  if (notifications.isEmpty) {
                    return Center(child: Text(l10n.notificationsEmpty));
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: notifications.length,
                    separatorBuilder: (_, __) =>
                        SizedBox(height: AppSizes.h(14)),
                    itemBuilder: (context, index) {
                      return NotificationCard(
                        notification: notifications[index],
                        userId: widget.userId,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Keep helper exports used by NotificationCard
bool isNotificationImage(String text) {
  return text.endsWith('.jpg') ||
      text.endsWith('.png') ||
      text.endsWith('.jpeg');
}

bool isNotificationFile(String text) {
  return text.contains('firebase') && !isNotificationImage(text);
}

void handleNotificationNavigation(
  BuildContext context,
  NotificationEntity notification,
) {
  switch (notification.type) {
    case 'chat':
      context.push('/chat-details/${notification.otherUserId}');
      break;
    case 'rating':
      context.push(
        '/service-details/${notification.offerId}/${notification.otherUserId ?? ''}',
      );
      break;
    case 'profile_view':
    case 'profile_update':
      context.push('/profile');
      break;
    case 'favorite':
      context.push('/home/favorite');
      break;
    case 'nearby_job':
      context.push('/home');
      break;
    case 'verification':
      context.push('/settings');
      break;
    default:
      debugPrint('Unknown notification type');
  }
}
