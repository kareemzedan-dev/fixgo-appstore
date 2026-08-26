import 'package:flutter/material.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class BoostViewsProgressCard extends StatelessWidget {
  const BoostViewsProgressCard({
    required this.remainingViews,
    required this.totalViews,
    required this.remainingPercentage,
    super.key,
  });

  final int remainingViews;
  final int totalViews;
  final double remainingPercentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Color(0xFFF3F4FF)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF160B48).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF160B48).withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context).remainingViews,
                style: TextStyle(
                  fontFamily: 'NeoSansArabic',
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      AppLocalizations.of(context).active,
                      style: TextStyle(
                        fontFamily: 'NeoSansArabic',
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '$remainingViews',
                style: const TextStyle(
                  fontFamily: 'NeoSansArabic',
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF160B48),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '/ $totalViews',
                style: TextStyle(
                  fontFamily: 'NeoSansArabic',
                  fontSize: 20,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: remainingPercentage,
              minHeight: 12,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF160B48),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BoostPackageInfoCard extends StatelessWidget {
  const BoostPackageInfoCard({
    required this.icon,
    required this.title,
    required this.value,
    this.subtitle = '',
    this.iconColor = const Color(0xFF160B48),
    this.showProgress = false,
    this.progressValue = 0,
    super.key,
  });

  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final Color iconColor;
  final bool showProgress;
  final double progressValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'NeoSansArabic',
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'NeoSansArabic',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF160B48),
            ),
          ),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontFamily: 'NeoSansArabic',
                fontSize: 11,
                color: Colors.grey.shade500,
              ),
            ),
          ],
          if (showProgress) ...[
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progressValue,
              minHeight: 4,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(iconColor),
            ),
          ],
        ],
      ),
    );
  }
}
