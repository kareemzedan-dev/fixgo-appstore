/// worker_required_bottom_sheet.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class WorkerRequiredBottomSheet extends StatelessWidget {
  const WorkerRequiredBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0Xff1E1E1E) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// handle
          Container(
            width: 60,
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E5E5),
              borderRadius: BorderRadius.circular(100),
            ),
          ),

          const SizedBox(height: 20),

          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              AppLocalizations.of(context).addService,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF1D1D1F),
              ),
            ),
          ),

          const SizedBox(height: 24),

          const CircleAvatar(
            radius: 48,
            backgroundColor: Color(0xFFF2F2F2),
            child: Icon(Icons.person, size: 60, color: Colors.grey),
          ),

          const SizedBox(height: 24),

          Text(
            AppLocalizations.of(context).providerAccountRequiredTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 12),

          Text(
            AppLocalizations.of(context).providerAccountRequiredMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.grey,
              height: 1.7,
            ),
          ),

          const SizedBox(height: 28),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                context.push("/role_selection");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF29466F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                elevation: 0,
              ),
              child: Text(
                AppLocalizations.of(context).login,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
