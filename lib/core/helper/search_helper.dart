import 'package:fixgo/core/constants/cities.dart';
import 'package:fixgo/core/constants/profession_keywords.dart';

/// ===============================
/// data/helpers/search_helper.dart
/// ===============================

class SearchHelper {
  static const List<String> ignoredWords = [
    "معلم",
    "ممتاز",
    "خبير",
    "محترف",
    "شاطر",
    "في",
    "ب",
    "بـ",
    "من",
    "الى",
    "عن",
    "على",
  ];

  static String normalizeArabic(String text) {
    text = text.toLowerCase();

    /// توحيد الهمزات
    text = text.replaceAll(RegExp(r'[أإآ]'), 'ا');

    /// تحويل ة → ه
    text = text.replaceAll('ة', 'ه');

    /// حذف التشكيل
    text = text.replaceAll(RegExp(r'[ًٌٍَُِّْـ]'), '');

    /// حذف تكرار الحروف
    text = text.replaceAll(RegExp(r'(.)\1+'), r'\1');

    return text;
  }

  static String? detectCity(String query) {
    final normalizedQuery = normalizeArabic(query);

    for (final city in cities) {
      if (normalizedQuery.contains(normalizeArabic(city))) {
        return city;
      }
    }

    return null;
  }

  static String? detectProfession(String query) {
    final normalizedQuery = normalizeArabic(query);

    for (final entry in professionKeywords.entries) {
      for (final keyword in entry.value) {
        if (normalizedQuery.contains(normalizeArabic(keyword))) {
          return entry.key;
        }
      }
    }

    return null;
  }

  static bool smartSearch(String query, String text) {
    final normalizedText = normalizeArabic(text).replaceAll("ى", "ي");

    final words = query
        .split(" ")
        .map((word) {
          var w = normalizeArabic(word).replaceAll("ى", "ي");

          /// إزالة البادئات
          if (w.startsWith("ب") && w.length > 2) {
            w = w.substring(1);
          }

          if (w.startsWith("ال") && w.length > 3) {
            w = w.substring(2);
          }

          return w;
        })
        .where((w) => w.isNotEmpty && !ignoredWords.contains(w))
        .toList();

    if (words.isEmpty) {
      return false;
    }

    int matchedWords = 0;

    for (final word in words) {
      if (normalizedText.contains(word)) {
        matchedWords++;
      }
    }

    /// =========================
    /// لو كلمة واحدة فقط
    /// =========================

    if (words.length == 1) {
      return matchedWords == 1;
    }

    /// =========================
    /// لو كلمتين أو أكثر
    /// لازم كلهم يتطابقوا
    /// =========================

    return matchedWords == words.length;
  }
}
