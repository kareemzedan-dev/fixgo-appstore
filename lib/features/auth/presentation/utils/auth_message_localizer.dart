import 'package:fixgo/l10n/app_localizations.dart';

/// Maps AuthCubit semantic success/error keys to localized user-facing text.
String localizeAuthMessage(AppLocalizations l10n, String key) {
  switch (key) {
    case 'account_created':
      return l10n.authAccountCreated;
    case 'login_success':
      return l10n.authLoginSuccess;
    case 'profile_updated':
      return l10n.authProfileUpdated;
    case 'phone_updated':
      return l10n.authPhoneUpdated;
    case 'register_success':
      return l10n.authRegisterSuccess;
    case 'otp_sent':
      return l10n.otpSentSuccess;
    case 'otp_verified':
      return l10n.authOtpVerified;
    case 'otp_resent':
      return l10n.otpResent;
    case 'password_reset':
      return l10n.passwordChangedSuccess;
    case 'generic_error':
      return l10n.genericError;
    case "no_account":
      return l10n.phoneNotRegistered;
    case "wrong_password":
      return l10n.wrongPassword;
    case "suspended":
      return l10n.accountSuspended;

    default:
      if (RegExp(r'[\u0600-\u06FF]').hasMatch(key)) {
        return l10n.genericError;
      }
      return key;
  }
}
