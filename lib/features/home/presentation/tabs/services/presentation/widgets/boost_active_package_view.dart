import 'package:flutter/material.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/boost_active_package_header.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/boost_package_metrics.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class BoostActivePackageView extends StatelessWidget {
  final int remainingViews;
  final int totalViews;
  final DateTime? viewsExpireAt;

  const BoostActivePackageView({
    super.key,
    required this.remainingViews,
    required this.totalViews,
    required this.viewsExpireAt,
  });

  @override
  Widget build(BuildContext context) {
    final remainingPercentage = totalViews > 0
        ? remainingViews / totalViews
        : 0.0;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const BoostActivePackageHeader(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  BoostViewsProgressCard(
                    remainingViews: remainingViews,
                    totalViews: totalViews,
                    remainingPercentage: remainingPercentage,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: BoostPackageInfoCard(
                          icon: Icons.calendar_today,
                          title: AppLocalizations.of(context).expiryDate,
                          value: viewsExpireAt != null
                              ? '${viewsExpireAt!.day} / ${viewsExpireAt!.month} / ${viewsExpireAt!.year}'
                              : AppLocalizations.of(context).unspecified,
                          subtitle: viewsExpireAt != null
                              ? _getDaysRemaining(context, viewsExpireAt!)
                              : '',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: BoostPackageInfoCard(
                          icon: Icons.speed,
                          title: AppLocalizations.of(context).performance,
                          value: '${(remainingPercentage * 100).round()}%',
                          subtitle: AppLocalizations.of(
                            context,
                          ).packageRemaining,
                          iconColor: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  BoostPackageInfoCard(
                    icon: Icons.analytics,
                    title: AppLocalizations.of(context).consumptionRate,
                    value: '${((1 - remainingPercentage) * 100).round()}%',
                    subtitle: AppLocalizations.of(context).consumed,
                    iconColor: Colors.purple,
                    showProgress: true,
                    progressValue: 1 - remainingPercentage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDaysRemaining(BuildContext context, DateTime expireDate) {
    final difference = expireDate.difference(DateTime.now()).inDays;
    if (difference < 0) return AppLocalizations.of(context).expired;
    if (difference == 0) return AppLocalizations.of(context).expiresToday;
    return AppLocalizations.of(context).daysRemaining(difference);
  }
}
