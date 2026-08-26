library;

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/core/helper/hashPassword.dart';

import '../../../../core/session/session_local_data_source.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SessionLocalDataSource sessionLocalDataSource;

  final FirebaseAuth auth = FirebaseAuth.instance;
  AuthRemoteDataSourceImpl(this.sessionLocalDataSource);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<bool> checkUserExistsByPhone(String phone) async {
    final result = await firestore
        .collection('users')
        .where('phone', isEqualTo: phone)
        .limit(1)
        .get();

    return result.docs.isNotEmpty;
  }

  @override
  Future<void> register({
    required String name,
    required String phone,
    required String password,
    required String type,
    String? profession,
    String? serviceCategory,
    int? yearsOfExperience,
  }) async {
    final exists = await checkUserExistsByPhone(phone);

    if (exists) {
      throw Exception("رقم الهاتف مسجل بالفعل");
    }

    final email = "$phone@fixgo.com";

    final credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;

    final doc = firestore.collection('users').doc(uid);
    final user = UserModel(
      uid: uid,
      phone: phone,
      name: name,
      password: hashPassword(password),
      type: type,
      profession: profession ?? '',
      serviceCategory: serviceCategory ?? '',
      yearsOfExperience: yearsOfExperience ?? 0,
      state: "1",
    );
    await doc.set(user.toMap());

    await sessionLocalDataSource.saveUser(user);
  }

  @override
  Future<void> login({required String phone, required String password}) async {
    final result = await firestore
        .collection('users')
        .where('phone', isEqualTo: phone)
        .limit(1)
        .get();

    if (result.docs.isEmpty) {
      throw Exception("no_account");
    }

    final user = UserModel.fromMap(result.docs.first.data());
    if (user.password != hashPassword(password)) {
      throw Exception("wrong_password");
    }
    if (user.state == "0") {
      throw Exception("suspended");
    }
    final email = "$phone@fixgo.com";

    await auth.signInWithEmailAndPassword(email: email, password: password);

    await sessionLocalDataSource.saveUser(user);
  }

  @override
  Future<void> updateUser({
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
    await firestore.collection('users').doc(uid).update({
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (city != null) 'city': city,
      if (district != null) 'district': district,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (profession != null) 'profession': profession,
      if (serviceCategory != null) 'serviceCategory': serviceCategory,
      if (yearsOfExperience != null) 'yearsOfExperience': yearsOfExperience,
    });

    final userDoc = await firestore.collection('users').doc(uid).get();

    final updatedUser = UserModel.fromMap(userDoc.data()!);

    await sessionLocalDataSource.saveUser(updatedUser);
  }

  Future<UserModel> _loadAndSaveUser(String uid) async {
    final userDoc = await firestore.collection('users').doc(uid).get();
    final user = UserModel.fromMap(userDoc.data()!);
    await sessionLocalDataSource.saveUser(user);
    return user;
  }

  @override
  Future<UserModel> updateUserImage(XFile image) async {
    final uid = auth.currentUser!.uid;
    final ref = FirebaseStorage.instance.ref('users/$uid.jpg');
    await ref.putData(await image.readAsBytes());
    final imageUrl = await ref.getDownloadURL();

    await firestore.collection('users').doc(uid).update({'imageUrl': imageUrl});
    final offers = await firestore
        .collection('offers')
        .where('userId', isEqualTo: uid)
        .get();
    for (final offer in offers.docs) {
      await offer.reference.update({'userImageUrl': imageUrl});
    }

    return _loadAndSaveUser(uid);
  }

  @override
  Future<UserModel> updateUserLocation({
    required String uid,
    required double latitude,
    required double longitude,
    required String city,
    required String district,
  }) async {
    final locationUrl = 'https://www.google.com/maps?q=$latitude,$longitude';
    await firestore.collection('users').doc(uid).update({
      'latitude': latitude,
      'longitude': longitude,
      'city': city,
      'district': district,
      'locationUrl': locationUrl,
    });
    return _loadAndSaveUser(uid);
  }

  @override
  Future<void> verifyUpdatePhoneOtp({
    required String verificationId,
    required String otp,
    required String newPhone,
  }) async {
    final user = auth.currentUser!;
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );
    await user.updatePhoneNumber(credential);
    await firestore.collection('users').doc(user.uid).update({
      'phone': newPhone,
    });
    await _loadAndSaveUser(user.uid);
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
    await sessionLocalDataSource.clearUser();
  }

  @override
  Future<void> sendPasswordResetOtp(String phone) async {
    final response = await http.post(
      Uri.parse('https://us-central1-mkawlak.cloudfunctions.net/sendOtp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone}),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw Exception(data['message'] ?? 'حدث خطأ');
    }
  }

  @override
  Future<void> verifyPasswordResetOtp({
    required String phone,
    required String otp,
  }) async {
    final response = await http.post(
      Uri.parse('https://us-central1-mkawlak.cloudfunctions.net/verifyOtp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone, 'otp': otp}),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw Exception(data['message'] ?? 'الكود غير صحيح');
    }
  }

  @override
  Future<void> resendPasswordResetOtp(String phone) async {
    await http.post(
      Uri.parse('https://sendotp-fmhjsrypyq-uc.a.run.app'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone}),
    );
  }

  @override
  Future<void> resetPassword({
    required String phone,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('https://us-central1-mkawlak.cloudfunctions.net/resetPassword'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone, 'password': password}),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw Exception(data['message'] ?? 'حدث خطأ');
    }
  }

  @override
  Future<void> deleteAccount() async {
    final user = auth.currentUser;
    if (user == null) return;

    await firestore.collection('users').doc(user.uid).delete();
    await user.delete();
    await sessionLocalDataSource.clearUser();
  }

  @override
  Future<String> sendOtp(String phone) {
    // TODO: implement sendOtp
    throw UnimplementedError();
  }

  @override
  Future<void> verifyOtp({
    required String verificationId,
    required String otp,
    required String name,
    required String phone,
    required String type,
    String? profession,
    String? serviceCategory,
    int? yearsOfExperience,
  }) {
    // TODO: implement verifyOtp
    throw UnimplementedError();
  }

  @override
  Future<void> verifySignInOtp({
    required String verificationId,
    required String otp,
    required String phone,
  }) {
    // TODO: implement verifySignInOtp
    throw UnimplementedError();
  }

  @override
  Future<bool> checkUserSuspended(String phone) async {
    bool is_suspended = false;
    await firestore.collection("users").doc(phone).get().then((value) {
      if (value.data()?['state'] == '0') {
        is_suspended = true;
      }
    });
    return is_suspended;
  }
}
