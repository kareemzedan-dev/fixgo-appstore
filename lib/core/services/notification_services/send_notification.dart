import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendNotification({
  required String token,
  required String title,
  required String body,
  String? chatId,
}) async {
  final url = Uri.parse(
    "https://us-central1-mkawlak.cloudfunctions.net/sendNotification",
  );

  await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "token": token,
      "title": title,
      "body": body,
      "chatId": chatId,
    }),
  );
}