import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/auth/data/models/worker_model.dart';

@singleton
class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ConfirmationResult? _webConfirmationResult;
  RecaptchaVerifier? _recaptchaVerifier;

  // Rate limiting variables (effectively disabled)
  static DateTime? _lastOtpRequest;
  static const Duration _minOtpInterval = Duration(seconds: 0); // No wait
  static int _otpRequestCount = 0;
  static const int _maxOtpRequests = 100; // Very high limit
  static DateTime? _rateLimitResetTime;

  // Web-specific rate limiting (effectively disabled)
  static DateTime? _lastWebOtpRequest;
  static const Duration _minWebOtpInterval = Duration(
    seconds: 60,
  ); // No wait for web
  static int _webOtpRequestCount = 0;
  static const int _maxWebOtpRequests = 100; // Very high limit for web
  static DateTime? _webRateLimitResetTime;

  // Emergency cooldown after Firebase errors (disabled)
  static DateTime? _emergencyCooldownUntil;
  static const Duration _emergencyCooldownDuration = Duration(
    seconds: 30,
  ); // Very short

  Future<User?> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      if (user != null) {
        if (!user.emailVerified) {
          throw Exception(
            'البريد الإلكتروني لم يتم التحقق منه. يرجى التحقق من بريدك.',
          );
        }
        return user;
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// داخل FirebaseAuthServices
  /// أضف هذا الميثود

  Future<Map<String, dynamic>> getUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();

      if (!doc.exists) {
        throw Exception('المستخدم غير موجود');
      }

      final data = doc.data();

      if (data == null) {
        throw Exception('بيانات المستخدم غير موجودة');
      }

      return data;
    } catch (e) {
      log("getUserData Error ====> ${e.toString()}");

      throw Exception(e.toString().replaceAll("Exception: ", ""));
    }
  }

  /// core/services/firebase_services/firebase_auth_services.dart
  Future<void> updateUserData({
    required String uid,
    String? name,
    String? phone,
    String? city,
    String? district,
    double? latitude,
    double? longitude,
    String? profession,
    String? serviceCategory,
    int? yearsOfExperience,
  }) async {
    final data = <String, dynamic>{};

    if (name != null) data['name'] = name;
    if (phone != null) data['phone'] = phone;
    if (city != null) data['city'] = city;
    if (district != null) data['district'] = district;
    if (latitude != null) data['latitude'] = latitude;
    if (longitude != null) data['longitude'] = longitude;
    if (profession != null) data['profession'] = profession;
    if (serviceCategory != null) {
      data['serviceCategory'] = serviceCategory;
    }
    if (yearsOfExperience != null) {
      data['yearsOfExperience'] = yearsOfExperience;
    }

    /// 🔥 update only changed fields
    await _firestore.collection("users").doc(uid).update(data);
  }

  Future<void> signUpUserWithPhone({
    required User user,
    required String name,
    required String phone,
    required String type,
    required String profession,
    required String serviceCategory,
    required int yearsOfExperience,
  }) async {
    await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
      "id": user.uid,
      "name": name,
      "phone": phone,
      "type": type,

      /// worker only
      "profession": profession,
      "serviceCategory": serviceCategory,
      "yearsOfExperience": yearsOfExperience,

      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateUserLocation({
    required String uid,
    required double latitude,
    required double longitude,
    required String city,
    required String district,
  }) async {
    final mapUrl = "https://www.google.com/maps?q=$latitude,$longitude";

    await _firestore.collection("users").doc(uid).update({
      "latitude": latitude,
      "longitude": longitude,
      "city": city,
      "district": district,
      "locationUrl": mapUrl,
    });
  }

  Future<void> signUpUser(
    String name,
    String email,
    String password,
    String phone,
    String profession,
    String type,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        await user.sendEmailVerification();
        String? fcmToken = "";
        await _firestore.collection('users').doc(user.uid).set({
          'id': user.uid,
          'name': name,
          'email': email,
          'phone': phone,
          'type': type,
          'profession': profession,
          'emailVerified': false,
          'fcmToken': fcmToken,

          'isVerified': false,
          'verificationStatus': 'none',
          'verificationImage': '',
        });
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> sendOtp(
    String phoneNumber,
    Function(String, [int?]) codeSent,
  ) async {
    log("Sending OTP to: $phoneNumber");

    if (!_canSendOtp(kIsWeb)) {
      final waitTime = _getWaitTime(kIsWeb);
      throw Exception(
        'يرجى الانتظار $waitTime قبل محاولة إرسال رمز التحقق مرة أخرى.',
      );
    }

    _updateOtpRequestCount(kIsWeb);

    String formattedPhoneNumber = _formatPhoneNumber(phoneNumber);
    log("Formatted phone number: $formattedPhoneNumber");

    // Additional validation for Oman numbers
    if (formattedPhoneNumber.startsWith('+968')) {
      log("Oman number part: $formattedPhoneNumber");
    }

    if (kIsWeb) {
      try {
        final verifier = RecaptchaVerifier(
          auth: FirebaseAuthPlatform.instance,
          container: null,
        );

        final result = await _auth.signInWithPhoneNumber(
          formattedPhoneNumber,
          verifier,
        );

        _webConfirmationResult = result;

        codeSent("WEB_VERIFY", null);
      } catch (e) {
        log("Web OTP Error: $e");

        // Handle specific Firebase errors for web
        if (e.toString().contains('too-many-requests')) {
          final waitTime = _getFirebaseWaitTime();
          throw Exception(
            'تم إرسال العديد من الرسائل. يرجى الانتظار $waitTime قبل المحاولة مرة أخرى.',
          );
        } else if (e.toString().contains('quota-exceeded')) {
          throw Exception('تم تجاوز الحد المسموح من الرسائل. حاول لاحقاً.');
        } else if (e.toString().contains('invalid-phone-number')) {
          throw Exception('رقم الهاتف غير صحيح.');
        } else if (e.toString().contains('network-request-failed')) {
          throw Exception('فشل الاتصال بالإنترنت. يرجى التحقق من اتصالك.');
        } else if (e.toString().contains('invalid-app-credential')) {
          // Clear the current reCAPTCHA verifier and create a new one
          _recaptchaVerifier?.clear();
          _recaptchaVerifier = null;
          throw Exception('فشل التحقق من reCAPTCHA. يرجى المحاولة مرة أخرى.');
        } else if (e.toString().contains('argument-error')) {
          log("Argument error details: ${e.toString()}");
          throw Exception(
            'بيانات غير صحيحة. يرجى التحقق من رقم الهاتف والمحاولة مرة أخرى.',
          );
        } else if (e.toString().contains('recaptcha-enterprise')) {
          // Clear the current reCAPTCHA verifier and create a new one
          _recaptchaVerifier?.clear();
          _recaptchaVerifier = null;
          throw Exception(
            'فشل تهيئة reCAPTCHA. يرجى تحديث الصفحة والمحاولة مرة أخرى.',
          );
        } else {
          throw Exception(e.toString());
        }
      }
    } else {
      // ================= MOBILE LOGIC =================
      try {
        await _auth.verifyPhoneNumber(
          phoneNumber: formattedPhoneNumber,
          timeout: const Duration(seconds: 120),

          verificationCompleted: (PhoneAuthCredential credential) async {
            log("Auto verification completed");
          },
          verificationFailed: (FirebaseAuthException e) {
            log("Verification failed: ${e.code} - ${e.message}");

            if (e.code == 'invalid-phone-number') {
              throw Exception('رقم الهاتف غير صحيح.');
            } else if (e.code == 'quota-exceeded') {
              throw Exception('تم تجاوز الحد المسموح من الرسائل. حاول لاحقاً.');
            } else if (e.code == 'too-many-requests') {
              // Handle Firebase rate limiting with specific guidance
              final waitTime = _getFirebaseWaitTime();
              throw Exception(
                'تم إرسال العديد من الرسائل. يرجى الانتظار $waitTime قبل المحاولة مرة أخرى.',
              );
            } else if (e.code == 'network-request-failed') {
              throw Exception('فشل الاتصال بالإنترنت. يرجى التحقق من اتصالك.');
            } else if (e.code == 'internal-error' || e.code == 'unknown') {
              log("REAL FIREBASE ERROR => ${e.code}");
              log("REAL FIREBASE MESSAGE => ${e.message}");

              throw Exception("${e.code} => ${e.message}");
            } else {
              log(e.message ?? "حدث خطأ غير معروف");
              throw Exception(e.message ?? "حدث خطأ غير معروف");
            }
          },
          codeSent: (String verificationId, int? forceResendingToken) {
            log("OTP Sent. Verification ID: $verificationId");
            codeSent(verificationId, forceResendingToken);
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            log("Auto retrieval timeout. Verification ID: $verificationId");
          },
        );
      } catch (e) {
        log("General error in verifyPhoneNumber: $e");
        throw Exception('فشل إرسال رمز التحقق. يرجى المحاولة مرة أخرى.');
      }
    }
  }

  // Rate limiting helper methods
  bool _canSendOtp(bool isWeb) {
    final now = DateTime.now();

    // Use web-specific counters if on web
    final lastRequest = isWeb ? _lastWebOtpRequest : _lastOtpRequest;
    final minInterval = isWeb ? _minWebOtpInterval : _minOtpInterval;
    final requestCount = isWeb ? _webOtpRequestCount : _otpRequestCount;
    final maxRequests = isWeb ? _maxWebOtpRequests : _maxOtpRequests;
    final resetTime = isWeb ? _webRateLimitResetTime : _rateLimitResetTime;

    // Reset counter if enough time has passed
    if (resetTime != null && now.isAfter(resetTime)) {
      if (isWeb) {
        _webOtpRequestCount = 0;
        _webRateLimitResetTime = null;
      } else {
        _otpRequestCount = 0;
        _rateLimitResetTime = null;
      }
    }

    // Check if we've exceeded the max requests
    if (requestCount >= maxRequests) {
      return false;
    }

    // Check minimum interval between requests
    if (lastRequest != null) {
      final timeSinceLastRequest = now.difference(lastRequest);
      if (timeSinceLastRequest < minInterval) {
        return false;
      }
    }

    return true;
  }

  void _updateOtpRequestCount(bool isWeb) {
    final now = DateTime.now();

    if (isWeb) {
      _lastWebOtpRequest = now;
      _webOtpRequestCount++;

      // Set reset time if we've reached max requests
      if (_webOtpRequestCount >= _maxWebOtpRequests &&
          _webRateLimitResetTime == null) {
        _webRateLimitResetTime = now.add(
          const Duration(hours: 2),
        ); // Longer for web
      }
    } else {
      _lastOtpRequest = now;
      _otpRequestCount++;

      // Set reset time if we've reached max requests
      if (_otpRequestCount >= _maxOtpRequests && _rateLimitResetTime == null) {
        _rateLimitResetTime = now.add(const Duration(hours: 1));
      }
    }
  }

  String _getWaitTime(bool isWeb) {
    // Use web-specific counters if on web
    final lastRequest = isWeb ? _lastWebOtpRequest : _lastOtpRequest;
    final minInterval = isWeb ? _minWebOtpInterval : _minOtpInterval;
    final resetTime = isWeb ? _webRateLimitResetTime : _rateLimitResetTime;

    if (lastRequest != null) {
      final timeSinceLastRequest = DateTime.now().difference(lastRequest);
      final remainingTime = minInterval - timeSinceLastRequest;
      if (remainingTime.inSeconds > 0) {
        return '${remainingTime.inSeconds} ثانية';
      }
    }

    if (resetTime != null) {
      final timeUntilReset = resetTime.difference(DateTime.now());
      if (timeUntilReset.inMinutes > 0) {
        return '${timeUntilReset.inMinutes} دقيقة';
      } else {
        return '${timeUntilReset.inSeconds} ثانية';
      }
    }

    return 'بعض الوقت';
  }

  String _getFirebaseWaitTime() {
    // Firebase typically blocks for 10-60 minutes
    return '10-60 دقيقة';
  }

  String _formatPhoneNumber(String phoneNumber) {
    String cleaned = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');

    if (!cleaned.startsWith('+')) {
      cleaned = '+$cleaned';
    }

    if (cleaned.startsWith('+968')) {
      String numberWithoutCountry = cleaned.replaceFirst('+968', '');

      log("REAL NUMBER PART => $numberWithoutCountry");

      if (numberWithoutCountry.length == 8) {
        return cleaned;
      }
    }

    log("Warning: Phone number may not be valid: $cleaned");

    return cleaned;
  }

  Future<User?> verifyOtp(String verificationId, String otp) async {
    try {
      log("Starting OTP verification - isWeb: $kIsWeb");

      if (kIsWeb) {
        // ================= WEB LOGIC =================
        log("Web OTP verification - checking confirmation result");
        if (_webConfirmationResult == null) {
          log("Error: No Web Confirmation Result found");
          throw Exception(
            "لم يتم العثور على نتيجة التحقق. يرجى إعادة إرسال رمز التحقق.",
          );
        }

        log("Attempting to confirm OTP with confirmation result");
        UserCredential userCredential = await _webConfirmationResult!.confirm(
          otp,
        );
        log("Web OTP verification successful");
        return userCredential.user;
      } else {
        // ================= MOBILE LOGIC =================
        log("Mobile OTP verification - verificationId: $verificationId");
        final credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: otp,
        );
        final userCredential = await _auth.signInWithCredential(credential);
        log("Mobile OTP verification successful");
        return userCredential.user;
      }
    } catch (e) {
      log("verifyOtp Error ====> ${e.toString()}");

      // Handle specific Firebase errors
      if (e.toString().contains('invalid-verification-code')) {
        throw Exception(
          'رمز التحقق غير صحيح. يرجى التحقق من الرمز والمحاولة مرة أخرى.',
        );
      } else if (e.toString().contains('session-expired')) {
        throw Exception(
          'انتهت صلاحية جلسة التحقق. يرجى إعادة إرسال رمز التحقق.',
        );
      } else if (e.toString().contains('invalid-verification-id')) {
        throw Exception('معرف التحقق غير صالح. يرجى إعادة إرسال رمز التحقق.');
      } else if (e.toString().contains('too-many-requests')) {
        throw Exception(
          'تم تجاوز عدد المحاولات. يرجى الانتظار لبعض الوقت والمحاولة مرة أخرى.',
        );
      } else {
        throw Exception(e.toString());
      }
    }
  }

  Future<void> signOut() async {
    // Clean up reCAPTCHA verifier on sign out
    _recaptchaVerifier?.clear();
    _recaptchaVerifier = null;
    _webConfirmationResult = null;

    await _auth.signOut();
  }

  Future<String> getUserProfession() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      final profession = userDoc.data()?['profession'];
      print(profession);
      if (userDoc.exists) {
        return userDoc['profession'];
      }
    }
    return '';
  }

  Future<WorkerModel?> getUserDetailsById(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      log("user : ${doc.data()}");
      if (doc.exists) {
        return WorkerModel.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> checkUserExistsByPhone(String phoneNumber) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('phone', isEqualTo: phoneNumber)
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      log("Error checking user by phone: ${e.toString()}");
      return false;
    }
  }

  void _triggerEmergencyCooldown() {
    // Emergency cooldown disabled - no longer triggers
    log("Emergency cooldown disabled");
  }

  // Method to manually refresh reCAPTCHA verifier (useful for debugging)
  void refreshRecaptchaVerifier() {
    if (kIsWeb) {
      _recaptchaVerifier?.clear();
      _recaptchaVerifier = null;
      _webConfirmationResult = null;
      log("reCAPTCHA verifier refreshed");
    }
  }

  // Method to manually verify reCAPTCHA before sending OTP
  Future<void> verifyRecaptchaManually() async {
    if (kIsWeb && _recaptchaVerifier != null) {
      try {
        await _recaptchaVerifier!.verify();
        log("reCAPTCHA manually verified");
      } catch (e) {
        log("Manual reCAPTCHA verification failed: $e");
        throw Exception("فشل التحقق من reCAPTCHA. يرجى المحاولة مرة أخرى.");
      }
    }
  }
}
