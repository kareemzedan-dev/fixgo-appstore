import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @verificationTitle.
  ///
  /// In ar, this message translates to:
  /// **'توثيق حسابك'**
  String get verificationTitle;

  /// No description provided for @verificationTitleShort.
  ///
  /// In ar, this message translates to:
  /// **'توثيق الحساب'**
  String get verificationTitleShort;

  /// No description provided for @verificationHeadline.
  ///
  /// In ar, this message translates to:
  /// **'وثق حسابك لزيادة ثقة العملاء'**
  String get verificationHeadline;

  /// No description provided for @verificationDescription.
  ///
  /// In ar, this message translates to:
  /// **'توثيق حسابك يساعدك في الظهور بشكل أفضل\nويزيد من إقبال العملاء عليك'**
  String get verificationDescription;

  /// No description provided for @verificationFeatureSearch.
  ///
  /// In ar, this message translates to:
  /// **'ظهور أفضل في نتائج البحث'**
  String get verificationFeatureSearch;

  /// No description provided for @verificationFeatureTrust.
  ///
  /// In ar, this message translates to:
  /// **'زيادة ثقة العملاء بك'**
  String get verificationFeatureTrust;

  /// No description provided for @verificationFeatureBadge.
  ///
  /// In ar, this message translates to:
  /// **'علامة موثق على حسابك'**
  String get verificationFeatureBadge;

  /// No description provided for @verificationStart.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ التوثيق'**
  String get verificationStart;

  /// No description provided for @verificationPendingTitle.
  ///
  /// In ar, this message translates to:
  /// **'طلب التوثيق قيد المراجعة'**
  String get verificationPendingTitle;

  /// No description provided for @verificationPendingSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ مراجعة بياناتك وسيتم إشعارك بعد الانتهاء'**
  String get verificationPendingSubtitle;

  /// No description provided for @verificationApprovedTitle.
  ///
  /// In ar, this message translates to:
  /// **'تم توثيق حسابك بنجاح'**
  String get verificationApprovedTitle;

  /// No description provided for @verificationApprovedSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'حسابك الآن موثق ويمكن للعملاء رؤية علامة التوثيق'**
  String get verificationApprovedSubtitle;

  /// No description provided for @verificationRejectedTitle.
  ///
  /// In ar, this message translates to:
  /// **'تم رفض طلب التوثيق'**
  String get verificationRejectedTitle;

  /// No description provided for @verificationRejectedSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إعادة رفع الصور بشكل أوضح ثم المحاولة مرة أخرى'**
  String get verificationRejectedSubtitle;

  /// No description provided for @verificationRetry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة التوثيق'**
  String get verificationRetry;

  /// No description provided for @verificationFrontTitle.
  ///
  /// In ar, this message translates to:
  /// **'الصورة الأمامية للهوية'**
  String get verificationFrontTitle;

  /// No description provided for @verificationFrontSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'ارفع الوجه الأمامي للهوية الشخصية'**
  String get verificationFrontSubtitle;

  /// No description provided for @verificationBackTitle.
  ///
  /// In ar, this message translates to:
  /// **'الصورة الخلفية للهوية'**
  String get verificationBackTitle;

  /// No description provided for @verificationBackSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'ارفع الوجه الخلفي للهوية الشخصية'**
  String get verificationBackSubtitle;

  /// No description provided for @verificationTipsTitle.
  ///
  /// In ar, this message translates to:
  /// **'نصائح للحصول على صورة واضحة:'**
  String get verificationTipsTitle;

  /// No description provided for @verificationTipClarity.
  ///
  /// In ar, this message translates to:
  /// **'• تأكد من وضوح جميع البيانات'**
  String get verificationTipClarity;

  /// No description provided for @verificationTipLighting.
  ///
  /// In ar, this message translates to:
  /// **'• اجعل الإضاءة جيدة'**
  String get verificationTipLighting;

  /// No description provided for @verificationTipAngle.
  ///
  /// In ar, this message translates to:
  /// **'• تجنب الصور الجانبية'**
  String get verificationTipAngle;

  /// No description provided for @verificationTapToUpload.
  ///
  /// In ar, this message translates to:
  /// **'اضغط لرفع الصورة'**
  String get verificationTapToUpload;

  /// No description provided for @verificationSubmit.
  ///
  /// In ar, this message translates to:
  /// **'وثق حسابك'**
  String get verificationSubmit;

  /// No description provided for @verificationCompleteUploads.
  ///
  /// In ar, this message translates to:
  /// **'أكمل رفع الصور'**
  String get verificationCompleteUploads;

  /// No description provided for @verificationIncompleteImages.
  ///
  /// In ar, this message translates to:
  /// **'يرجى رفع صور الهوية كاملة'**
  String get verificationIncompleteImages;

  /// No description provided for @verificationSubmitSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال طلب التوثيق بنجاح'**
  String get verificationSubmitSuccess;

  /// No description provided for @verificationSubmitFailed.
  ///
  /// In ar, this message translates to:
  /// **'فشل إرسال طلب التوثيق'**
  String get verificationSubmitFailed;

  /// No description provided for @notificationsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get notificationsTitle;

  /// No description provided for @notificationsMarkAllRead.
  ///
  /// In ar, this message translates to:
  /// **'تحديد الكل كمقروء'**
  String get notificationsMarkAllRead;

  /// No description provided for @notificationsDeleteAll.
  ///
  /// In ar, this message translates to:
  /// **'حذف الكل'**
  String get notificationsDeleteAll;

  /// No description provided for @notificationsEmpty.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد إشعارات'**
  String get notificationsEmpty;

  /// No description provided for @notificationsDeleteOne.
  ///
  /// In ar, this message translates to:
  /// **'حذف الإشعار'**
  String get notificationsDeleteOne;

  /// No description provided for @notificationsAttachedFile.
  ///
  /// In ar, this message translates to:
  /// **'ملف مرفق'**
  String get notificationsAttachedFile;

  /// No description provided for @logout.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get logout;

  /// No description provided for @logoutConfirmTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get logoutConfirmTitle;

  /// No description provided for @logoutConfirmMessage.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد أنك تريد تسجيل الخروج؟'**
  String get logoutConfirmMessage;

  /// No description provided for @deleteAccount.
  ///
  /// In ar, this message translates to:
  /// **'حذف الحساب'**
  String get deleteAccount;

  /// No description provided for @deleteAccountConfirmTitle.
  ///
  /// In ar, this message translates to:
  /// **'حذف الحساب'**
  String get deleteAccountConfirmTitle;

  /// No description provided for @deleteAccountConfirmMessage.
  ///
  /// In ar, this message translates to:
  /// **'⚠️ سيتم حذف حسابك نهائيًا ولن تتمكن من استرجاعه.\nهل أنت متأكد؟'**
  String get deleteAccountConfirmMessage;

  /// No description provided for @confirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @genericError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ'**
  String get genericError;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In ar, this message translates to:
  /// **'نسيت كلمة المرور'**
  String get forgotPasswordTitle;

  /// No description provided for @sendVerificationCode.
  ///
  /// In ar, this message translates to:
  /// **'إرسال رمز التحقق'**
  String get sendVerificationCode;

  /// No description provided for @otpSentSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال رمز التحقق'**
  String get otpSentSuccess;

  /// No description provided for @createNewPasswordTitle.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء كلمة مرور جديدة'**
  String get createNewPasswordTitle;

  /// No description provided for @save.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get save;

  /// No description provided for @otpTitle.
  ///
  /// In ar, this message translates to:
  /// **'رمز التحقق'**
  String get otpTitle;

  /// No description provided for @skip.
  ///
  /// In ar, this message translates to:
  /// **'تخطي'**
  String get skip;

  /// No description provided for @onboardingTitle1.
  ///
  /// In ar, this message translates to:
  /// **'تبحث عن حرفي موثوق ولا \nتعرف من أين تبدأ؟'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDesc1.
  ///
  /// In ar, this message translates to:
  /// **'تسأل كثيرًا وتجرّب أكثر من شخص، وفي النهاية يضيع\n وقتك وجهدك.'**
  String get onboardingDesc1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In ar, this message translates to:
  /// **'كل الحرفيين في مكان\n واحد قريب منك'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDesc2.
  ///
  /// In ar, this message translates to:
  /// **'اختر من بين أفضل الحرفيين القريبين منك، واطّلع على\n التقييمات قبل اتخاذ القرار.'**
  String get onboardingDesc2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In ar, this message translates to:
  /// **'تواصل مع الحرفي المناسب\n لمشكلتك فورًا'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc3.
  ///
  /// In ar, this message translates to:
  /// **'تواصل معه مباشرة عبر واتساب، وأنجز جميع أعمالك\n بسرعة وسهولة.'**
  String get onboardingDesc3;

  /// No description provided for @enterFullOtp.
  ///
  /// In ar, this message translates to:
  /// **'من فضلك أدخل كود التحقق كاملاً'**
  String get enterFullOtp;

  /// No description provided for @invalidOtp.
  ///
  /// In ar, this message translates to:
  /// **'الكود غير صحيح'**
  String get invalidOtp;

  /// No description provided for @otpResent.
  ///
  /// In ar, this message translates to:
  /// **'تم إعادة إرسال الكود'**
  String get otpResent;

  /// No description provided for @enterPassword.
  ///
  /// In ar, this message translates to:
  /// **'أدخل كلمة المرور'**
  String get enterPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'أكد كلمة المرور'**
  String get confirmPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In ar, this message translates to:
  /// **'كلمتا المرور غير متطابقتين'**
  String get passwordsDoNotMatch;

  /// No description provided for @passwordChangedSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم تغيير كلمة المرور بنجاح'**
  String get passwordChangedSuccess;

  /// No description provided for @previous.
  ///
  /// In ar, this message translates to:
  /// **'السابق'**
  String get previous;

  /// No description provided for @enterOtpTitle.
  ///
  /// In ar, this message translates to:
  /// **'ادخل الكود'**
  String get enterOtpTitle;

  /// No description provided for @enterOtpSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أدخل رمز التحقق المرسل إلى {phone}'**
  String enterOtpSubtitle(String phone);

  /// No description provided for @resendOtp.
  ///
  /// In ar, this message translates to:
  /// **'إعادة إرسال الكود'**
  String get resendOtp;

  /// No description provided for @enterNewPasswordTitle.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء كلمة مرور جديدة'**
  String get enterNewPasswordTitle;

  /// No description provided for @enterNewPasswordSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أدخل كلمة المرور الجديدة'**
  String get enterNewPasswordSubtitle;

  /// No description provided for @newPasswordHint.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور الجديدة'**
  String get newPasswordHint;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get confirmPasswordHint;

  /// No description provided for @wrongPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور غير صحيحه'**
  String get wrongPassword;

  /// No description provided for @chatTitle.
  ///
  /// In ar, this message translates to:
  /// **'المحادثات'**
  String get chatTitle;

  /// No description provided for @noChats.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد محادثات'**
  String get noChats;

  /// No description provided for @photoAttachment.
  ///
  /// In ar, this message translates to:
  /// **'📷 صورة'**
  String get photoAttachment;

  /// No description provided for @docAttachment.
  ///
  /// In ar, this message translates to:
  /// **'📄 مستند'**
  String get docAttachment;

  /// No description provided for @fileAttachment.
  ///
  /// In ar, this message translates to:
  /// **'📎 ملف مرفق'**
  String get fileAttachment;

  /// No description provided for @noMessages.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد رسائل'**
  String get noMessages;

  /// No description provided for @today.
  ///
  /// In ar, this message translates to:
  /// **'اليوم'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In ar, this message translates to:
  /// **'أمس'**
  String get yesterday;

  /// No description provided for @download.
  ///
  /// In ar, this message translates to:
  /// **'تحميل'**
  String get download;

  /// No description provided for @open.
  ///
  /// In ar, this message translates to:
  /// **'فتح'**
  String get open;

  /// No description provided for @writeYourMessage.
  ///
  /// In ar, this message translates to:
  /// **'اكتب رسالتك'**
  String get writeYourMessage;

  /// No description provided for @oneYear.
  ///
  /// In ar, this message translates to:
  /// **'سنة'**
  String get oneYear;

  /// No description provided for @twoYears.
  ///
  /// In ar, this message translates to:
  /// **'سنتين'**
  String get twoYears;

  /// No description provided for @years.
  ///
  /// In ar, this message translates to:
  /// **'سنوات'**
  String get years;

  /// No description provided for @serviceDetails.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل الخدمة'**
  String get serviceDetails;

  /// No description provided for @serviceProvider.
  ///
  /// In ar, this message translates to:
  /// **'مقدم الخدمة'**
  String get serviceProvider;

  /// No description provided for @serviceBio.
  ///
  /// In ar, this message translates to:
  /// **'نبذة تعريفية عن الخدمة'**
  String get serviceBio;

  /// No description provided for @serviceAreas.
  ///
  /// In ar, this message translates to:
  /// **'مناطق العمل'**
  String get serviceAreas;

  /// No description provided for @businessGallery.
  ///
  /// In ar, this message translates to:
  /// **'معرض الأعمال'**
  String get businessGallery;

  /// No description provided for @reviewsAndRatings.
  ///
  /// In ar, this message translates to:
  /// **'التقييمات والآراء'**
  String get reviewsAndRatings;

  /// No description provided for @showAll.
  ///
  /// In ar, this message translates to:
  /// **'عرض الكل'**
  String get showAll;

  /// No description provided for @noReviewsYet.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد تقييمات بعد'**
  String get noReviewsYet;

  /// No description provided for @addReview.
  ///
  /// In ar, this message translates to:
  /// **'إضافة تعليق'**
  String get addReview;

  /// No description provided for @sendReview.
  ///
  /// In ar, this message translates to:
  /// **'إرسال التعليق'**
  String get sendReview;

  /// No description provided for @reviewHint.
  ///
  /// In ar, this message translates to:
  /// **'اكتب تعليقك هنا...'**
  String get reviewHint;

  /// No description provided for @ratingLabel.
  ///
  /// In ar, this message translates to:
  /// **'التقييم'**
  String get ratingLabel;

  /// No description provided for @similarServices.
  ///
  /// In ar, this message translates to:
  /// **'خدمات مشابهة'**
  String get similarServices;

  /// No description provided for @noSimilarServices.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد خدمات مشابهة حالياً'**
  String get noSimilarServices;

  /// No description provided for @follow.
  ///
  /// In ar, this message translates to:
  /// **'متابعة'**
  String get follow;

  /// No description provided for @following.
  ///
  /// In ar, this message translates to:
  /// **'متابع'**
  String get following;

  /// No description provided for @reportService.
  ///
  /// In ar, this message translates to:
  /// **'الإبلاغ عن الخدمة'**
  String get reportService;

  /// No description provided for @user.
  ///
  /// In ar, this message translates to:
  /// **'مستخدم'**
  String get user;

  /// No description provided for @language.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get language;

  /// No description provided for @languageSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'لغة التطبيق'**
  String get languageSubtitle;

  /// No description provided for @arabic.
  ///
  /// In ar, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In ar, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @settings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settings;

  /// No description provided for @privacyAndSecurity.
  ///
  /// In ar, this message translates to:
  /// **'الخصوصية والأمان'**
  String get privacyAndSecurity;

  /// No description provided for @privacySubtitle.
  ///
  /// In ar, this message translates to:
  /// **'إعدادات الخصوصية'**
  String get privacySubtitle;

  /// No description provided for @darkMode.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الداكن'**
  String get darkMode;

  /// No description provided for @darkModeSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'تفعيل الوضع الداكن'**
  String get darkModeSubtitle;

  /// No description provided for @login.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get login;

  /// No description provided for @accountSection.
  ///
  /// In ar, this message translates to:
  /// **'الحساب'**
  String get accountSection;

  /// No description provided for @authAccountCreated.
  ///
  /// In ar, this message translates to:
  /// **'تم إنشاء الحساب بنجاح'**
  String get authAccountCreated;

  /// No description provided for @authLoginSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم تسجيل الدخول بنجاح'**
  String get authLoginSuccess;

  /// No description provided for @authProfileUpdated.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث البيانات بنجاح'**
  String get authProfileUpdated;

  /// No description provided for @authPhoneUpdated.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث رقم الهاتف بنجاح'**
  String get authPhoneUpdated;

  /// No description provided for @authRegisterSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم التسجيل بنجاح'**
  String get authRegisterSuccess;

  /// No description provided for @authOtpVerified.
  ///
  /// In ar, this message translates to:
  /// **'تم التحقق من الرمز بنجاح'**
  String get authOtpVerified;

  /// No description provided for @phoneNotRegistered.
  ///
  /// In ar, this message translates to:
  /// **'هذا الرقم غير مسجل'**
  String get phoneNotRegistered;

  /// No description provided for @guestNotLoggedIn.
  ///
  /// In ar, this message translates to:
  /// **'أنت غير مسجل الآن'**
  String get guestNotLoggedIn;

  /// No description provided for @guestLoginHint.
  ///
  /// In ar, this message translates to:
  /// **'من فضلك قم بتسجيل الدخول الى حسابك لتصفح افضل'**
  String get guestLoginHint;

  /// No description provided for @supportSection.
  ///
  /// In ar, this message translates to:
  /// **'الدعم'**
  String get supportSection;

  /// No description provided for @helpAndSupport.
  ///
  /// In ar, this message translates to:
  /// **'المساعدة والدعم'**
  String get helpAndSupport;

  /// No description provided for @helpAndSupportSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'الأسئلة الشائعة والتواصل'**
  String get helpAndSupportSubtitle;

  /// No description provided for @myServices.
  ///
  /// In ar, this message translates to:
  /// **'خدماتي'**
  String get myServices;

  /// No description provided for @myServicesSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'الخدمات التي تقدمها'**
  String get myServicesSubtitle;

  /// No description provided for @editProfile.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الملف الشخصي'**
  String get editProfile;

  /// No description provided for @editProfileSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'تحديث معلوماتك الشخصية'**
  String get editProfileSubtitle;

  /// No description provided for @verificationMenuTitle.
  ///
  /// In ar, this message translates to:
  /// **'التوثيق'**
  String get verificationMenuTitle;

  /// No description provided for @verificationMenuSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'توثيق حساب مقدم الخدمة'**
  String get verificationMenuSubtitle;

  /// No description provided for @upgradeAccount.
  ///
  /// In ar, this message translates to:
  /// **'تطوير الحساب'**
  String get upgradeAccount;

  /// No description provided for @upgradeAccountSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'قم بتطوير حسابك'**
  String get upgradeAccountSubtitle;

  /// No description provided for @createProviderAccount.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب مقدم خدمة'**
  String get createProviderAccount;

  /// No description provided for @createProviderAccountSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'تحويل حسابك لمقدم خدمة'**
  String get createProviderAccountSubtitle;

  /// No description provided for @peopleYouFollow.
  ///
  /// In ar, this message translates to:
  /// **'الأشخاص الذين تتابعهم'**
  String get peopleYouFollow;

  /// No description provided for @peopleYouFollowSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'مقدمو الخدمات الذين تتابعهم'**
  String get peopleYouFollowSubtitle;

  /// No description provided for @notificationsManage.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get notificationsManage;

  /// No description provided for @notificationsManageSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'إدارة الإشعارات'**
  String get notificationsManageSubtitle;

  /// No description provided for @chatsNavigate.
  ///
  /// In ar, this message translates to:
  /// **'المحادثات'**
  String get chatsNavigate;

  /// No description provided for @chatsNavigateSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'انتقل إلى المحادثات'**
  String get chatsNavigateSubtitle;

  /// No description provided for @requiredBadge.
  ///
  /// In ar, this message translates to:
  /// **'مطلوب'**
  String get requiredBadge;

  /// No description provided for @imageUploadFailed.
  ///
  /// In ar, this message translates to:
  /// **'فشل رفع الصور'**
  String get imageUploadFailed;

  /// No description provided for @serviceAddedSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم إضافة الخدمة بنجاح'**
  String get serviceAddedSuccess;

  /// No description provided for @favoritesTitle.
  ///
  /// In ar, this message translates to:
  /// **'المفضلة'**
  String get favoritesTitle;

  /// No description provided for @noFavoriteServices.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد خدمات مفضلة'**
  String get noFavoriteServices;

  /// No description provided for @home.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get home;

  /// No description provided for @services.
  ///
  /// In ar, this message translates to:
  /// **'الخدمات'**
  String get services;

  /// No description provided for @myAccount.
  ///
  /// In ar, this message translates to:
  /// **'حسابي'**
  String get myAccount;

  /// No description provided for @homeGreeting.
  ///
  /// In ar, this message translates to:
  /// **'أهلاً {name}'**
  String homeGreeting(String name);

  /// No description provided for @workerHomeSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'تابع أعمالك وطلبات العملاء'**
  String get workerHomeSubtitle;

  /// No description provided for @customerHomeSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'حل مشكلاتك مع أفضل الحرفيين.'**
  String get customerHomeSubtitle;

  /// No description provided for @mostRequestedServices.
  ///
  /// In ar, this message translates to:
  /// **'الخدمات الأكثر طلباً'**
  String get mostRequestedServices;

  /// No description provided for @airConditioning.
  ///
  /// In ar, this message translates to:
  /// **'مكيفات'**
  String get airConditioning;

  /// No description provided for @carpentry.
  ///
  /// In ar, this message translates to:
  /// **'نجارة'**
  String get carpentry;

  /// No description provided for @painting.
  ///
  /// In ar, this message translates to:
  /// **'دهانات'**
  String get painting;

  /// No description provided for @plumbing.
  ///
  /// In ar, this message translates to:
  /// **'سباكة'**
  String get plumbing;

  /// No description provided for @electricity.
  ///
  /// In ar, this message translates to:
  /// **'كهرباء'**
  String get electricity;

  /// No description provided for @blacksmithing.
  ///
  /// In ar, this message translates to:
  /// **'حدادة'**
  String get blacksmithing;

  /// No description provided for @nearbyServices.
  ///
  /// In ar, this message translates to:
  /// **'خدمات قريبة منك'**
  String get nearbyServices;

  /// No description provided for @noNearbyServices.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد خدمات قريبة منك حتى الآن'**
  String get noNearbyServices;

  /// No description provided for @distanceKilometers.
  ///
  /// In ar, this message translates to:
  /// **'{value} كم'**
  String distanceKilometers(String value);

  /// No description provided for @recommendedServices.
  ///
  /// In ar, this message translates to:
  /// **'خدمات مقترحة'**
  String get recommendedServices;

  /// No description provided for @noRecommendedServices.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد خدمات مقترحة حالياً'**
  String get noRecommendedServices;

  /// No description provided for @searchForService.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن خدمة'**
  String get searchForService;

  /// No description provided for @addService.
  ///
  /// In ar, this message translates to:
  /// **'إضافة خدمة'**
  String get addService;

  /// No description provided for @providerAccountRequiredTitle.
  ///
  /// In ar, this message translates to:
  /// **'سجل حسابك كمقدم خدمة'**
  String get providerAccountRequiredTitle;

  /// No description provided for @providerAccountRequiredMessage.
  ///
  /// In ar, this message translates to:
  /// **'من فضلك قم بتحويل حسابك لحساب مقدم خدمات\nللوصول لهذه الصفحة'**
  String get providerAccountRequiredMessage;

  /// No description provided for @loginRequiredFirst.
  ///
  /// In ar, this message translates to:
  /// **'يجب تسجيل الدخول أولاً'**
  String get loginRequiredFirst;

  /// No description provided for @storyEmptyContent.
  ///
  /// In ar, this message translates to:
  /// **'أضف نص أو صورة على الأقل'**
  String get storyEmptyContent;

  /// No description provided for @storyAddedSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم إضافة الحالة بنجاح'**
  String get storyAddedSuccess;

  /// No description provided for @addStory.
  ///
  /// In ar, this message translates to:
  /// **'إضافة حالة'**
  String get addStory;

  /// No description provided for @storyText.
  ///
  /// In ar, this message translates to:
  /// **'نص الحالة'**
  String get storyText;

  /// No description provided for @storyTextHint.
  ///
  /// In ar, this message translates to:
  /// **'اكتب نص الحالة الخاصة بك'**
  String get storyTextHint;

  /// No description provided for @storyVisible24Hours.
  ///
  /// In ar, this message translates to:
  /// **'ستظهر للجميع لمدة 24 ساعة'**
  String get storyVisible24Hours;

  /// No description provided for @uploading.
  ///
  /// In ar, this message translates to:
  /// **'جاري الرفع...'**
  String get uploading;

  /// No description provided for @popularSearchPlumber.
  ///
  /// In ar, this message translates to:
  /// **'سباك'**
  String get popularSearchPlumber;

  /// No description provided for @popularSearchHomeElectrician.
  ///
  /// In ar, this message translates to:
  /// **'كهربائي منازل'**
  String get popularSearchHomeElectrician;

  /// No description provided for @popularSearchProfessionalBlacksmith.
  ///
  /// In ar, this message translates to:
  /// **'حداد محترف'**
  String get popularSearchProfessionalBlacksmith;

  /// No description provided for @popularSearchGypsumBoardInstaller.
  ///
  /// In ar, this message translates to:
  /// **'معلم جبس بورد'**
  String get popularSearchGypsumBoardInstaller;

  /// No description provided for @popularSearchFinishingContractor.
  ///
  /// In ar, this message translates to:
  /// **'مقاول تشطيبات'**
  String get popularSearchFinishingContractor;

  /// No description provided for @popularSearchRenovationContractor.
  ///
  /// In ar, this message translates to:
  /// **'مقاول ترميم'**
  String get popularSearchRenovationContractor;

  /// No description provided for @popularSearchAcTechnician.
  ///
  /// In ar, this message translates to:
  /// **'فني مكيفات'**
  String get popularSearchAcTechnician;

  /// No description provided for @popularSearchHomePainter.
  ///
  /// In ar, this message translates to:
  /// **'معلم دهانات منازل'**
  String get popularSearchHomePainter;

  /// No description provided for @searchHistory.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ البحث'**
  String get searchHistory;

  /// No description provided for @popularSearches.
  ///
  /// In ar, this message translates to:
  /// **'الأكثر رواجاً'**
  String get popularSearches;

  /// No description provided for @search.
  ///
  /// In ar, this message translates to:
  /// **'ابحث'**
  String get search;

  /// No description provided for @searchResultsInArea.
  ///
  /// In ar, this message translates to:
  /// **'{count} نتائج \"{query}\" في منطقتك'**
  String searchResultsInArea(int count, String query);

  /// No description provided for @noResults.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد نتائج'**
  String get noResults;

  /// No description provided for @filter.
  ///
  /// In ar, this message translates to:
  /// **'فلترة'**
  String get filter;

  /// No description provided for @serviceCategory.
  ///
  /// In ar, this message translates to:
  /// **'تصنيف الخدمة'**
  String get serviceCategory;

  /// No description provided for @selectServiceCategory.
  ///
  /// In ar, this message translates to:
  /// **'اختر تصنيف الخدمة'**
  String get selectServiceCategory;

  /// No description provided for @service.
  ///
  /// In ar, this message translates to:
  /// **'الخدمة'**
  String get service;

  /// No description provided for @selectService.
  ///
  /// In ar, this message translates to:
  /// **'اختر الخدمة'**
  String get selectService;

  /// No description provided for @workerRating.
  ///
  /// In ar, this message translates to:
  /// **'تقييم الحرفي'**
  String get workerRating;

  /// No description provided for @yearsExperience.
  ///
  /// In ar, this message translates to:
  /// **'سنين الخبرة'**
  String get yearsExperience;

  /// No description provided for @yearValue.
  ///
  /// In ar, this message translates to:
  /// **'{value} سنة'**
  String yearValue(int value);

  /// No description provided for @distance.
  ///
  /// In ar, this message translates to:
  /// **'المسافة'**
  String get distance;

  /// No description provided for @kilometerValue.
  ///
  /// In ar, this message translates to:
  /// **'{value} كم'**
  String kilometerValue(int value);

  /// No description provided for @applyFilter.
  ///
  /// In ar, this message translates to:
  /// **'تطبيق الفلترة'**
  String get applyFilter;

  /// No description provided for @enterYearsOfExperience.
  ///
  /// In ar, this message translates to:
  /// **'ادخل سنين خبرتك'**
  String get enterYearsOfExperience;

  /// No description provided for @loginRequiredTitle.
  ///
  /// In ar, this message translates to:
  /// **'قم بتسجيل الدخول إلى حسابك'**
  String get loginRequiredTitle;

  /// No description provided for @loginRequiredPageMessage.
  ///
  /// In ar, this message translates to:
  /// **'من فضلك قم بتسجيل الدخول إلى حسابك للوصول\nلهذه الصفحة'**
  String get loginRequiredPageMessage;

  /// No description provided for @welcome.
  ///
  /// In ar, this message translates to:
  /// **'مرحبا بك'**
  String get welcome;

  /// No description provided for @enjoyYourJourney.
  ///
  /// In ar, this message translates to:
  /// **'نتمنى لك رحلة ممتعة'**
  String get enjoyYourJourney;

  /// No description provided for @username.
  ///
  /// In ar, this message translates to:
  /// **'اسم المستخدم'**
  String get username;

  /// No description provided for @enterYourName.
  ///
  /// In ar, this message translates to:
  /// **'ادخل اسمك'**
  String get enterYourName;

  /// No description provided for @phoneNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف'**
  String get phoneNumber;

  /// No description provided for @password.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get password;

  /// No description provided for @otpLoginNotice.
  ///
  /// In ar, this message translates to:
  /// **'سوف تستلم OTP من Fixgo لتأكيد تسجيل دخولك.'**
  String get otpLoginNotice;

  /// No description provided for @createAccount.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب'**
  String get createAccount;

  /// No description provided for @enterUsername.
  ///
  /// In ar, this message translates to:
  /// **'من فضلك أدخل اسم المستخدم'**
  String get enterUsername;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In ar, this message translates to:
  /// **'من فضلك أدخل رقم الجوال'**
  String get enterPhoneNumber;

  /// No description provided for @phoneNumberNineDigits.
  ///
  /// In ar, this message translates to:
  /// **'رقم الجوال يجب أن يكون 8 أرقام فقط'**
  String get phoneNumberNineDigits;

  /// No description provided for @completeProviderDetails.
  ///
  /// In ar, this message translates to:
  /// **'من فضلك أكمل بيانات مقدم الخدمة'**
  String get completeProviderDetails;

  /// No description provided for @tenPlusYears.
  ///
  /// In ar, this message translates to:
  /// **'+10 سنوات'**
  String get tenPlusYears;

  /// No description provided for @phoneNumberEightDigits.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف يجب أن يكون 8 أرقام'**
  String get phoneNumberEightDigits;

  /// No description provided for @phoneNumberStart789.
  ///
  /// In ar, this message translates to:
  /// **'يجب أن يبدأ الرقم بـ 7 أو 8 أو 9'**
  String get phoneNumberStart789;

  /// No description provided for @welcomeBack.
  ///
  /// In ar, this message translates to:
  /// **'أهلا بعودتك'**
  String get welcomeBack;

  /// No description provided for @welcomeBackSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'سعيدون بعودتك، سجل دخول الآن'**
  String get welcomeBackSubtitle;

  /// No description provided for @loginInstruction.
  ///
  /// In ar, this message translates to:
  /// **'قم بإدخال رقم الهاتف وكلمة المرور لتسجيل الدخول.'**
  String get loginInstruction;

  /// No description provided for @termsAndPrivacyAgreement.
  ///
  /// In ar, this message translates to:
  /// **'أوافق على الشروط وسياسات الخصوصية'**
  String get termsAndPrivacyAgreement;

  /// No description provided for @saveAddress.
  ///
  /// In ar, this message translates to:
  /// **'حفظ العنوان'**
  String get saveAddress;

  /// No description provided for @acceptTermsBeforeContinue.
  ///
  /// In ar, this message translates to:
  /// **'يرجى الموافقة على الشروط وسياسات الخصوصية قبل المتابعة.'**
  String get acceptTermsBeforeContinue;

  /// No description provided for @currentUserNotFound.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم العثور على المستخدم الحالي'**
  String get currentUserNotFound;

  /// No description provided for @allowLocationAccess.
  ///
  /// In ar, this message translates to:
  /// **'السماح بالوصول للموقع'**
  String get allowLocationAccess;

  /// No description provided for @workerLocationDescription.
  ///
  /// In ar, this message translates to:
  /// **'نحتاج إلى موقعك الجغرافي لكي نعرض لك العملاء القريبين منك وتسهيل الوصول إليهم.'**
  String get workerLocationDescription;

  /// No description provided for @customerLocationDescription.
  ///
  /// In ar, this message translates to:
  /// **'نحتاج الموقع الجغرافي الخاص بك لكي نتمكن من إظهار أصحاب الحرف المتواجدين بالقرب منك.'**
  String get customerLocationDescription;

  /// No description provided for @selectYourAddress.
  ///
  /// In ar, this message translates to:
  /// **'حدد عنوانك'**
  String get selectYourAddress;

  /// No description provided for @addressDetailsSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'قم بإضافة تفاصيل موقعك لإكمال العملية'**
  String get addressDetailsSubtitle;

  /// No description provided for @addAddressDetails.
  ///
  /// In ar, this message translates to:
  /// **'أضف تفاصيل العنوان'**
  String get addAddressDetails;

  /// No description provided for @useCurrentLocation.
  ///
  /// In ar, this message translates to:
  /// **'استخدم الموقع الحالي'**
  String get useCurrentLocation;

  /// No description provided for @addressSummary.
  ///
  /// In ar, this message translates to:
  /// **'{street}، {district}، {city}'**
  String addressSummary(String street, String district, String city);

  /// No description provided for @iAm.
  ///
  /// In ar, this message translates to:
  /// **'أنا أكون'**
  String get iAm;

  /// No description provided for @serviceProviderRole.
  ///
  /// In ar, this message translates to:
  /// **'مقدم خدمة'**
  String get serviceProviderRole;

  /// No description provided for @serviceProviderRoleSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أنا صاحب حرفة وأقدم خدمات احترافية'**
  String get serviceProviderRoleSubtitle;

  /// No description provided for @findServiceRole.
  ///
  /// In ar, this message translates to:
  /// **'أبحث عن خدمة'**
  String get findServiceRole;

  /// No description provided for @findServiceRoleSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أنا عميل أبحث عن خدمات منزلية'**
  String get findServiceRoleSubtitle;

  /// No description provided for @continueLabel.
  ///
  /// In ar, this message translates to:
  /// **'استمرار'**
  String get continueLabel;

  /// No description provided for @noServicesAddedYet.
  ///
  /// In ar, this message translates to:
  /// **'لم تقم بإضافة أي خدمات بعد'**
  String get noServicesAddedYet;

  /// No description provided for @loading.
  ///
  /// In ar, this message translates to:
  /// **'جاري التحميل...'**
  String get loading;

  /// No description provided for @noPlansAvailable.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد خطط متاحة حالياً'**
  String get noPlansAvailable;

  /// No description provided for @retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get retry;

  /// No description provided for @tapForDetails.
  ///
  /// In ar, this message translates to:
  /// **'اضغط للتفاصيل'**
  String get tapForDetails;

  /// No description provided for @priceInRiyals.
  ///
  /// In ar, this message translates to:
  /// **'{price} ريال'**
  String priceInRiyals(String price);

  /// No description provided for @free.
  ///
  /// In ar, this message translates to:
  /// **'مجاني'**
  String get free;

  /// No description provided for @noFollowingUsers.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد مستخدمون تتابعهم حالياً'**
  String get noFollowingUsers;

  /// No description provided for @unknown.
  ///
  /// In ar, this message translates to:
  /// **'غير معروف'**
  String get unknown;

  /// No description provided for @locationNotSet.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم تحديد الموقع'**
  String get locationNotSet;

  /// No description provided for @editAddress.
  ///
  /// In ar, this message translates to:
  /// **'تعديل العنوان'**
  String get editAddress;

  /// No description provided for @enterAddress.
  ///
  /// In ar, this message translates to:
  /// **'اكتب العنوان'**
  String get enterAddress;

  /// No description provided for @updateDetails.
  ///
  /// In ar, this message translates to:
  /// **'تعديل البيانات'**
  String get updateDetails;

  /// No description provided for @address.
  ///
  /// In ar, this message translates to:
  /// **'العنوان'**
  String get address;

  /// No description provided for @edit.
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get edit;

  /// No description provided for @deleteChat.
  ///
  /// In ar, this message translates to:
  /// **'حذف المحادثة'**
  String get deleteChat;

  /// No description provided for @chatDeleted.
  ///
  /// In ar, this message translates to:
  /// **'تم حذف المحادثة'**
  String get chatDeleted;

  /// No description provided for @noStoryViewsYet.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد مشاهدات بعد'**
  String get noStoryViewsYet;

  /// No description provided for @faqTitle.
  ///
  /// In ar, this message translates to:
  /// **'الأسئلة الشائعة'**
  String get faqTitle;

  /// No description provided for @faqHowAddService.
  ///
  /// In ar, this message translates to:
  /// **'كيف أضيف خدمة؟'**
  String get faqHowAddService;

  /// No description provided for @faqHowAddServiceAnswer.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك إضافة خدمة من خلال زر إضافة خدمة في الصفحة الرئيسية.'**
  String get faqHowAddServiceAnswer;

  /// No description provided for @faqHowContactProvider.
  ///
  /// In ar, this message translates to:
  /// **'كيف أتواصل مع مقدم الخدمة؟'**
  String get faqHowContactProvider;

  /// No description provided for @faqHowContactProviderAnswer.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك التواصل عبر زر المحادثة داخل التطبيق.'**
  String get faqHowContactProviderAnswer;

  /// No description provided for @faqIsDataSecure.
  ///
  /// In ar, this message translates to:
  /// **'هل البيانات آمنة؟'**
  String get faqIsDataSecure;

  /// No description provided for @faqIsDataSecureAnswer.
  ///
  /// In ar, this message translates to:
  /// **'نعم، جميع بياناتك محمية ولا يتم مشاركتها بدون إذنك.'**
  String get faqIsDataSecureAnswer;

  /// No description provided for @faqHowEditProfile.
  ///
  /// In ar, this message translates to:
  /// **'كيف أعدل بياناتي؟'**
  String get faqHowEditProfile;

  /// No description provided for @faqHowEditProfileAnswer.
  ///
  /// In ar, this message translates to:
  /// **'من صفحة الملف الشخصي اختر تعديل البيانات.'**
  String get faqHowEditProfileAnswer;

  /// No description provided for @faqCanDeleteAccount.
  ///
  /// In ar, this message translates to:
  /// **'هل يمكنني حذف حسابي؟'**
  String get faqCanDeleteAccount;

  /// No description provided for @faqCanDeleteAccountAnswer.
  ///
  /// In ar, this message translates to:
  /// **'نعم، يمكنك حذف حسابك من إعدادات الحساب.'**
  String get faqCanDeleteAccountAnswer;

  /// No description provided for @faqHowAddWorkPhotos.
  ///
  /// In ar, this message translates to:
  /// **'كيف أضيف صور لأعمالي؟'**
  String get faqHowAddWorkPhotos;

  /// No description provided for @faqHowAddWorkPhotosAnswer.
  ///
  /// In ar, this message translates to:
  /// **'من صفحة الخدمة يمكنك إضافة صور من المعرض.'**
  String get faqHowAddWorkPhotosAnswer;

  /// No description provided for @faqHowEditService.
  ///
  /// In ar, this message translates to:
  /// **'كيف أعدل الخدمة؟'**
  String get faqHowEditService;

  /// No description provided for @faqHowEditServiceAnswer.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك تعديل الخدمة من صفحة تفاصيل الخدمة الخاصة بك.'**
  String get faqHowEditServiceAnswer;

  /// No description provided for @faqHowViewRatings.
  ///
  /// In ar, this message translates to:
  /// **'كيف أرى التقييمات؟'**
  String get faqHowViewRatings;

  /// No description provided for @faqHowViewRatingsAnswer.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك مشاهدة التقييمات من صفحة الخدمة الخاصة بك.'**
  String get faqHowViewRatingsAnswer;

  /// No description provided for @faqMultipleWorkAreas.
  ///
  /// In ar, this message translates to:
  /// **'هل يمكنني العمل في أكثر من منطقة؟'**
  String get faqMultipleWorkAreas;

  /// No description provided for @faqMultipleWorkAreasAnswer.
  ///
  /// In ar, this message translates to:
  /// **'نعم، يمكنك إضافة أكثر من منطقة عمل.'**
  String get faqMultipleWorkAreasAnswer;

  /// No description provided for @faqIsAppFree.
  ///
  /// In ar, this message translates to:
  /// **'هل التطبيق مجاني؟'**
  String get faqIsAppFree;

  /// No description provided for @faqIsAppFreeAnswer.
  ///
  /// In ar, this message translates to:
  /// **'نعم، التطبيق مجاني للاستخدام.'**
  String get faqIsAppFreeAnswer;

  /// No description provided for @faqCanEditPhone.
  ///
  /// In ar, this message translates to:
  /// **'هل يمكنني تعديل رقم الهاتف؟'**
  String get faqCanEditPhone;

  /// No description provided for @faqCanEditPhoneAnswer.
  ///
  /// In ar, this message translates to:
  /// **'نعم، ويمكنك تأكيده عبر OTP.'**
  String get faqCanEditPhoneAnswer;

  /// No description provided for @faqHowVerifyAccount.
  ///
  /// In ar, this message translates to:
  /// **'كيف يتم تأكيد الحساب؟'**
  String get faqHowVerifyAccount;

  /// No description provided for @faqHowVerifyAccountAnswer.
  ///
  /// In ar, this message translates to:
  /// **'يتم تأكيد الحساب من خلال رمز OTP.'**
  String get faqHowVerifyAccountAnswer;

  /// No description provided for @faqCanChangeServiceType.
  ///
  /// In ar, this message translates to:
  /// **'هل يمكنني تغيير نوع الخدمة؟'**
  String get faqCanChangeServiceType;

  /// No description provided for @faqCanChangeServiceTypeAnswer.
  ///
  /// In ar, this message translates to:
  /// **'نعم من خلال تعديل بيانات الخدمة.'**
  String get faqCanChangeServiceTypeAnswer;

  /// No description provided for @faqHowReportProblem.
  ///
  /// In ar, this message translates to:
  /// **'كيف أبلغ عن مشكلة؟'**
  String get faqHowReportProblem;

  /// No description provided for @faqHowReportProblemAnswer.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك التواصل معنا من داخل التطبيق.'**
  String get faqHowReportProblemAnswer;

  /// No description provided for @faqIsSupportAvailable.
  ///
  /// In ar, this message translates to:
  /// **'هل يوجد دعم فني؟'**
  String get faqIsSupportAvailable;

  /// No description provided for @faqIsSupportAvailableAnswer.
  ///
  /// In ar, this message translates to:
  /// **'نعم، يوجد دعم فني متاح داخل التطبيق.'**
  String get faqIsSupportAvailableAnswer;

  /// No description provided for @faqUseWithoutRegistration.
  ///
  /// In ar, this message translates to:
  /// **'هل يمكنني استخدام التطبيق بدون تسجيل؟'**
  String get faqUseWithoutRegistration;

  /// No description provided for @faqUseWithoutRegistrationAnswer.
  ///
  /// In ar, this message translates to:
  /// **'بعض الميزات تتطلب تسجيل الدخول.'**
  String get faqUseWithoutRegistrationAnswer;

  /// No description provided for @privacyWelcomeTitle.
  ///
  /// In ar, this message translates to:
  /// **'مرحبًا بك في تطبيق \"Fixgo\"'**
  String get privacyWelcomeTitle;

  /// No description provided for @privacyIntroduction.
  ///
  /// In ar, this message translates to:
  /// **'نحن نحترم خصوصيتك ونلتزم بحماية بياناتك الشخصية. توضح هذه السياسة كيفية جمع واستخدام ومشاركة معلوماتك عند استخدام التطبيق.'**
  String get privacyIntroduction;

  /// No description provided for @privacyCollectedInfoTitle.
  ///
  /// In ar, this message translates to:
  /// **'1. المعلومات التي نقوم بجمعها'**
  String get privacyCollectedInfoTitle;

  /// No description provided for @privacyProvidedInfoTitle.
  ///
  /// In ar, this message translates to:
  /// **'المعلومات التي تقدمها بنفسك:'**
  String get privacyProvidedInfoTitle;

  /// No description provided for @privacyNameOptional.
  ///
  /// In ar, this message translates to:
  /// **'الاسم (إن وجد)'**
  String get privacyNameOptional;

  /// No description provided for @privacyPhoneNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف'**
  String get privacyPhoneNumber;

  /// No description provided for @privacyEnteredInformation.
  ///
  /// In ar, this message translates to:
  /// **'أي معلومات تقوم بإدخالها داخل التطبيق'**
  String get privacyEnteredInformation;

  /// No description provided for @privacyAutomaticInfoTitle.
  ///
  /// In ar, this message translates to:
  /// **'معلومات يتم جمعها تلقائيًا:'**
  String get privacyAutomaticInfoTitle;

  /// No description provided for @privacyLocation.
  ///
  /// In ar, this message translates to:
  /// **'الموقع الجغرافي'**
  String get privacyLocation;

  /// No description provided for @privacyDeviceAndOs.
  ///
  /// In ar, this message translates to:
  /// **'نوع الجهاز ونظام التشغيل'**
  String get privacyDeviceAndOs;

  /// No description provided for @privacyUsageData.
  ///
  /// In ar, this message translates to:
  /// **'بيانات الاستخدام داخل التطبيق'**
  String get privacyUsageData;

  /// No description provided for @privacyUseInfoTitle.
  ///
  /// In ar, this message translates to:
  /// **'2. كيفية استخدام المعلومات'**
  String get privacyUseInfoTitle;

  /// No description provided for @privacyUseNearbyServices.
  ///
  /// In ar, this message translates to:
  /// **'عرض الحرفيين والخدمات القريبة منك'**
  String get privacyUseNearbyServices;

  /// No description provided for @privacyUseImproveExperience.
  ///
  /// In ar, this message translates to:
  /// **'تحسين تجربة المستخدم داخل التطبيق'**
  String get privacyUseImproveExperience;

  /// No description provided for @privacyUseDevelopServices.
  ///
  /// In ar, this message translates to:
  /// **'تطوير وتحسين خدماتنا'**
  String get privacyUseDevelopServices;

  /// No description provided for @privacyUseContactYou.
  ///
  /// In ar, this message translates to:
  /// **'التواصل معك عند الحاجة'**
  String get privacyUseContactYou;

  /// No description provided for @privacySharingTitle.
  ///
  /// In ar, this message translates to:
  /// **'3. مشاركة المعلومات'**
  String get privacySharingTitle;

  /// No description provided for @privacyNoDataSales.
  ///
  /// In ar, this message translates to:
  /// **'نحن لا نقوم ببيع بياناتك الشخصية لأي طرف ثالث.'**
  String get privacyNoDataSales;

  /// No description provided for @privacySharingWhatsApp.
  ///
  /// In ar, this message translates to:
  /// **'عند تواصلك مع أحد الحرفيين عبر واتساب'**
  String get privacySharingWhatsApp;

  /// No description provided for @privacySharingLegal.
  ///
  /// In ar, this message translates to:
  /// **'للامتثال للمتطلبات القانونية إذا لزم الأمر'**
  String get privacySharingLegal;

  /// No description provided for @privacyWhatsAppTitle.
  ///
  /// In ar, this message translates to:
  /// **'4. التواصل عبر واتساب'**
  String get privacyWhatsAppTitle;

  /// No description provided for @privacyWhatsAppDescription.
  ///
  /// In ar, this message translates to:
  /// **'يتيح لك التطبيق التواصل مباشرة مع مقدمي الخدمات عبر تطبيق واتساب.'**
  String get privacyWhatsAppDescription;

  /// No description provided for @privacyWhatsAppPolicy.
  ///
  /// In ar, this message translates to:
  /// **'أي تواصل يتم عبر واتساب يخضع لسياسة الخصوصية الخاصة بـ WhatsApp'**
  String get privacyWhatsAppPolicy;

  /// No description provided for @privacyExternalContentDisclaimer.
  ///
  /// In ar, this message translates to:
  /// **'نحن غير مسؤولين عن أي محتوى أو اتفاق يتم خارج التطبيق'**
  String get privacyExternalContentDisclaimer;

  /// No description provided for @cannotOpenWhatsApp.
  ///
  /// In ar, this message translates to:
  /// **'تعذر فتح تطبيق واتساب.'**
  String get cannotOpenWhatsApp;

  /// No description provided for @chatAction.
  ///
  /// In ar, this message translates to:
  /// **'محادثة'**
  String get chatAction;

  /// No description provided for @whatsappAction.
  ///
  /// In ar, this message translates to:
  /// **'واتساب'**
  String get whatsappAction;

  /// No description provided for @callAction.
  ///
  /// In ar, this message translates to:
  /// **'مكالمة'**
  String get callAction;

  /// No description provided for @boostViews.
  ///
  /// In ar, this message translates to:
  /// **'زيادة المشاهدات'**
  String get boostViews;

  /// No description provided for @boostViewsSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'اجذب المزيد من الناس لك بسهولة.'**
  String get boostViewsSubtitle;

  /// No description provided for @packageView.
  ///
  /// In ar, this message translates to:
  /// **'مشاهدة'**
  String get packageView;

  /// No description provided for @packageDurationDays.
  ///
  /// In ar, this message translates to:
  /// **'المدة بالأيام'**
  String get packageDurationDays;

  /// No description provided for @bankTransferNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم التحويل البنكي: {number}'**
  String bankTransferNumber(String number);

  /// No description provided for @accountNumberCopied.
  ///
  /// In ar, this message translates to:
  /// **'تم نسخ رقم الحساب'**
  String get accountNumberCopied;

  /// No description provided for @price.
  ///
  /// In ar, this message translates to:
  /// **'السعر'**
  String get price;

  /// No description provided for @subscribeNow.
  ///
  /// In ar, this message translates to:
  /// **'اشترك الآن'**
  String get subscribeNow;

  /// No description provided for @selectCategory.
  ///
  /// In ar, this message translates to:
  /// **'اختر التصنيف'**
  String get selectCategory;

  /// No description provided for @enterServiceTitle.
  ///
  /// In ar, this message translates to:
  /// **'اكتب عنوان الخدمة'**
  String get enterServiceTitle;

  /// No description provided for @enterServiceDescription.
  ///
  /// In ar, this message translates to:
  /// **'اكتب وصف الخدمة'**
  String get enterServiceDescription;

  /// No description provided for @selectServiceImage.
  ///
  /// In ar, this message translates to:
  /// **'اختر صورة الخدمة'**
  String get selectServiceImage;

  /// No description provided for @selectCurrentLocation.
  ///
  /// In ar, this message translates to:
  /// **'حدد موقعك الحالي'**
  String get selectCurrentLocation;

  /// No description provided for @uploadingImages.
  ///
  /// In ar, this message translates to:
  /// **'جاري رفع الصور...'**
  String get uploadingImages;

  /// No description provided for @serviceImage.
  ///
  /// In ar, this message translates to:
  /// **'صورة الخدمة'**
  String get serviceImage;

  /// No description provided for @tapToUploadImage.
  ///
  /// In ar, this message translates to:
  /// **'اضغط لرفع الصورة'**
  String get tapToUploadImage;

  /// No description provided for @serviceTitle.
  ///
  /// In ar, this message translates to:
  /// **'عنوان الخدمة'**
  String get serviceTitle;

  /// No description provided for @serviceDescriptionHint.
  ///
  /// In ar, this message translates to:
  /// **'اكتب وصفاً لخدمتك'**
  String get serviceDescriptionHint;

  /// No description provided for @selectLocation.
  ///
  /// In ar, this message translates to:
  /// **'حدد موقعك'**
  String get selectLocation;

  /// No description provided for @locationSelected.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديد موقعك ✅'**
  String get locationSelected;

  /// No description provided for @uploadingService.
  ///
  /// In ar, this message translates to:
  /// **'جاري رفع الخدمة...'**
  String get uploadingService;

  /// No description provided for @selfReviewNotAllowed.
  ///
  /// In ar, this message translates to:
  /// **'لا يمكنك تقييم نفسك'**
  String get selfReviewNotAllowed;

  /// No description provided for @reviewSentSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال التقييم بنجاح ✅'**
  String get reviewSentSuccess;

  /// No description provided for @noServiceProviders.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد مقدمو خدمة'**
  String get noServiceProviders;

  /// No description provided for @practicalExperience.
  ///
  /// In ar, this message translates to:
  /// **'خبرة عملية'**
  String get practicalExperience;

  /// No description provided for @addWorkArea.
  ///
  /// In ar, this message translates to:
  /// **'إضافة منطقة عمل'**
  String get addWorkArea;

  /// No description provided for @enterArea.
  ///
  /// In ar, this message translates to:
  /// **'أدخل المنطقة'**
  String get enterArea;

  /// No description provided for @add.
  ///
  /// In ar, this message translates to:
  /// **'إضافة'**
  String get add;

  /// No description provided for @addImage.
  ///
  /// In ar, this message translates to:
  /// **'إضافة صورة'**
  String get addImage;

  /// No description provided for @sort.
  ///
  /// In ar, this message translates to:
  /// **'ترتيب'**
  String get sort;

  /// No description provided for @managePackages.
  ///
  /// In ar, this message translates to:
  /// **'إدارة الباقات'**
  String get managePackages;

  /// No description provided for @packageActive.
  ///
  /// In ar, this message translates to:
  /// **'باقتك مفعلة!'**
  String get packageActive;

  /// No description provided for @remainingViews.
  ///
  /// In ar, this message translates to:
  /// **'المشاهدات المتبقية'**
  String get remainingViews;

  /// No description provided for @active.
  ///
  /// In ar, this message translates to:
  /// **'مفعّلة'**
  String get active;

  /// No description provided for @expiryDate.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الانتهاء'**
  String get expiryDate;

  /// No description provided for @unspecified.
  ///
  /// In ar, this message translates to:
  /// **'غير محدد'**
  String get unspecified;

  /// No description provided for @performance.
  ///
  /// In ar, this message translates to:
  /// **'الأداء'**
  String get performance;

  /// No description provided for @packageRemaining.
  ///
  /// In ar, this message translates to:
  /// **'متبقي من الباقة'**
  String get packageRemaining;

  /// No description provided for @consumptionRate.
  ///
  /// In ar, this message translates to:
  /// **'نسبة الاستهلاك'**
  String get consumptionRate;

  /// No description provided for @consumed.
  ///
  /// In ar, this message translates to:
  /// **'تم استهلاكه'**
  String get consumed;

  /// No description provided for @expired.
  ///
  /// In ar, this message translates to:
  /// **'منتهية'**
  String get expired;

  /// No description provided for @expiresToday.
  ///
  /// In ar, this message translates to:
  /// **'ينتهي اليوم'**
  String get expiresToday;

  /// No description provided for @daysRemaining.
  ///
  /// In ar, this message translates to:
  /// **'متبقي {count} أيام'**
  String daysRemaining(int count);

  /// No description provided for @choosePackage.
  ///
  /// In ar, this message translates to:
  /// **'اختر الباقة المناسبة لك'**
  String get choosePackage;

  /// No description provided for @boostPackageSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'زد ظهور خدمتك لعدد أكبر من العملاء المحتملين'**
  String get boostPackageSubtitle;

  /// No description provided for @whatsappSubscribeMessage.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً، أريد الاشتراك في {title}'**
  String whatsappSubscribeMessage(String title);

  /// No description provided for @imageUpdatedSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث الصورة بنجاح'**
  String get imageUpdatedSuccess;

  /// No description provided for @serviceBioRequired.
  ///
  /// In ar, this message translates to:
  /// **'يرجى كتابة نبذة عن الخدمة'**
  String get serviceBioRequired;

  /// No description provided for @serviceUpdatedSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم تعديل الخدمة بنجاح'**
  String get serviceUpdatedSuccess;

  /// No description provided for @editService.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الخدمة'**
  String get editService;

  /// No description provided for @writeServiceBio.
  ///
  /// In ar, this message translates to:
  /// **'اكتب نبذة عن خدمتك'**
  String get writeServiceBio;

  /// No description provided for @scientificExperience.
  ///
  /// In ar, this message translates to:
  /// **'خبرة مهنية'**
  String get scientificExperience;

  /// No description provided for @area.
  ///
  /// In ar, this message translates to:
  /// **'المنطقة'**
  String get area;

  /// No description provided for @ratingsCount.
  ///
  /// In ar, this message translates to:
  /// **'({count}) تقييم'**
  String ratingsCount(int count);

  /// No description provided for @servicesProvided.
  ///
  /// In ar, this message translates to:
  /// **'خدمات يقدمها'**
  String get servicesProvided;

  /// No description provided for @noServices.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد خدمات'**
  String get noServices;

  /// No description provided for @cannotChatWithSelf.
  ///
  /// In ar, this message translates to:
  /// **'لا يمكنك بدء محادثة مع نفسك'**
  String get cannotChatWithSelf;

  /// No description provided for @noServicesCurrently.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد خدمات حالياً'**
  String get noServicesCurrently;

  /// No description provided for @serviceCategories.
  ///
  /// In ar, this message translates to:
  /// **'تصنيفات الخدمات'**
  String get serviceCategories;

  /// No description provided for @homeMaintenanceServices.
  ///
  /// In ar, this message translates to:
  /// **'خدمات الصيانة المنزلية'**
  String get homeMaintenanceServices;

  /// No description provided for @finishingConstructionServices.
  ///
  /// In ar, this message translates to:
  /// **'خدمات التشطيب والمقاولات'**
  String get finishingConstructionServices;

  /// No description provided for @cleaningServices.
  ///
  /// In ar, this message translates to:
  /// **'خدمات التنظيف'**
  String get cleaningServices;

  /// No description provided for @transportDeliveryServices.
  ///
  /// In ar, this message translates to:
  /// **'خدمات النقل والتوصيل'**
  String get transportDeliveryServices;

  /// No description provided for @administrativeServices.
  ///
  /// In ar, this message translates to:
  /// **'خدمات إدارية'**
  String get administrativeServices;

  /// No description provided for @finishing.
  ///
  /// In ar, this message translates to:
  /// **'تشطيب'**
  String get finishing;

  /// No description provided for @homeAppliances.
  ///
  /// In ar, this message translates to:
  /// **'أجهزة منزلية'**
  String get homeAppliances;

  /// No description provided for @washingMachines.
  ///
  /// In ar, this message translates to:
  /// **'غسالات'**
  String get washingMachines;

  /// No description provided for @ceramic.
  ///
  /// In ar, this message translates to:
  /// **'سيراميك'**
  String get ceramic;

  /// No description provided for @gypsumBoard.
  ///
  /// In ar, this message translates to:
  /// **'جبس بورد'**
  String get gypsumBoard;

  /// No description provided for @kitchens.
  ///
  /// In ar, this message translates to:
  /// **'مطابخ'**
  String get kitchens;

  /// No description provided for @parquet.
  ///
  /// In ar, this message translates to:
  /// **'باركيه'**
  String get parquet;

  /// No description provided for @constructionWork.
  ///
  /// In ar, this message translates to:
  /// **'أعمال بناء'**
  String get constructionWork;

  /// No description provided for @decor.
  ///
  /// In ar, this message translates to:
  /// **'ديكور'**
  String get decor;

  /// No description provided for @homes.
  ///
  /// In ar, this message translates to:
  /// **'منازل'**
  String get homes;

  /// No description provided for @offices.
  ///
  /// In ar, this message translates to:
  /// **'مكاتب'**
  String get offices;

  /// No description provided for @carpets.
  ///
  /// In ar, this message translates to:
  /// **'سجاد'**
  String get carpets;

  /// No description provided for @tanks.
  ///
  /// In ar, this message translates to:
  /// **'خزانات'**
  String get tanks;

  /// No description provided for @glassFacades.
  ///
  /// In ar, this message translates to:
  /// **'واجهات زجاج'**
  String get glassFacades;

  /// No description provided for @furnitureMoving.
  ///
  /// In ar, this message translates to:
  /// **'نقل عفش'**
  String get furnitureMoving;

  /// No description provided for @furnitureRelocation.
  ///
  /// In ar, this message translates to:
  /// **'تحريك أثاث'**
  String get furnitureRelocation;

  /// No description provided for @orderDelivery.
  ///
  /// In ar, this message translates to:
  /// **'توصيل طلبات'**
  String get orderDelivery;

  /// No description provided for @governmentFollowUp.
  ///
  /// In ar, this message translates to:
  /// **'تعقيب'**
  String get governmentFollowUp;

  /// No description provided for @paperworkClearance.
  ///
  /// In ar, this message translates to:
  /// **'تخليص أوراق'**
  String get paperworkClearance;

  /// No description provided for @governmentServices.
  ///
  /// In ar, this message translates to:
  /// **'خدمات حكومية'**
  String get governmentServices;

  /// No description provided for @applySort.
  ///
  /// In ar, this message translates to:
  /// **'تطبيق الترتيب'**
  String get applySort;

  /// No description provided for @yearsExperienceCount.
  ///
  /// In ar, this message translates to:
  /// **'عدد سنين الخبرة'**
  String get yearsExperienceCount;

  /// No description provided for @experiencePlusYears.
  ///
  /// In ar, this message translates to:
  /// **'{value}+ سنة'**
  String experiencePlusYears(int value);

  /// No description provided for @enableGps.
  ///
  /// In ar, this message translates to:
  /// **'من فضلك قم بتفعيل خدمة الموقع (GPS)'**
  String get enableGps;

  /// No description provided for @locationPermissionDenied.
  ///
  /// In ar, this message translates to:
  /// **'تم رفض صلاحية الوصول للموقع'**
  String get locationPermissionDenied;

  /// No description provided for @locationPermissionDeniedForever.
  ///
  /// In ar, this message translates to:
  /// **'تم رفض صلاحية الموقع نهائياً، افتح الإعدادات لتفعيلها'**
  String get locationPermissionDeniedForever;

  /// No description provided for @addressSeparator.
  ///
  /// In ar, this message translates to:
  /// **'، '**
  String get addressSeparator;

  /// No description provided for @accountType.
  ///
  /// In ar, this message translates to:
  /// **' نوع الحساب'**
  String get accountType;

  /// No description provided for @onboarding_service_title.
  ///
  /// In ar, this message translates to:
  /// **'وقتك يهمنا... اختر نوع الطلب المناسب'**
  String get onboarding_service_title;

  /// No description provided for @onboarding_service_desc.
  ///
  /// In ar, this message translates to:
  /// **'✔ الطارئ للتدخل الفور\n ✔ العاجل خلال ساعات\n ✔ المجدول في الوقت الذي يناسبك'**
  String get onboarding_service_desc;

  /// No description provided for @onboarding_technician_title.
  ///
  /// In ar, this message translates to:
  /// **'خليك مطمن... تابع طلبك لحظة بلحظة'**
  String get onboarding_technician_title;

  /// No description provided for @onboarding_technician_desc.
  ///
  /// In ar, this message translates to:
  /// **'✔ تتبع مباشر لحالة الطلب والتنفيذ\n ✔ استلم تحديثات وصور أثناء العمل\n ✔ تقييمات وفاتورة إلكترونية بعد إنهاء الطلب'**
  String get onboarding_technician_desc;

  /// No description provided for @onboarding_track_title.
  ///
  /// In ar, this message translates to:
  /// **'تابع طلبك'**
  String get onboarding_track_title;

  /// No description provided for @onboarding_track_desc.
  ///
  /// In ar, this message translates to:
  /// **'تابع حالة طلبك لحظة بلحظة من وقت الطلب لحد الانتهاء'**
  String get onboarding_track_desc;

  /// No description provided for @onboarding_quality_title.
  ///
  /// In ar, this message translates to:
  /// **'فريق واحد... لكل احتياجات منزلك'**
  String get onboarding_quality_title;

  /// No description provided for @onboarding_quality_desc.
  ///
  /// In ar, this message translates to:
  /// **'✔ فنيون معتمدون \n✔ جميع الخدمات تحت سقف واحد\n✔ تنفيذ سريع وجودة مضمونة'**
  String get onboarding_quality_desc;

  /// No description provided for @startNow.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ الآن'**
  String get startNow;

  /// No description provided for @freelancer.
  ///
  /// In ar, this message translates to:
  /// **'عامل حر'**
  String get freelancer;

  /// No description provided for @company.
  ///
  /// In ar, this message translates to:
  /// **'شركة'**
  String get company;

  /// No description provided for @accountSuspended.
  ///
  /// In ar, this message translates to:
  /// **'تم حظر حسابك، يرجى التواصل مع الدعم.'**
  String get accountSuspended;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
