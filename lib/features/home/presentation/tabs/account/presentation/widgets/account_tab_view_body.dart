import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/core/session/app_session_state.dart';
import 'package:fixgo/core/session/locale_cubit.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:fixgo/features/auth/presentation/manager/auth_cubit/auth_state.dart';
import 'package:fixgo/features/chat/presentation/manager/chats_cubit/chats_cubit.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/widgets/account_authenticated_view.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/widgets/account_guest_view.dart';
import 'package:fixgo/features/offers/presentation/manager/search_cubit/search_cubit.dart';
import 'package:fixgo/l10n/app_localizations.dart';

Future<bool> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  String? confirmText,
  String? cancelText,
  bool isDanger = false,
}) async {
  final l10n = AppLocalizations.of(context);
  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText ?? l10n.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isDanger
                  ? Colors.red
                  : ColorsManager.primaryColor,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              confirmText ?? l10n.confirm,
              style: TextStyle(
                color: ColorsManager.white,
                fontSize: AppSizes.sp16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    },
  );
  return result ?? false;
}

class AccountTabViewBody extends StatelessWidget {
  const AccountTabViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionState = context.watch<AppSessionCubit>().state;
    final localeCode = context.watch<LocaleCubit>().state.languageCode;

    if (sessionState is! AppSessionAuthenticated) {
      return AccountGuestView(
        localeCode: localeCode,
        onHelpTap: () => _open(context, '/faq'),
        onPrivacyTap: () => _open(context, '/privacy'),
        onLanguageTap: () => _showLanguagePicker(context),
        onLoginTap: () async {
          await context.read<SearchCubit>().clearAllHistory();
          if (context.mounted) context.push('/login');
        },
      );
    }

    return AccountAuthenticatedView(
      user: sessionState.user,
      localeCode: localeCode,
      onMyServicesTap: () => _open(context, '/my-services'),
      onEditProfileTap: () => _open(context, '/edit-profile'),
      onVerificationTap: () => _open(context, '/account/verification'),
      onUpgradeTap: () => _open(context, '/account/benefits'),
      onCreateProviderTap: () => context.push('/role_selection'),
      onFollowingTap: () => _open(context, '/following'),
      onNotificationsTap: () => _open(context, '/notifications'),
      onChatsTap: () => _open(context, '/chats'),
      onPrivacyTap: () => _open(context, '/privacy'),
      onLanguageTap: () => _showLanguagePicker(context),
      onHelpTap: () => _open(context, '/faq'),
      onLogoutTap: () => _logout(context),
      onDeleteAccountTap: () => _deleteAccount(context),
    );
  }

  void _open(BuildContext context, String location) {
    if (kIsWeb) {
      context.go(location);
    } else {
      context.push(location);
    }
  }

  Future<void> _showLanguagePicker(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final localeCubit = context.read<LocaleCubit>();
    final current = localeCubit.state.languageCode;

    await showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(l10n.arabic),
                trailing: current == 'ar'
                    ? const Icon(Icons.check, color: Color(0xFF1E3A70))
                    : null,
                tileColor: Colors.white,
                splashColor: Colors.black.withOpacity(0.05),
                onTap: () async {
                  await localeCubit.setLocale(const Locale('ar'));
                  if (sheetContext.mounted) Navigator.pop(sheetContext);
                },
              ),
              ListTile(
                title: Text(l10n.english),
                trailing: current == 'en'
                    ? const Icon(Icons.check, color: Color(0xFF1E3A70))
                    : null,
                tileColor: Colors.white,
                splashColor: Colors.black.withOpacity(0.05),
                onTap: () async {
                  await localeCubit.setLocale(const Locale('en'));
                  if (sheetContext.mounted) Navigator.pop(sheetContext);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _logout(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final authCubit = context.read<AuthCubit>();
    final sessionCubit = context.read<AppSessionCubit>();
    final chatsCubit = context.read<ChatsCubit>();
    final searchCubit = context.read<SearchCubit>();
    final confirm = await showConfirmDialog(
      context: context,
      title: l10n.logoutConfirmTitle,
      message: l10n.logoutConfirmMessage,
      confirmText: l10n.confirm,
      cancelText: l10n.cancel,
    );

    if (!confirm || !context.mounted) return;
    await authCubit.signOut();
    if (!context.mounted || authCubit.state is AuthFailure) return;

    await sessionCubit.logout();
    chatsCubit.clearChats();
    await searchCubit.clearAllHistory();
    if (context.mounted) context.go('/');
  }

  Future<void> _deleteAccount(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final authCubit = context.read<AuthCubit>();
    final sessionCubit = context.read<AppSessionCubit>();
    final chatsCubit = context.read<ChatsCubit>();
    final searchCubit = context.read<SearchCubit>();
    final confirm = await showConfirmDialog(
      context: context,
      title: l10n.deleteAccountConfirmTitle,
      message: l10n.deleteAccountConfirmMessage,
      confirmText: l10n.deleteAccount,
      cancelText: l10n.cancel,
      isDanger: true,
    );

    if (!confirm || !context.mounted) return;
    try {
      await authCubit.deleteAccount();
      if (!context.mounted || authCubit.state is AuthFailure) return;

      chatsCubit.clearChats();
      await searchCubit.clearAllHistory();
      await sessionCubit.logout();
      if (context.mounted) context.go('/');
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('${l10n.genericError}: $error')));
    }
  }
}
