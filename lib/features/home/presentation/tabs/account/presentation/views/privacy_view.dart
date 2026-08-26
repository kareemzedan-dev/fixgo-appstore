import 'package:flutter/material.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.privacyAndSecurity), centerTitle: true),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            /// مقدمة
            _sectionCard(
              l10n.privacyWelcomeTitle,
              l10n.privacyIntroduction,

              context,
            ),

            /// 1
            _sectionTitle(l10n.privacyCollectedInfoTitle),

            _bulletSection(l10n.privacyProvidedInfoTitle, [
              l10n.privacyNameOptional,
              l10n.privacyPhoneNumber,
              l10n.privacyEnteredInformation,
            ]),

            _bulletSection(l10n.privacyAutomaticInfoTitle, [
              l10n.privacyLocation,
              l10n.privacyDeviceAndOs,
              l10n.privacyUsageData,
            ]),

            /// 2
            _sectionTitle(l10n.privacyUseInfoTitle),

            _bulletList([
              l10n.privacyUseNearbyServices,
              l10n.privacyUseImproveExperience,
              l10n.privacyUseDevelopServices,
              l10n.privacyUseContactYou,
            ]),

            /// 3
            _sectionTitle(l10n.privacySharingTitle),

            _sectionText(l10n.privacyNoDataSales),

            _bulletList([
              l10n.privacySharingWhatsApp,
              l10n.privacySharingLegal,
            ]),

            /// 4
            _sectionTitle(l10n.privacyWhatsAppTitle),

            _sectionText(l10n.privacyWhatsAppDescription),

            _bulletList([
              l10n.privacyWhatsAppPolicy,
              l10n.privacyExternalContentDisclaimer,
            ]),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// =========================
  /// Widgets
  /// =========================

  Widget _sectionCard(String title, String content, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(content),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  Widget _sectionText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text),
    );
  }

  Widget _bulletSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        ...items.map((e) => _bulletItem(e)),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _bulletList(List<String> items) {
    return Column(children: items.map((e) => _bulletItem(e)).toList());
  }

  Widget _bulletItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 6, color: Colors.blue),
          const SizedBox(width: 6),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
