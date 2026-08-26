import 'package:flutter/material.dart';
import 'package:fixgo/l10n/app_localizations.dart';

export 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/boost_package_actions.dart';

class BoostPackageHeader extends StatelessWidget {
  final String title;
  final String description;

  const BoostPackageHeader({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF160B48), Color(0xFF322C4E)],
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'NeoSansArabic',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          description,
          style: TextStyle(
            fontFamily: 'NeoSansArabic',
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

class BoostPackageStats extends StatelessWidget {
  final int views;
  final String duration;

  const BoostPackageStats({
    super.key,
    required this.views,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatItem(
          icon: Icons.visibility,
          value: '$views',
          label: AppLocalizations.of(context).packageView,
        ),
        const SizedBox(width: 20),
        _StatItem(
          icon: Icons.timer,
          value: duration,
          label: AppLocalizations.of(context).packageDurationDays,
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'NeoSansArabic',
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'NeoSansArabic',
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
