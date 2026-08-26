/// core/seeders/story_seeder.dart
/// النسخة المعدلة الصحيحة
/// دعم:
/// - viewedBy الجديد
/// - viewsCount
/// - image + text
/// - expiresAt
/// - worker stories
/// ===============================

library;

import 'package:cloud_firestore/cloud_firestore.dart';

class StorySeeder {
  static Future<void> seedStories() async {
    final firestore =
        FirebaseFirestore.instance;

    final List<Map<String, dynamic>>
        stories = [
      {
        "userId": "test_user_1",
        "userName": "محمد",

        /// صورة الحالة
        "image":
            "https://i.pravatar.cc/300?img=1",

        /// صورة العامل الأساسية
        "userImage":
            "https://i.pravatar.cc/300?img=11",

        "text": "",

        /// عدد المشاهدات
        "viewsCount": 2,

        /// المشاهدات الجديدة
        "viewedBy": [
          {
            "userId": "viewer_1",
            "userName": "أحمد",
          },
          {
            "userId": "viewer_2",
            "userName": "محمود",
          },
        ],

        "isExpired": false,

        "createdAt":
            FieldValue.serverTimestamp(),

        "expiresAt":
            Timestamp.fromDate(
          DateTime.now().add(
            const Duration(
              hours: 24,
            ),
          ),
        ),
      },

      {
        "userId": "test_user_1",
        "userName": "محمد",

        /// نفس المستخدم → Story ثانية
        "image": null,

        "userImage":
            "https://i.pravatar.cc/300?img=11",

        "text":
            "اليوم يوجد خصم خاص",

        "viewsCount": 1,

        "viewedBy": [
          {
            "userId": "viewer_3",
            "userName": "كريم",
          }
        ],

        "isExpired": false,

        "createdAt":
            FieldValue.serverTimestamp(),

        "expiresAt":
            Timestamp.fromDate(
          DateTime.now().add(
            const Duration(
              hours: 24,
            ),
          ),
        ),
      },

      {
        "userId": "test_user_2",
        "userName": "أحمد",

        "image":
            "https://i.pravatar.cc/300?img=2",

        "userImage":
            "https://i.pravatar.cc/300?img=12",

        "text": "",

        "viewsCount": 0,

        "viewedBy": [],

        "isExpired": false,

        "createdAt":
            FieldValue.serverTimestamp(),

        "expiresAt":
            Timestamp.fromDate(
          DateTime.now().add(
            const Duration(
              hours: 24,
            ),
          ),
        ),
      },

      {
        "userId": "test_user_3",
        "userName": "محمود",

        "image": null,

        "userImage":
            "https://i.pravatar.cc/300?img=13",

        "text":
            "عرض جديد اليوم 🔥",

        "viewsCount": 3,

        "viewedBy": [
          {
            "userId": "viewer_4",
            "userName": "سامي",
          },
          {
            "userId": "viewer_5",
            "userName": "علي",
          },
          {
            "userId": "viewer_6",
            "userName": "نور",
          },
        ],

        "isExpired": false,

        "createdAt":
            FieldValue.serverTimestamp(),

        "expiresAt":
            Timestamp.fromDate(
          DateTime.now().add(
            const Duration(
              hours: 24,
            ),
          ),
        ),
      },

      {
        "userId": "test_user_4",
        "userName": "كريم",

        "image":
            "https://i.pravatar.cc/300?img=3",

        "userImage":
            "https://i.pravatar.cc/300?img=14",

        "text": "",

        "viewsCount": 0,

        "viewedBy": [],

        "isExpired": false,

        "createdAt":
            FieldValue.serverTimestamp(),

        "expiresAt":
            Timestamp.fromDate(
          DateTime.now().add(
            const Duration(
              hours: 24,
            ),
          ),
        ),
      },
    ];

    for (final story
        in stories) {
      await firestore
          .collection(
            "stories",
          )
          .add(story);
    }

    print(
      "Stories Seeder Done Successfully",
    );
  }
}