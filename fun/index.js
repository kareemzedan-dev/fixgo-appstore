const { onRequest } = require("firebase-functions/v2/https");
const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { defineSecret } = require("firebase-functions/params");
const crypto = require("crypto");
const cors = require("cors")({ origin: true });
function hashPassword(password) {
  return crypto
    .createHash("sha256")
    .update(password)
    .digest("hex");
}
const admin = require("firebase-admin");

admin.initializeApp();

const INFOBIP_API_KEY =
  defineSecret("INFOBIP_API_KEY");
/// ===============================
/// 1. إرسال يدوي من Flutter (Gen2)
/// ===============================
exports.sendNotification = onRequest(async (req, res) => {
  try {
    const { token, title, body, otherUserId } = req.body;

    if (!token) {
      return res.status(400).send("Missing token");
    }

    const message = {
      token: token,
      notification: {
        title: title || "إشعار",
        body: body || "",
      },
      data: {
        type: "manual",
        otherUserId: otherUserId || "",
      },
    };

    await admin.messaging().send(message);

    return res.status(200).send({ success: true });
  } catch (e) {
    console.error(e);
    return res.status(500).send(e.toString());
  }
});
exports.sendOtp = onRequest(
  {
    secrets: [INFOBIP_API_KEY],
  },
  (req, res) => {
    cors(req, res, async () => {
      try {
        const { phone } = req.body;

        if (!phone) {
          return res.status(400).json({
            success: false,
            message: "Phone is required",
          });
        }

        const otp = (
          Math.floor(
            100000 + Math.random() * 900000
          )
        ).toString();

        await admin
          .firestore()
          .collection("otp_codes")
          .doc(phone)
          .set({
            otp,
            createdAt: Date.now(),
            expiresAt:
              Date.now() + (5 * 60 * 1000),
          });

        const response = await fetch(
          "https://y41jjp.api.infobip.com/sms/3/messages",
          {
            method: "POST",
            headers: {
              Authorization: `App ${INFOBIP_API_KEY.value()}`,
              "Content-Type": "application/json",
              Accept: "application/json",
            },
            body: JSON.stringify({
              messages: [
                {
                  destinations: [
                    {
                      to: phone,
                    },
                  ],
          
                  content: {
                    text: `رمز التحقق الخاص بك هو ${otp}`,
                  },
                },
              ],
            }),
          }
        );

        const data = await response.json();
console.log(
  "MESSAGE ID =>",
  data.messages?.[0]?.messageId
);console.log("PHONE =>", phone);
console.log("OTP =>", otp);
console.log("INFOBIP RESPONSE =>", JSON.stringify(data));
console.log("MESSAGE ID =>", data.messages?.[0]?.messageId);
        console.log(data);

        if (!response.ok) {
          return res.status(400).json({
            success: false,
            otpSent: false,
            data,
          });
        }

        return res.status(200).json({
          success: true,
          otpSent: true,
          data,
        });
      } catch (e) {
        console.error(e);

        return res.status(500).json({
          success: false,
          error: e.toString(),
        });
      }
    });
  }
);
exports.verifyOtp = onRequest(
  (req, res) => {
    cors(req, res, async () => {
      try {
        const { phone, otp } = req.body;

        if (!phone || !otp) {
          return res.status(400).json({
            success: false,
            message: "Phone and OTP are required",
          });
        }

        const doc = await admin
          .firestore()
          .collection("otp_codes")
          .doc(phone)
          .get();

        if (!doc.exists) {
          return res.status(400).json({
            success: false,
            message: "OTP not found",
          });
        }

        const data = doc.data();

        if (Date.now() > data.expiresAt) {
          return res.status(400).json({
            success: false,
            message: "OTP expired",
          });
        }

        if (data.otp !== otp) {
          return res.status(400).json({
            success: false,
            message: "Invalid OTP",
          });
        }

        await admin
          .firestore()
          .collection("otp_codes")
          .doc(phone)
          .delete();

        return res.status(200).json({
          success: true,
          verified: true,
        });
      } catch (e) {
        console.error(e);

        return res.status(500).json({
          success: false,
          error: e.toString(),
        });
      }
    });
  }
);

exports.resetPassword = onRequest(
  (req, res) => {
    cors(req, res, async () => {
      try {
        const { phone, password } = req.body;

        if (!phone || !password) {
          return res.status(400).json({
            success: false,
            message: "Phone and password are required",
          });
        }

        const users = await admin
          .firestore()
          .collection("users")
          .where("phone", "==", phone)
          .limit(1)
          .get();

        if (users.empty) {
          return res.status(404).json({
            success: false,
            message: "User not found",
          });
        }

        await users.docs[0].ref.update({
          password: hashPassword(password),
        });

        await admin
          .firestore()
          .collection("otp_codes")
          .doc(phone)
          .delete();

        return res.status(200).json({
          success: true,
          message: "Password updated successfully",
        });
      } catch (e) {
        console.error(e);

        return res.status(500).json({
          success: false,
          error: e.toString(),
        });
      }
    });
  }
);
/// ===============================
/// 2. إشعار عند رسالة جديدة + حفظه 🔥
/// ===============================
exports.onNewMessage = onDocumentCreated(
  "chats/{chatId}/messages/{messageId}",
  async (event) => {
    console.log("🔥 FUNCTION START");

    try {
      const snap = event.data;
      if (!snap) {
        console.log("❌ no snap");
        return;
      }

      const message = snap.data();
      console.log("📩 MESSAGE:", message);

      const receiverId = message.receiverId;
      const senderId = message.senderId;

      console.log("receiverId:", receiverId);
      console.log("senderId:", senderId);

      if (!receiverId || !senderId) {
        console.log("❌ missing receiverId or senderId");
        return;
      }

      /// 👇 هات بيانات المستقبل
      const userDoc = await admin.firestore()
        .collection("users")
        .doc(receiverId)
        .get();

      if (!userDoc.exists) {
        console.log("❌ user not found");
        return;
      }

      const userData = userDoc.data();

      const token = userData.fcmToken;
      console.log("TOKEN:", token);

      if (!token) {
        console.log("❌ no token");
        return;
      }

      /// ===============================
      /// 🔥 1. إرسال Push Notification
      /// ===============================
      const payload = {
        token: token,
        notification: {
          title: "رسالة جديدة",
          body: message.text || "📩 رسالة جديدة",
        },
        data: {
          type: "chat",
          otherUserId: senderId,
          chatId: event.params.chatId,
        },
      };

      await admin.messaging().send(payload);

      console.log("✅ NOTIFICATION SENT");

      /// ===============================
      /// 🔥 2. حفظ الإشعار في Firestore
      /// ===============================
      await admin.firestore()
        .collection("notifications")
        .doc(receiverId)
        .collection("items")
        .add({
          title: "رسالة جديدة",
          body: message.text || "📩 رسالة جديدة",

          /// نوع الإشعار
          type: "chat",

          /// بيانات إضافية
          otherUserId: senderId,
          chatId: event.params.chatId,

          isRead: false,

          createdAt:
            admin.firestore.FieldValue.serverTimestamp(),
        });

      console.log("✅ NOTIFICATION SAVED");

    } catch (e) {
      console.error("🔥 ERROR:", e);
    }
  }
);