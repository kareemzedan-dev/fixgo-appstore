// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get verificationTitle => 'Verify your account';

  @override
  String get verificationTitleShort => 'Account verification';

  @override
  String get verificationHeadline =>
      'Verify your account to increase customer trust';

  @override
  String get verificationDescription =>
      'Verifying your account helps you appear better\nand increases customer interest';

  @override
  String get verificationFeatureSearch => 'Better appearance in search results';

  @override
  String get verificationFeatureTrust => 'Increased customer trust in you';

  @override
  String get verificationFeatureBadge => 'Verified badge on your account';

  @override
  String get verificationStart => 'Start verification';

  @override
  String get verificationPendingTitle => 'Verification request under review';

  @override
  String get verificationPendingSubtitle =>
      'Your data is being reviewed and you will be notified when finished';

  @override
  String get verificationApprovedTitle =>
      'Your account has been verified successfully';

  @override
  String get verificationApprovedSubtitle =>
      'Your account is now verified and customers can see the verification badge';

  @override
  String get verificationRejectedTitle => 'Verification request rejected';

  @override
  String get verificationRejectedSubtitle =>
      'Please re-upload clearer photos and try again';

  @override
  String get verificationRetry => 'Re-verify';

  @override
  String get verificationFrontTitle => 'Front ID photo';

  @override
  String get verificationFrontSubtitle =>
      'Upload the front side of your personal ID';

  @override
  String get verificationBackTitle => 'Back ID photo';

  @override
  String get verificationBackSubtitle =>
      'Upload the back side of your personal ID';

  @override
  String get verificationTipsTitle => 'Tips for a clear photo:';

  @override
  String get verificationTipClarity => '• Make sure all details are clear';

  @override
  String get verificationTipLighting => '• Use good lighting';

  @override
  String get verificationTipAngle => '• Avoid side-angle photos';

  @override
  String get verificationTapToUpload => 'Tap to upload photo';

  @override
  String get verificationSubmit => 'Verify your account';

  @override
  String get verificationCompleteUploads => 'Complete photo uploads';

  @override
  String get verificationIncompleteImages => 'Please upload complete ID photos';

  @override
  String get verificationSubmitSuccess =>
      'Verification request sent successfully';

  @override
  String get verificationSubmitFailed => 'Failed to send verification request';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsMarkAllRead => 'Mark all as read';

  @override
  String get notificationsDeleteAll => 'Delete all';

  @override
  String get notificationsEmpty => 'No notifications';

  @override
  String get notificationsDeleteOne => 'Delete notification';

  @override
  String get notificationsAttachedFile => 'Attached file';

  @override
  String get logout => 'Log out';

  @override
  String get logoutConfirmTitle => 'Log out';

  @override
  String get logoutConfirmMessage => 'Are you sure you want to log out?';

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get deleteAccountConfirmTitle => 'Delete account';

  @override
  String get deleteAccountConfirmMessage =>
      '⚠️ Your account will be permanently deleted and cannot be recovered.\nAre you sure?';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get genericError => 'An error occurred';

  @override
  String get forgotPasswordTitle => 'Forgot password';

  @override
  String get sendVerificationCode => 'Send verification code';

  @override
  String get otpSentSuccess => 'Verification code sent';

  @override
  String get createNewPasswordTitle => 'Create new password';

  @override
  String get save => 'Save';

  @override
  String get otpTitle => 'Verification code';

  @override
  String get skip => 'Skip';

  @override
  String get onboardingTitle1 =>
      'Looking for a trusted craftsman and\ndon\'t know where to start?';

  @override
  String get onboardingDesc1 =>
      'You ask a lot and try more than one person, and in the end\nyour time and effort are wasted.';

  @override
  String get onboardingTitle2 => 'All craftsmen in one\nplace near you';

  @override
  String get onboardingDesc2 =>
      'Choose from the best craftsmen near you, and check\nreviews before deciding.';

  @override
  String get onboardingTitle3 =>
      'Contact the right craftsman\nfor your problem immediately';

  @override
  String get onboardingDesc3 =>
      'Contact him directly via WhatsApp, and get all your work\ndone quickly and easily.';

  @override
  String get enterFullOtp => 'Please enter the full verification code';

  @override
  String get invalidOtp => 'Invalid code';

  @override
  String get otpResent => 'Code resent';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get passwordChangedSuccess => 'Password changed successfully';

  @override
  String get previous => 'Previous';

  @override
  String get enterOtpTitle => 'Enter code';

  @override
  String enterOtpSubtitle(String phone) {
    return 'Enter the verification code sent to $phone';
  }

  @override
  String get resendOtp => 'Resend code';

  @override
  String get enterNewPasswordTitle => 'Create a new password';

  @override
  String get enterNewPasswordSubtitle => 'Enter your new password';

  @override
  String get newPasswordHint => 'New password';

  @override
  String get confirmPasswordHint => 'Confirm password';

  @override
  String get wrongPassword => 'Password is wrong';

  @override
  String get chatTitle => 'Chats';

  @override
  String get noChats => 'No chats';

  @override
  String get photoAttachment => '📷 Photo';

  @override
  String get docAttachment => '📄 Document';

  @override
  String get fileAttachment => '📎 Attached file';

  @override
  String get noMessages => 'No messages';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get download => 'Download';

  @override
  String get open => 'Open';

  @override
  String get writeYourMessage => 'Write your message';

  @override
  String get oneYear => '1 year';

  @override
  String get twoYears => '2 years';

  @override
  String get years => 'years';

  @override
  String get serviceDetails => 'Service details';

  @override
  String get serviceProvider => 'Service provider';

  @override
  String get serviceBio => 'About the service';

  @override
  String get serviceAreas => 'Service areas';

  @override
  String get businessGallery => 'Business gallery';

  @override
  String get reviewsAndRatings => 'Reviews and ratings';

  @override
  String get showAll => 'Show all';

  @override
  String get noReviewsYet => 'No reviews yet';

  @override
  String get addReview => 'Add review';

  @override
  String get sendReview => 'Send review';

  @override
  String get reviewHint => 'Write your review here...';

  @override
  String get ratingLabel => 'Rating';

  @override
  String get similarServices => 'Similar services';

  @override
  String get noSimilarServices => 'No similar services currently';

  @override
  String get follow => 'Follow';

  @override
  String get following => 'Following';

  @override
  String get reportService => 'Report service';

  @override
  String get user => 'User';

  @override
  String get language => 'Language';

  @override
  String get languageSubtitle => 'App language';

  @override
  String get arabic => 'Arabic';

  @override
  String get english => 'English';

  @override
  String get settings => 'Settings';

  @override
  String get privacyAndSecurity => 'Privacy and security';

  @override
  String get privacySubtitle => 'Privacy settings';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get darkModeSubtitle => 'Enable dark mode';

  @override
  String get login => 'Log in';

  @override
  String get accountSection => 'Account';

  @override
  String get authAccountCreated => 'Account created successfully';

  @override
  String get authLoginSuccess => 'Logged in successfully';

  @override
  String get authProfileUpdated => 'Profile updated successfully';

  @override
  String get authPhoneUpdated => 'Phone number updated successfully';

  @override
  String get authRegisterSuccess => 'Registered successfully';

  @override
  String get authOtpVerified => 'Code verified successfully';

  @override
  String get phoneNotRegistered => 'This number is not registered';

  @override
  String get guestNotLoggedIn => 'You are not logged in';

  @override
  String get guestLoginHint =>
      'Please log in to your account for a better experience';

  @override
  String get supportSection => 'Support';

  @override
  String get helpAndSupport => 'Help and support';

  @override
  String get helpAndSupportSubtitle => 'FAQs and contact';

  @override
  String get myServices => 'My services';

  @override
  String get myServicesSubtitle => 'Services you provide';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get editProfileSubtitle => 'Update your personal information';

  @override
  String get verificationMenuTitle => 'Verification';

  @override
  String get verificationMenuSubtitle => 'Verify your service provider account';

  @override
  String get upgradeAccount => 'Upgrade account';

  @override
  String get upgradeAccountSubtitle => 'Upgrade your account';

  @override
  String get createProviderAccount => 'Create a service provider account';

  @override
  String get createProviderAccountSubtitle =>
      'Convert your account to a service provider';

  @override
  String get peopleYouFollow => 'People you follow';

  @override
  String get peopleYouFollowSubtitle => 'Service providers you follow';

  @override
  String get notificationsManage => 'Notifications';

  @override
  String get notificationsManageSubtitle => 'Manage notifications';

  @override
  String get chatsNavigate => 'Chats';

  @override
  String get chatsNavigateSubtitle => 'Go to chats';

  @override
  String get requiredBadge => 'Required';

  @override
  String get imageUploadFailed => 'Failed to upload images';

  @override
  String get serviceAddedSuccess => 'Service added successfully';

  @override
  String get favoritesTitle => 'Favorites';

  @override
  String get noFavoriteServices => 'No favorite services';

  @override
  String get home => 'Home';

  @override
  String get services => 'Services';

  @override
  String get myAccount => 'My account';

  @override
  String homeGreeting(String name) {
    return 'Hello, $name';
  }

  @override
  String get workerHomeSubtitle =>
      'Keep track of your work and customer requests';

  @override
  String get customerHomeSubtitle =>
      'Solve your problems with the best craftspeople.';

  @override
  String get mostRequestedServices => 'Most requested services';

  @override
  String get airConditioning => 'Air conditioning';

  @override
  String get carpentry => 'Carpentry';

  @override
  String get painting => 'Painting';

  @override
  String get plumbing => 'Plumbing';

  @override
  String get electricity => 'Electricity';

  @override
  String get blacksmithing => 'Blacksmithing';

  @override
  String get nearbyServices => 'Services near you';

  @override
  String get noNearbyServices => 'There are no nearby services yet';

  @override
  String distanceKilometers(String value) {
    return '$value km';
  }

  @override
  String get recommendedServices => 'Recommended services';

  @override
  String get noRecommendedServices =>
      'There are no recommended services currently';

  @override
  String get searchForService => 'Search for a service';

  @override
  String get addService => 'Add service';

  @override
  String get providerAccountRequiredTitle => 'Register as a service provider';

  @override
  String get providerAccountRequiredMessage =>
      'Please convert your account to a service provider account\nto access this page';

  @override
  String get loginRequiredFirst => 'Please log in first';

  @override
  String get storyEmptyContent => 'Add text or an image at least';

  @override
  String get storyAddedSuccess => 'Story added successfully';

  @override
  String get addStory => 'Add story';

  @override
  String get storyText => 'Story text';

  @override
  String get storyTextHint => 'Write your story text';

  @override
  String get storyVisible24Hours =>
      'It will be visible to everyone for 24 hours';

  @override
  String get uploading => 'Uploading...';

  @override
  String get popularSearchPlumber => 'Plumber';

  @override
  String get popularSearchHomeElectrician => 'Home electrician';

  @override
  String get popularSearchProfessionalBlacksmith => 'Professional blacksmith';

  @override
  String get popularSearchGypsumBoardInstaller => 'Gypsum board installer';

  @override
  String get popularSearchFinishingContractor => 'Finishing contractor';

  @override
  String get popularSearchRenovationContractor => 'Renovation contractor';

  @override
  String get popularSearchAcTechnician => 'Air conditioning technician';

  @override
  String get popularSearchHomePainter => 'Home painter';

  @override
  String get searchHistory => 'Search history';

  @override
  String get popularSearches => 'Popular searches';

  @override
  String get search => 'Search';

  @override
  String searchResultsInArea(int count, String query) {
    return '$count results for \"$query\" in your area';
  }

  @override
  String get noResults => 'No results';

  @override
  String get filter => 'Filter';

  @override
  String get serviceCategory => 'Service category';

  @override
  String get selectServiceCategory => 'Select service category';

  @override
  String get service => 'Service';

  @override
  String get selectService => 'Select service';

  @override
  String get workerRating => 'Craftsperson rating';

  @override
  String get yearsExperience => 'Years of experience';

  @override
  String yearValue(int value) {
    return '$value year';
  }

  @override
  String get distance => 'Distance';

  @override
  String kilometerValue(int value) {
    return '$value km';
  }

  @override
  String get applyFilter => 'Apply filter';

  @override
  String get enterYearsOfExperience => 'Enter your years of experience';

  @override
  String get loginRequiredTitle => 'Log in to your account';

  @override
  String get loginRequiredPageMessage =>
      'Please log in to your account to access\nthis page';

  @override
  String get welcome => 'Welcome';

  @override
  String get enjoyYourJourney => 'We hope you have an enjoyable journey';

  @override
  String get username => 'Username';

  @override
  String get enterYourName => 'Enter your name';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get password => 'Password';

  @override
  String get otpLoginNotice =>
      'You will receive an OTP from Fixgo to confirm your login.';

  @override
  String get createAccount => 'Create account';

  @override
  String get enterUsername => 'Please enter your username';

  @override
  String get enterPhoneNumber => 'Please enter your phone number';

  @override
  String get phoneNumberNineDigits => 'Phone number must be exactly 8 digits';

  @override
  String get completeProviderDetails =>
      'Please complete the service provider details';

  @override
  String get tenPlusYears => '10+ years';

  @override
  String get phoneNumberEightDigits => 'Phone number must be 8 digits';

  @override
  String get phoneNumberStart789 => 'Number must start with 7, 8, or 9';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get welcomeBackSubtitle => 'We\'re happy to see you again. Log in now';

  @override
  String get loginInstruction =>
      'Enter your phone number and password to log in.';

  @override
  String get termsAndPrivacyAgreement =>
      'I agree to the terms and privacy policy';

  @override
  String get saveAddress => 'Save address';

  @override
  String get acceptTermsBeforeContinue =>
      'Please agree to the terms and privacy policy before continuing.';

  @override
  String get currentUserNotFound => 'Current user not found';

  @override
  String get allowLocationAccess => 'Allow location access';

  @override
  String get workerLocationDescription =>
      'We need your location to show you nearby customers and make it easier to reach them.';

  @override
  String get customerLocationDescription =>
      'We need your location to show you service providers nearby.';

  @override
  String get selectYourAddress => 'Select your address';

  @override
  String get addressDetailsSubtitle =>
      'Add your location details to complete the process';

  @override
  String get addAddressDetails => 'Add address details';

  @override
  String get useCurrentLocation => 'Use current location';

  @override
  String addressSummary(String street, String district, String city) {
    return '$street, $district, $city';
  }

  @override
  String get iAm => 'I am';

  @override
  String get serviceProviderRole => 'Service provider';

  @override
  String get serviceProviderRoleSubtitle =>
      'I am a skilled professional offering professional services';

  @override
  String get findServiceRole => 'Find a service';

  @override
  String get findServiceRoleSubtitle =>
      'I am a customer looking for home services';

  @override
  String get continueLabel => 'Continue';

  @override
  String get noServicesAddedYet => 'You have not added any services yet';

  @override
  String get loading => 'Loading...';

  @override
  String get noPlansAvailable => 'No plans are currently available';

  @override
  String get retry => 'Try again';

  @override
  String get tapForDetails => 'Tap for details';

  @override
  String priceInRiyals(String price) {
    return '$price SAR';
  }

  @override
  String get free => 'Free';

  @override
  String get noFollowingUsers => 'You are not following anyone yet';

  @override
  String get unknown => 'Unknown';

  @override
  String get locationNotSet => 'Location has not been set';

  @override
  String get editAddress => 'Edit address';

  @override
  String get enterAddress => 'Enter address';

  @override
  String get updateDetails => 'Update details';

  @override
  String get address => 'Address';

  @override
  String get edit => 'Edit';

  @override
  String get deleteChat => 'Delete chat';

  @override
  String get chatDeleted => 'Chat deleted';

  @override
  String get noStoryViewsYet => 'No views yet';

  @override
  String get faqTitle => 'Frequently asked questions';

  @override
  String get faqHowAddService => 'How do I add a service?';

  @override
  String get faqHowAddServiceAnswer =>
      'You can add a service using the Add Service button on the home page.';

  @override
  String get faqHowContactProvider => 'How do I contact a service provider?';

  @override
  String get faqHowContactProviderAnswer =>
      'You can contact them using the chat button in the app.';

  @override
  String get faqIsDataSecure => 'Is my data secure?';

  @override
  String get faqIsDataSecureAnswer =>
      'Yes, all your data is protected and is not shared without your permission.';

  @override
  String get faqHowEditProfile => 'How do I edit my information?';

  @override
  String get faqHowEditProfileAnswer =>
      'Open your profile page and select Edit Profile.';

  @override
  String get faqCanDeleteAccount => 'Can I delete my account?';

  @override
  String get faqCanDeleteAccountAnswer =>
      'Yes, you can delete your account from account settings.';

  @override
  String get faqHowAddWorkPhotos => 'How do I add photos of my work?';

  @override
  String get faqHowAddWorkPhotosAnswer =>
      'You can add photos from your gallery on the service page.';

  @override
  String get faqHowEditService => 'How do I edit a service?';

  @override
  String get faqHowEditServiceAnswer =>
      'You can edit it from your service details page.';

  @override
  String get faqHowViewRatings => 'How do I view ratings?';

  @override
  String get faqHowViewRatingsAnswer =>
      'You can view ratings on your service page.';

  @override
  String get faqMultipleWorkAreas => 'Can I work in more than one area?';

  @override
  String get faqMultipleWorkAreasAnswer =>
      'Yes, you can add more than one work area.';

  @override
  String get faqIsAppFree => 'Is the app free?';

  @override
  String get faqIsAppFreeAnswer => 'Yes, the app is free to use.';

  @override
  String get faqCanEditPhone => 'Can I change my phone number?';

  @override
  String get faqCanEditPhoneAnswer =>
      'Yes, and you can verify it using an OTP.';

  @override
  String get faqHowVerifyAccount => 'How is the account verified?';

  @override
  String get faqHowVerifyAccountAnswer =>
      'The account is verified using an OTP.';

  @override
  String get faqCanChangeServiceType => 'Can I change the service type?';

  @override
  String get faqCanChangeServiceTypeAnswer =>
      'Yes, by editing the service information.';

  @override
  String get faqHowReportProblem => 'How do I report a problem?';

  @override
  String get faqHowReportProblemAnswer =>
      'You can contact us from within the app.';

  @override
  String get faqIsSupportAvailable => 'Is technical support available?';

  @override
  String get faqIsSupportAvailableAnswer =>
      'Yes, technical support is available within the app.';

  @override
  String get faqUseWithoutRegistration =>
      'Can I use the app without registering?';

  @override
  String get faqUseWithoutRegistrationAnswer =>
      'Some features require you to log in.';

  @override
  String get privacyWelcomeTitle => 'Welcome to the \"Fixgo\" app';

  @override
  String get privacyIntroduction =>
      'We respect your privacy and are committed to protecting your personal data. This policy explains how we collect, use, and share your information when you use the app.';

  @override
  String get privacyCollectedInfoTitle => '1. Information we collect';

  @override
  String get privacyProvidedInfoTitle => 'Information you provide:';

  @override
  String get privacyNameOptional => 'Name (if provided)';

  @override
  String get privacyPhoneNumber => 'Phone number';

  @override
  String get privacyEnteredInformation =>
      'Any information you enter in the app';

  @override
  String get privacyAutomaticInfoTitle =>
      'Information collected automatically:';

  @override
  String get privacyLocation => 'Geographic location';

  @override
  String get privacyDeviceAndOs => 'Device type and operating system';

  @override
  String get privacyUsageData => 'In-app usage data';

  @override
  String get privacyUseInfoTitle => '2. How we use information';

  @override
  String get privacyUseNearbyServices =>
      'Show craftspeople and services near you';

  @override
  String get privacyUseImproveExperience =>
      'Improve your experience in the app';

  @override
  String get privacyUseDevelopServices => 'Develop and improve our services';

  @override
  String get privacyUseContactYou => 'Contact you when needed';

  @override
  String get privacySharingTitle => '3. Sharing information';

  @override
  String get privacyNoDataSales =>
      'We do not sell your personal data to any third party.';

  @override
  String get privacySharingWhatsApp =>
      'When you contact a craftsperson through WhatsApp';

  @override
  String get privacySharingLegal =>
      'To comply with legal requirements when necessary';

  @override
  String get privacyWhatsAppTitle => '4. Communication through WhatsApp';

  @override
  String get privacyWhatsAppDescription =>
      'The app lets you contact service providers directly through WhatsApp.';

  @override
  String get privacyWhatsAppPolicy =>
      'Any communication through WhatsApp is subject to WhatsApp\'s privacy policy';

  @override
  String get privacyExternalContentDisclaimer =>
      'We are not responsible for content or agreements made outside the app';

  @override
  String get cannotOpenWhatsApp => 'WhatsApp could not be opened.';

  @override
  String get chatAction => 'Chat';

  @override
  String get whatsappAction => 'WhatsApp';

  @override
  String get callAction => 'Call';

  @override
  String get boostViews => 'Boost views';

  @override
  String get boostViewsSubtitle => 'Reach more people easily.';

  @override
  String get packageView => 'View';

  @override
  String get packageDurationDays => 'Duration in days';

  @override
  String bankTransferNumber(String number) {
    return 'Bank transfer number: $number';
  }

  @override
  String get accountNumberCopied => 'Account number copied';

  @override
  String get price => 'Price';

  @override
  String get subscribeNow => 'Subscribe now';

  @override
  String get selectCategory => 'Select category';

  @override
  String get enterServiceTitle => 'Enter the service title';

  @override
  String get enterServiceDescription => 'Enter the service description';

  @override
  String get selectServiceImage => 'Select a service image';

  @override
  String get selectCurrentLocation => 'Select your current location';

  @override
  String get uploadingImages => 'Uploading images...';

  @override
  String get serviceImage => 'Service image';

  @override
  String get tapToUploadImage => 'Tap to upload image';

  @override
  String get serviceTitle => 'Service title';

  @override
  String get serviceDescriptionHint => 'Describe your service';

  @override
  String get selectLocation => 'Select your location';

  @override
  String get locationSelected => 'Location selected ✅';

  @override
  String get uploadingService => 'Uploading service...';

  @override
  String get selfReviewNotAllowed => 'You cannot review yourself';

  @override
  String get reviewSentSuccess => 'Review sent successfully ✅';

  @override
  String get noServiceProviders => 'No service providers';

  @override
  String get practicalExperience => 'Practical experience';

  @override
  String get addWorkArea => 'Add work area';

  @override
  String get enterArea => 'Enter the area';

  @override
  String get add => 'Add';

  @override
  String get addImage => 'Add image';

  @override
  String get sort => 'Sort';

  @override
  String get managePackages => 'Manage packages';

  @override
  String get packageActive => 'Your package is active!';

  @override
  String get remainingViews => 'Remaining views';

  @override
  String get active => 'Active';

  @override
  String get expiryDate => 'Expiry date';

  @override
  String get unspecified => 'Not specified';

  @override
  String get performance => 'Performance';

  @override
  String get packageRemaining => 'Remaining from package';

  @override
  String get consumptionRate => 'Consumption rate';

  @override
  String get consumed => 'Consumed';

  @override
  String get expired => 'Expired';

  @override
  String get expiresToday => 'Expires today';

  @override
  String daysRemaining(int count) {
    return '$count days remaining';
  }

  @override
  String get choosePackage => 'Choose the right package for you';

  @override
  String get boostPackageSubtitle =>
      'Show your service to more potential customers';

  @override
  String whatsappSubscribeMessage(String title) {
    return 'Hello, I would like to subscribe to $title';
  }

  @override
  String get imageUpdatedSuccess => 'Image updated successfully';

  @override
  String get serviceBioRequired => 'Please enter a service description';

  @override
  String get serviceUpdatedSuccess => 'Service updated successfully';

  @override
  String get editService => 'Edit service';

  @override
  String get writeServiceBio => 'Write about your service';

  @override
  String get scientificExperience => 'Professional experience';

  @override
  String get area => 'Area';

  @override
  String ratingsCount(int count) {
    return '($count) reviews';
  }

  @override
  String get servicesProvided => 'Services provided';

  @override
  String get noServices => 'No services';

  @override
  String get cannotChatWithSelf => 'You cannot start a chat with yourself';

  @override
  String get noServicesCurrently => 'No services currently';

  @override
  String get serviceCategories => 'Service categories';

  @override
  String get homeMaintenanceServices => 'Home maintenance services';

  @override
  String get finishingConstructionServices =>
      'Finishing and contracting services';

  @override
  String get cleaningServices => 'Cleaning services';

  @override
  String get transportDeliveryServices => 'Transport and delivery services';

  @override
  String get administrativeServices => 'Administrative services';

  @override
  String get finishing => 'Finishing';

  @override
  String get homeAppliances => 'Home appliances';

  @override
  String get washingMachines => 'Washing machines';

  @override
  String get ceramic => 'Ceramic';

  @override
  String get gypsumBoard => 'Gypsum board';

  @override
  String get kitchens => 'Kitchens';

  @override
  String get parquet => 'Parquet';

  @override
  String get constructionWork => 'Construction work';

  @override
  String get decor => 'Decor';

  @override
  String get homes => 'Homes';

  @override
  String get offices => 'Offices';

  @override
  String get carpets => 'Carpets';

  @override
  String get tanks => 'Tanks';

  @override
  String get glassFacades => 'Glass facades';

  @override
  String get furnitureMoving => 'Furniture moving';

  @override
  String get furnitureRelocation => 'Furniture relocation';

  @override
  String get orderDelivery => 'Order delivery';

  @override
  String get governmentFollowUp => 'Government follow-up';

  @override
  String get paperworkClearance => 'Paperwork clearance';

  @override
  String get governmentServices => 'Government services';

  @override
  String get applySort => 'Apply sort';

  @override
  String get yearsExperienceCount => 'Years of experience';

  @override
  String experiencePlusYears(int value) {
    return '$value+ years';
  }

  @override
  String get enableGps => 'Please enable location services (GPS)';

  @override
  String get locationPermissionDenied => 'Location permission was denied';

  @override
  String get locationPermissionDeniedForever =>
      'Location permission is permanently denied. Open settings to enable it';

  @override
  String get addressSeparator => ', ';

  @override
  String get accountType => 'Account type';

  @override
  String get onboarding_service_title =>
      'Your time matters to us... Choose the right order type';

  @override
  String get onboarding_service_desc =>
      '✔ Emergency response required\n✔ Urgent, within hours\n✔ Scheduled, at your convenience';

  @override
  String get onboarding_technician_title =>
      'Rest assured... track your order moment by moment';

  @override
  String get onboarding_technician_desc =>
      '✔ Live tracking of order status and execution\n✔ Receive updates and photos during work\n✔ Evaluations and electronic invoice after order completion';

  @override
  String get onboarding_track_title => 'Track Your Order';

  @override
  String get onboarding_track_desc =>
      'Follow your order status in real time from request to completion';

  @override
  String get onboarding_quality_title => 'One team... for all your home needs';

  @override
  String get onboarding_quality_desc =>
      '✔ Certified technicians\n✔ All services under one roof\n✔ Fast execution and guaranteed quality';

  @override
  String get startNow => 'Start now';

  @override
  String get freelancer => 'Free worker';

  @override
  String get company => 'Company';

  @override
  String get accountSuspended =>
      'Your account is suspended, Contact with support. ';
}
