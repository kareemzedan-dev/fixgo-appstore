import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/core/session/app_session_state.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/features/chat/presentation/manager/chats_cubit/chats_cubit.dart';
import 'package:fixgo/features/chat/presentation/manager/chats_cubit/chats_state.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import 'package:fixgo/features/notifications/domain/entities/notification_entity.dart';
import 'package:fixgo/features/notifications/presentation/manager/notifications_cubit.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  int _getUnreadChatsCount(ChatsState state) {
    if (state is ChatsLoaded) {
      return state.chats.fold(0, (total, chat) => total + chat.unreadCount);
    }

    return 0;
  }

  String _getSubtitle(BuildContext context, String? role) {
    if (role == "worker" || role == 'company') {
      return AppLocalizations.of(context).workerHomeSubtitle;
    }

    return AppLocalizations.of(context).customerHomeSubtitle;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSessionCubit, AppSessionState>(
      builder: (context, sessionState) {
        String userName = AppLocalizations.of(context).user;
        String? role;

        if (sessionState is AppSessionAuthenticated) {
          userName = sessionState.user.name;

          role = sessionState.user.type;
        }

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.p20,
            vertical: AppSizes.p16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 👇 الحل هنا
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            AppLocalizations.of(context).homeGreeting(userName),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: AppSizes.sp(20),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        SizedBox(width: AppSizes.w(4)),

                        Image.asset(
                          AssetsManager.hi,
                          width: AppSizes.w(16),
                          height: AppSizes.w(16),
                        ),
                      ],
                    ),

                    SizedBox(height: AppSizes.h(4)),

                    Text(
                      _getSubtitle(context, role),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: AppSizes.sp(12),
                        fontWeight: FontWeight.w600,
                        color: ColorsManager.darkGrey,
                      ),
                    ),
                  ],
                ),
              ),

              /// Right Section
              BlocBuilder<ChatsCubit, ChatsState>(
                builder: (context, chatState) {
                  final unreadCount = _getUnreadChatsCount(chatState);

                  return Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (kIsWeb) {
                            context.go('/chats');
                          } else {
                            context.push('/chats');
                          }
                        },
                        child: NotificationIcon(
                          icon: AssetsManager.chatBubbleOutline,
                          count: unreadCount,
                        ),
                      ),

                      SizedBox(width: AppSizes.w(12)),

                      BlocBuilder<AppSessionCubit, AppSessionState>(
                        builder: (context, sessionState) {
                          if (sessionState is AppSessionAuthenticated) {
                            final userId = sessionState.user.uid;

                            /// 🔥 تشغيل الاستماع (مرة واحدة)
                            context.read<NotificationsCubit>().listen(userId);

                            return BlocBuilder<
                              NotificationsCubit,
                              List<NotificationEntity>
                            >(
                              builder: (context, state) {
                                final unreadCount = context
                                    .read<NotificationsCubit>()
                                    .unreadCount;

                                return InkWell(
                                  onTap: () {
                                    context.push("/notifications");
                                  },
                                  child: NotificationIcon(
                                    icon: AssetsManager.settings4,
                                    count: unreadCount,
                                  ),
                                );
                              },
                            );
                          }

                          return const SizedBox();
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class NotificationIcon extends StatelessWidget {
  final String icon;
  final int count;

  const NotificationIcon({super.key, required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: AppSizes.w(40),
          height: AppSizes.h(40),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark ? const Color(0Xff1E1E1E) : ColorsManager.grey,
          ),
          child: Center(
            child: Image.asset(
              color: isDark ? Color(0xFFF0F0F1) : Colors.black,
              icon,
              height: AppSizes.w(20),
              width: AppSizes.w(20),
            ),
          ),
        ),

        if (count > 0)
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.all(AppSizes.p4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                count > 99 ? "99+" : count.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AppSizes.sp(10),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
