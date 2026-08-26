import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/core/session/app_session_state.dart';

import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/features/auth/domain/entities/user_entity.dart';
import 'package:fixgo/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class AccountHeaderCard extends StatefulWidget {
  final UserEntity user;

  const AccountHeaderCard({super.key, required this.user});

  @override
  State<AccountHeaderCard> createState() => _AccountHeaderCardState();
}

class _AccountHeaderCardState extends State<AccountHeaderCard> {
  bool isLoading = false;

  /// =========================
  /// 📸 اختيار ورفع الصورة
  /// =========================
  Future<void> pickAndUploadImage() async {
    final authCubit = context.read<AuthCubit>();
    final sessionCubit = context.read<AppSessionCubit>();
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked == null || !mounted) return;

    setState(() => isLoading = true);

    await authCubit.updateProfileImage(picked);
    if (mounted) {
      await sessionCubit.loadUser();
    }

    if (mounted) setState(() => isLoading = false);
  }

  Widget buildAvatar(UserEntity user) {
    final hasImage = user.imageUrl != null && user.imageUrl!.isNotEmpty;

    /// 🎨 ألوان لطيفة
    final colors = [
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.purple,
      Colors.red,
      Colors.teal,
    ];

    /// 🎯 لون ثابت حسب الاسم
    final color = colors[user.name.hashCode % colors.length];

    if (hasImage) {
      return CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(user.imageUrl!),
      );
    }

    /// 👇 fallback حرف + لون
    return CircleAvatar(
      radius: 40,
      backgroundColor: color,
      child: Text(
        user.name.isNotEmpty ? user.name[0].toUpperCase() : "?",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppSessionCubit>().state;

    if (state is! AppSessionAuthenticated) {
      return const SizedBox();
    }
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final user = state.user;
    final bool isServiceProvider =
        user.type == "worker" || user.type == 'company';

    /// =========================
    /// 👷 مقدم خدمة
    /// =========================
    if (isServiceProvider) {
      return InkWell(
        onTap: () {
          if (kIsWeb) {
            context.go("/provider-profile/${user.uid}");
          } else {
            context.push("/provider-profile/${user.uid}");
          }
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark ? const Color(0Xff1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
            ),
          ),
          child: Row(
            children: [
              /// 📸 الصورة
              Stack(
                children: [
                  buildAvatar(user),

                  /// 🔄 loading
                  if (isLoading)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      ),
                    ),

                  /// 📷 زرار الكاميرا
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: GestureDetector(
                      onTap: pickAndUploadImage,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1D3964),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(width: AppSizes.w(12)),

              /// 👤 البيانات
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        /// 👇 الاسم
                        Expanded(
                          child: Text(
                            user.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: AppSizes.sp(14),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        SizedBox(width: 8),

                        /// 👇 النوع
                        Text(
                          AppLocalizations.of(context).serviceProvider,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: ColorsManager.secondaryColor,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      [user.district, user.city]
                          .where((e) => e != null && e!.trim().isNotEmpty)
                          .join(AppLocalizations.of(context).addressSeparator),
                      style: TextStyle(fontSize: AppSizes.sp(10)),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      user.phone,
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
        ),
      );
    }

    /// =========================
    /// 👤 مستخدم عادي
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0Xff1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// الاسم
          Text(
            user.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          Text(
            user.phone,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
