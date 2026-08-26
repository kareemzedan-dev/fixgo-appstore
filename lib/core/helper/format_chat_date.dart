import 'package:intl/intl.dart';

/// داخل ChatItemCard
/// أضف هذه function

String formatChatDate(String date) {
  if (date.isEmpty) return "";

  try {
    final parsedDate = DateTime.parse(date);
    final now = DateTime.now();

    /// نفس اليوم → الساعة فقط
    if (parsedDate.year == now.year &&
        parsedDate.month == now.month &&
        parsedDate.day == now.day) {
      return DateFormat(
        'hh:mm a',
        'ar',
      ).format(parsedDate);
    }

    /// أمس
    final yesterday =
        now.subtract(
      const Duration(days: 1),
    );

    if (parsedDate.year ==
            yesterday.year &&
        parsedDate.month ==
            yesterday.month &&
        parsedDate.day ==
            yesterday.day) {
      return "أمس";
    }

    /// نفس السنة → يوم / شهر
    if (parsedDate.year == now.year) {
      return DateFormat(
        'd MMM',
        'ar',
      ).format(parsedDate);
    }

    /// سنة مختلفة
    return DateFormat(
      'd/M/yyyy',
      'ar',
    ).format(parsedDate);
  } catch (e) {
    return date;
  }
}