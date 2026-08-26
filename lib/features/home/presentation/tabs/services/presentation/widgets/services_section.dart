import 'package:flutter/material.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/models/service_model.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/services_list.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class ServicesSection extends StatelessWidget {
  final String title;
  final List<ServiceModel> services;
  final VoidCallback? onViewAll;
  final bool? showOnViewAll;

  const ServicesSection({
    super.key,
    required this.title,
    required this.services,
    this.onViewAll,
    this.showOnViewAll = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              if (showOnViewAll != false)
                GestureDetector(
                  onTap: onViewAll,
                  child: Text(
                    AppLocalizations.of(context).showAll,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ServicesHorizontalList(services: services),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}
