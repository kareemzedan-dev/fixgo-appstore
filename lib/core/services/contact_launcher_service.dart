import 'package:url_launcher/url_launcher.dart';

class ContactLauncherService {

  static Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      print("❌ Cannot open URL: $url");
    }
  }

static Future<void> openWhatsApp({
  required String phone,
  required String message,
}) async {
  final String encodedMessage = Uri.encodeComponent(message);

  final Uri uri = Uri.parse(
    "https://wa.me/$phone?text=$encodedMessage",
  );

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    print("❌ Cannot open WhatsApp");
  }
}

  static Future<void> openMapByLink(String link) async {
    final Uri uri = Uri.parse(link);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      print("❌ Cannot open Maps");
    }
  }

 
}
