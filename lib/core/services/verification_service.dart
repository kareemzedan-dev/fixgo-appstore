import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerificationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// إرسال طلب التوثيق
  Future<void> submitVerification({
    required String frontImage,
    required String backImage,
  }) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await _firestore.collection('users').doc(uid).update({
      "verificationFront": frontImage,
      "verificationBack": backImage,
      "verificationStatus": "pending", // pending | approved | rejected
      "isVerified": false,
      "verificationDate": FieldValue.serverTimestamp(),
    });
  }

  /// الحصول على حالة التوثيق
  Future<String?> getVerificationStatus() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await _firestore.collection('users').doc(uid).get();

    if (!doc.exists) return null;
    return doc.data()?["verificationStatus"];
  }

  /// الحصول على كامل بيانات التوثيق
  Future<Map<String, dynamic>?> getVerificationData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await _firestore.collection('users').doc(uid).get();

    if (!doc.exists) return null;
    
    final data = doc.data();
    if (data == null) return null;
    
    return {
      "verificationStatus": data["verificationStatus"],
      "isVerified": data["isVerified"] ?? false,
      "verificationFront": data["verificationFront"],
      "verificationBack": data["verificationBack"],
      "verificationDate": data["verificationDate"],
      "rejectionReason": data["rejectionReason"], // سبب الرفض إذا وجد
    };
  }

  /// هل المستخدم موثق
  Future<bool> isUserVerified() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await _firestore.collection('users').doc(uid).get();

    if (!doc.exists) return false;
    return doc.data()?["isVerified"] ?? false;
  }

  /// الاستماع للتغييرات في حالة التوثيق (للتحديث المباشر)
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamVerificationStatus() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return _firestore.collection('users').doc(uid).snapshots();
  }

  /// إعادة تعيين حالة التوثيق (للمستخدمين المرفوضين)
  Future<void> resetVerification() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await _firestore.collection('users').doc(uid).update({
      "verificationStatus": FieldValue.delete(),
      "isVerified": false,
      "verificationFront": FieldValue.delete(),
      "verificationBack": FieldValue.delete(),
      "verificationDate": FieldValue.delete(),
      "rejectionReason": FieldValue.delete(),
    });
  }
}