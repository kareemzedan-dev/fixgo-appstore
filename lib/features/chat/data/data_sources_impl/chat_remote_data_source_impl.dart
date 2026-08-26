/// data/data_sources_impl/chat_remote_data_source_impl.dart

library;

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../data_sources/chat_remote_data_source.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

@LazySingleton(as: ChatRemoteDataSource)
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  ChatRemoteDataSourceImpl(this.firestore, this.auth, this.storage);

  String? get currentUserId => auth.currentUser?.uid;

  @override
  Stream<List<ChatModel>> getChats() {
    if (currentUserId == null) {
      return Stream.value([]);
    }

    final myId = currentUserId!;

    return firestore
        .collection("chats")
        .where("users", arrayContains: myId)
        .orderBy("timestamp", descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
          List<ChatModel> chats = [];

          for (final doc in snapshot.docs) {
            final data = doc.data();

            final users = List<String>.from(data["users"] ?? []);

            final otherUserId = users.firstWhere(
              (id) => id != myId,
              orElse: () => "",
            );

            final userDoc = await firestore
                .collection("users")
                .doc(otherUserId)
                .get();

            final userData = userDoc.data() ?? {};

            final unreadMap = Map<String, dynamic>.from(
              data["unreadCounts"] ?? {},
            );

            final unreadCount = unreadMap[myId] ?? 0;

            chats.add(
              ChatModel(
                chatId: doc.id,
                otherUserId: otherUserId,
                userName: userData["name"] ?? "",
                userImage: userData["imageUrl"] ?? "",
                lastMessage: data["lastMessage"] ?? "",
                lastDate: data["timestamp"]?.toDate().toString() ?? "",
                unreadCount: unreadCount,
              ),
            );
          }

          return chats;
        });
  }

  @override
  Stream<List<MessageModel>> getMessages({required String chatId}) {
    return firestore
        .collection("chats")
        .doc(chatId)
        .collection("messages")
        .orderBy("index")
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((e) => MessageModel.fromMap(e.data(), e.id))
              .toList();
        });
  }

  @override
  Future<void> sendMessage({
    required String otherUserId,
    required String text,
    required String type,
  }) async {
    if (currentUserId == null) {
      return;
    }

    final senderId = currentUserId!;

    final ids = [senderId, otherUserId]..sort();

    final chatId = "${ids[0]}_${ids[1]}";

    final chatRef = firestore.collection("chats").doc(chatId);

    await firestore.runTransaction((transaction) async {
      final chatSnapshot = await transaction.get(chatRef);

      int lastIndex = 0;

      if (chatSnapshot.exists) {
        final data = chatSnapshot.data()!;

        lastIndex = data["lastMessageIndex"] ?? 0;
      }

      final newIndex = lastIndex + 1;

      final messageRef = chatRef.collection("messages").doc();

      transaction.set(messageRef, {
        "text": text,
        "senderId": senderId, // ✅ صح
        "receiverId": otherUserId, // ✅ مهم جدًا
        "timestamp": FieldValue.serverTimestamp(),
        "index": newIndex,
        "isRead": false,
        "type": type,
      });

      /// الحل الصحيح الكامل
      final oldData = chatSnapshot.data() ?? {};

      final oldUnreadMap = Map<String, dynamic>.from(
        oldData["unreadCounts"] ?? {},
      );

      final receiverUnread = oldUnreadMap[otherUserId] ?? 0;

      transaction.set(chatRef, {
        "chatId": chatId,

        "users": ids,

        "lastMessage": type == "image"
            ? "📷 صورة"
            : type == "document"
            ? "📄 مستند مرفق"
            : text,

        "timestamp": FieldValue.serverTimestamp(),

        "lastMessageIndex": newIndex,

        /// الصحيح فقط
        /// map نظيف
        "unreadCounts": {senderId: 0, otherUserId: receiverUnread + 1},
      }, SetOptions(merge: true));
    });
  }

  @override
  Future<void> sendImage({required String otherUserId}) async {
    final picker = ImagePicker();

    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked == null) {
      return;
    }

    final ref = storage.ref(
      "chat_images/${DateTime.now().millisecondsSinceEpoch}",
    );

    String url;

    if (kIsWeb) {
      final bytes = await picked.readAsBytes();

      final task = await ref.putData(bytes);

      url = await task.ref.getDownloadURL();
    } else {
      final file = File(picked.path);

      final task = await ref.putFile(file);

      url = await task.ref.getDownloadURL();
    }

    await sendMessage(otherUserId: otherUserId, text: url, type: "image");
  }

  @override
  Future<void> sendDocument({required String otherUserId}) async {
    final result = await FilePicker.pickFiles(
      type: FileType.any,
      withData: true,
    );

    if (result == null || result.files.isEmpty) {
      return;
    }

    final pickedFile = result.files.first;

    final ref = storage.ref(
      "chat_docs/${DateTime.now().millisecondsSinceEpoch}_${pickedFile.name}",
    );

    String url;

    if (kIsWeb) {
      final bytes = pickedFile.bytes!;

      final task = await ref.putData(bytes);

      url = await task.ref.getDownloadURL();
    } else {
      final file = File(pickedFile.path!);

      final task = await ref.putFile(file);

      url = await task.ref.getDownloadURL();
    }

    await sendMessage(otherUserId: otherUserId, text: url, type: "document");
  }

  @override
  Future<void> markAsRead({required String chatId}) async {
    if (currentUserId == null) {
      return;
    }

    final myId = currentUserId!;

    final chatRef = firestore.collection("chats").doc(chatId);

    final chatDoc = await chatRef.get();

    if (!chatDoc.exists) {
      return;
    }

    final oldData = chatDoc.data() ?? {};

    final oldUnreadMap = Map<String, dynamic>.from(
      oldData["unreadCounts"] ?? {},
    );

    oldUnreadMap[myId] = 0;

    await chatRef.update({"unreadCounts": oldUnreadMap});
  }
@override
Future<void> deleteChat({required String chatId}) async {
  final chatRef = firestore.collection("chats").doc(chatId);

  /// حذف الرسائل
  final messagesSnapshot =
      await chatRef.collection("messages").get();

  for (final doc in messagesSnapshot.docs) {
    await doc.reference.delete();
  }

  /// حذف الشات نفسه
  await chatRef.delete();
}
}
