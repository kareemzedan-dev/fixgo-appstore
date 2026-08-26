import 'package:flutter/material.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class FaqView extends StatelessWidget {
  const FaqView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.faqTitle), centerTitle: true),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _faqItem(l10n.faqHowAddService, l10n.faqHowAddServiceAnswer),
            _faqItem(
              l10n.faqHowContactProvider,
              l10n.faqHowContactProviderAnswer,
            ),
            _faqItem(l10n.faqIsDataSecure, l10n.faqIsDataSecureAnswer),
            _faqItem(l10n.faqHowEditProfile, l10n.faqHowEditProfileAnswer),
            _faqItem(l10n.faqCanDeleteAccount, l10n.faqCanDeleteAccountAnswer),
            _faqItem(l10n.faqHowAddWorkPhotos, l10n.faqHowAddWorkPhotosAnswer),
            _faqItem(l10n.faqHowEditService, l10n.faqHowEditServiceAnswer),
            _faqItem(l10n.faqHowViewRatings, l10n.faqHowViewRatingsAnswer),
            _faqItem(
              l10n.faqMultipleWorkAreas,
              l10n.faqMultipleWorkAreasAnswer,
            ),
            _faqItem(l10n.faqIsAppFree, l10n.faqIsAppFreeAnswer),
            _faqItem(l10n.faqCanEditPhone, l10n.faqCanEditPhoneAnswer),
            _faqItem(l10n.faqHowVerifyAccount, l10n.faqHowVerifyAccountAnswer),
            _faqItem(
              l10n.faqCanChangeServiceType,
              l10n.faqCanChangeServiceTypeAnswer,
            ),
            _faqItem(l10n.faqHowReportProblem, l10n.faqHowReportProblemAnswer),
            _faqItem(
              l10n.faqIsSupportAvailable,
              l10n.faqIsSupportAvailableAnswer,
            ),
            _faqItem(
              l10n.faqUseWithoutRegistration,
              l10n.faqUseWithoutRegistrationAnswer,
            ),
          ],
        ),
      ),
    );
  }

  Widget _faqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        children: [
          Padding(padding: const EdgeInsets.all(12), child: Text(answer)),
        ],
      ),
    );
  }
}
