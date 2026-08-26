import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/features/onboarding/data/model/onboarding_model.dart';
import 'package:fixgo/l10n/app_localizations.dart';

List<OnboardingModel> buildOnboardingList(AppLocalizations l10n) {
  return [
    OnboardingModel(
      image: AssetsManager.onboarding1,
      title: l10n.onboardingTitle1,
      description: l10n.onboardingDesc1,
    ),
    OnboardingModel(
      image: AssetsManager.onboarding3,
      title: l10n.onboardingTitle2,
      description: l10n.onboardingDesc2,
    ),
    OnboardingModel(
      image: AssetsManager.onboarding2,
      title: l10n.onboardingTitle3,
      description: l10n.onboardingDesc3,
    ),
  ];
}
