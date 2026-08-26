import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class ChatDateBadge extends StatelessWidget {
  final DateTime date;

  const ChatDateBadge({super.key, required this.date});

  String formatDate(BuildContext context, DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(date.year, date.month, date.day);
    final difference = today.difference(messageDate).inDays;
    if (difference == 0) return AppLocalizations.of(context)!.today;
    if (difference == 1) return AppLocalizations.of(context)!.yesterday;
    if (difference < 7) {
      return DateFormat('EEEE').format(date);
    }
    return DateFormat('dd MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.p16,
        vertical: AppSizes.p8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE6E6E6),
        borderRadius: BorderRadius.circular(AppSizes.r12),
      ),
      child: Text(
        formatDate(context, date),
        style: TextStyle(
          color: ColorsManager.darkGrey,
          fontSize: AppSizes.sp(13),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
