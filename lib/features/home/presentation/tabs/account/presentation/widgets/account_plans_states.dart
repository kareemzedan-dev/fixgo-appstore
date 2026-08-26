import 'package:flutter/material.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class AccountPlansLoadingState extends StatelessWidget {
  const AccountPlansLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF160B48)),
            strokeWidth: 3,
          ),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context).loading,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'NeoSansArabic',
              color: Color(0xFF160B48),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class AccountPlansEmptyState extends StatelessWidget {
  const AccountPlansEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF160B48).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.inbox_outlined,
              size: 60,
              color: Color(0xFF160B48),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context).noPlansAvailable,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'NeoSansArabic',
              color: Color(0xFF160B48),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class AccountPlansErrorState extends StatelessWidget {
  const AccountPlansErrorState({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.error_outline,
                size: 60,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context).genericError,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.red,
                fontFamily: 'NeoSansArabic',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.red,
                fontFamily: 'NeoSansArabic',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF160B48),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 5,
              ),
              child: Text(
                AppLocalizations.of(context).retry,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'NeoSansArabic',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
