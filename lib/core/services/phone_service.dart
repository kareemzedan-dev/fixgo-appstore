import 'package:url_launcher/url_launcher.dart';

class PhoneService {
  static String _formatPhone(String phone) {
    phone = phone.replaceAll(RegExp(r'\s+'), '');

    /// لو الرقم فيه +
    phone = phone.replaceAll('+', '');

    /// لو مش بيبدأ بـ 968 → ضيفها
    if (!phone.startsWith('968')) {
      phone = '968$phone';
    }

    return phone;
  }

  static Future<void> openWhatsApp(String phone) async {
    final formatted = _formatPhone(phone);

    final url = Uri.parse("https://wa.me/$formatted");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw "Can't open WhatsApp";
    }
  }

  static Future<void> makeCall(String phone) async {
    final formatted = _formatPhone(phone);

    final url = Uri.parse("tel:+$formatted");

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Can't make call";
    }
  }
}
