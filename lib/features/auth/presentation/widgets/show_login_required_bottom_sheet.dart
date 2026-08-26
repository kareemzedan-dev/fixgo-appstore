import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/components/custom_button.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/l10n/app_localizations.dart';

void showLoginRequiredBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      final l10n = AppLocalizations.of(context);
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// top handle
            Container(
              width: 70,
              height: 5,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(100),
              ),
            ),

            const SizedBox(height: 20),

            /// title row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 6,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A70),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.addService,
                  style: TextStyle(
                    fontSize: AppSizes.sp(24),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// icon
            const Icon(Icons.person, size: 140, color: Colors.grey),

            const SizedBox(height: 24),

            /// main title
            Text(
              l10n.loginRequiredTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppSizes.sp(24),
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 16),

            /// subtitle
            Text(
              l10n.loginRequiredPageMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppSizes.sp(16),
                color: const Color(0xFF8A8A8A),
                fontWeight: FontWeight.w400,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 32),

            /// button
            CustomButton(
              text: l10n.login,
              onPressed: () {
                Navigator.pop(context);
                context.push("/login");
              },
            ),

            const SizedBox(height: 12),
          ],
        ),
      );
    },
  );
}
