import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/features/auth/domain/entities/user_entity.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/widgets/account_actions_row.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/widgets/account_authenticated_sections.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/widgets/account_header_card.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/widgets/section_title.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/widgets/settings_section.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/widgets/settings_tile.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class AccountAuthenticatedView extends StatelessWidget {
  const AccountAuthenticatedView({
    required this.user,
    required this.localeCode,
    required this.onMyServicesTap,
    required this.onEditProfileTap,
    required this.onVerificationTap,
    required this.onUpgradeTap,
    required this.onCreateProviderTap,
    required this.onFollowingTap,
    required this.onNotificationsTap,
    required this.onChatsTap,
    required this.onPrivacyTap,
    required this.onLanguageTap,
    required this.onHelpTap,
    required this.onLogoutTap,
    required this.onDeleteAccountTap,
    super.key,
  });

  final UserEntity user;
  final String localeCode;
  final VoidCallback onMyServicesTap;
  final VoidCallback onEditProfileTap;
  final VoidCallback onVerificationTap;
  final VoidCallback onUpgradeTap;
  final VoidCallback onCreateProviderTap;
  final VoidCallback onFollowingTap;
  final VoidCallback onNotificationsTap;
  final VoidCallback onChatsTap;
  final VoidCallback onPrivacyTap;
  final VoidCallback onLanguageTap;
  final VoidCallback onHelpTap;
  final VoidCallback onLogoutTap;
  final VoidCallback onDeleteAccountTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isServiceProvider = user.type == 'worker' || user.type == 'company';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: AccountHeaderCard(user: user),
          ),
          SizedBox(height: AppSizes.h(24)),
          SectionTitle(title: l10n.accountSection),
          AccountProfileSettingsSection(
            isServiceProvider: isServiceProvider,
            onMyServicesTap: onMyServicesTap,
            onEditProfileTap: onEditProfileTap,
            onVerificationTap: onVerificationTap,
            onUpgradeTap: onUpgradeTap,
            onCreateProviderTap: onCreateProviderTap,
            onFollowingTap: onFollowingTap,
          ),
          SizedBox(height: AppSizes.h(24)),
          SectionTitle(title: l10n.settings),
          AccountPreferencesSettingsSection(
            localeCode: localeCode,
            onNotificationsTap: onNotificationsTap,
            onChatsTap: onChatsTap,
            onPrivacyTap: onPrivacyTap,
            onLanguageTap: onLanguageTap,
          ),
          SizedBox(height: AppSizes.h(24)),
          SectionTitle(title: l10n.supportSection),
          SettingsSection(
            items: [
              SettingsItem(
                title: l10n.helpAndSupport,
                subtitle: l10n.helpAndSupportSubtitle,
                icon: AssetsManager.settings7,
                onTap: onHelpTap,
              ),
            ],
          ),
          SizedBox(height: AppSizes.h(24)),
          AccountActionsRow(
            onLogoutTap: onLogoutTap,
            onDeleteAccountTap: onDeleteAccountTap,
          ),
          SizedBox(height: AppSizes.h(150)),
        ],
      ),
    );
  }
}
