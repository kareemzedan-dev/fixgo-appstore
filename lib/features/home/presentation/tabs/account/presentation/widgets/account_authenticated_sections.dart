import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/config/theme/theme_cubit.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/widgets/settings_section.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/widgets/settings_tile.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class AccountProfileSettingsSection extends StatelessWidget {
  const AccountProfileSettingsSection({
    required this.isServiceProvider,
    required this.onMyServicesTap,
    required this.onEditProfileTap,
    required this.onVerificationTap,
    required this.onUpgradeTap,
    required this.onCreateProviderTap,
    required this.onFollowingTap,
    super.key,
  });

  final bool isServiceProvider;
  final VoidCallback onMyServicesTap;
  final VoidCallback onEditProfileTap;
  final VoidCallback onVerificationTap;
  final VoidCallback onUpgradeTap;
  final VoidCallback onCreateProviderTap;
  final VoidCallback onFollowingTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SettingsSection(
      items: [
        if (isServiceProvider)
          SettingsItem(
            title: l10n.myServices,
            subtitle: l10n.myServicesSubtitle,
            icon: AssetsManager.settings9,
            onTap: onMyServicesTap,
          ),
        SettingsItem(
          title: l10n.editProfile,
          subtitle: l10n.editProfileSubtitle,
          icon: AssetsManager.settings1,
          onTap: onEditProfileTap,
        ),
        // if (isServiceProvider) ...[
        //   SettingsItem(
        //     title: l10n.verificationMenuTitle,
        //     subtitle: l10n.verificationMenuSubtitle,
        //     icon: AssetsManager.settings8,
        //     showVerificationBadge: true,
        //     onTap: onVerificationTap,
        //   ),
        //   SettingsItem(
        //     title: l10n.upgradeAccount,
        //     icon: AssetsManager.settings2,
        //     subtitle: l10n.upgradeAccountSubtitle,
        //     onTap: onUpgradeTap,
        //   ),
        // ],
        if (!isServiceProvider)
          SettingsItem(
            title: l10n.createProviderAccount,
            subtitle: l10n.createProviderAccountSubtitle,
            icon: AssetsManager.settings2,
            onTap: onCreateProviderTap,
          ),
        SettingsItem(
          title: l10n.peopleYouFollow,
          subtitle: l10n.peopleYouFollowSubtitle,
          icon: AssetsManager.settings3,
          onTap: onFollowingTap,
        ),
      ],
    );
  }
}

class AccountPreferencesSettingsSection extends StatelessWidget {
  const AccountPreferencesSettingsSection({
    required this.localeCode,
    required this.onNotificationsTap,
    required this.onChatsTap,
    required this.onPrivacyTap,
    required this.onLanguageTap,
    super.key,
  });

  final String localeCode;
  final VoidCallback onNotificationsTap;
  final VoidCallback onChatsTap;
  final VoidCallback onPrivacyTap;
  final VoidCallback onLanguageTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SettingsSection(
      items: [
        SettingsItem(
          title: l10n.notificationsManage,
          subtitle: l10n.notificationsManageSubtitle,
          icon: AssetsManager.settings4,
          onTap: onNotificationsTap,
        ),
        SettingsItem(
          title: l10n.chatsNavigate,
          subtitle: l10n.chatsNavigateSubtitle,
          icon: AssetsManager.settings5,
          onTap: onChatsTap,
        ),
        SettingsItem(
          title: l10n.privacyAndSecurity,
          subtitle: l10n.privacySubtitle,
          icon: AssetsManager.settings6,
          onTap: onPrivacyTap,
        ),
        SettingsItem(
          title: l10n.language,
          subtitle: localeCode == 'en' ? l10n.english : l10n.arabic,
          icon: AssetsManager.settings6,
          onTap: onLanguageTap,
        ),
        SettingsItem(
          title: l10n.darkMode,
          subtitle: l10n.darkModeSubtitle,
          icon: AssetsManager.settings6,
          trailing: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return CupertinoSwitch(
                value: themeMode == ThemeMode.dark,
                onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
                activeTrackColor: const Color(0xFF1E3A70),
              );
            },
          ),
        ),
      ],
    );
  }
}
