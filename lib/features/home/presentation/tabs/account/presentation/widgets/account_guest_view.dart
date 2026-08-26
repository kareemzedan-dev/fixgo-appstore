import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/config/theme/theme_cubit.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/widgets/section_title.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/widgets/settings_section.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/widgets/settings_tile.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class AccountGuestView extends StatelessWidget {
  const AccountGuestView({
    required this.localeCode,
    required this.onHelpTap,
    required this.onPrivacyTap,
    required this.onLanguageTap,
    required this.onLoginTap,
    super.key,
  });

  final String localeCode;
  final VoidCallback onHelpTap;
  final VoidCallback onPrivacyTap;
  final VoidCallback onLanguageTap;
  final VoidCallback onLoginTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1E1E1E)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      l10n.guestNotLoggedIn,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.guestLoginHint,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            SectionTitle(title: l10n.supportSection),
            const SizedBox(height: 12),
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
            const SizedBox(height: 12),
            SectionTitle(title: l10n.settings),
            const SizedBox(height: 12),
            SettingsSection(
              items: [
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
                        onChanged: (_) =>
                            context.read<ThemeCubit>().toggleTheme(),
                        activeTrackColor: const Color(0xFF1E3A70),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onLoginTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E3A70),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  l10n.login,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
