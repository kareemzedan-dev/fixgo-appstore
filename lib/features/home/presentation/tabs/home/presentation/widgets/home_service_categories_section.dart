import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/models/service_model.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/services_grid.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class HomeServiceCategoriesSection extends StatelessWidget {
  const HomeServiceCategoriesSection({
    super.key,
    required this.onShowAll,
    required this.onCategorySelected,
  });

  final VoidCallback onShowAll;
  final ValueChanged<String> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final services = [
      ServiceModel(
        title: l10n.airConditioning,
        image: AssetsManager.service1,
        onTap: () => onCategorySelected('مكيفات'),
      ),
      ServiceModel(
        title: l10n.carpentry,
        image: AssetsManager.service2,
        onTap: () => onCategorySelected('نجارة'),
      ),
      ServiceModel(
        title: l10n.painting,
        image: AssetsManager.service3,
        onTap: () => onCategorySelected('دهانات'),
      ),
      ServiceModel(
        title: l10n.plumbing,
        image: AssetsManager.service4,
        onTap: () => onCategorySelected('سباكة'),
      ),
      ServiceModel(
        title: l10n.electricity,
        image: AssetsManager.service5,
        onTap: () => onCategorySelected('كهرباء'),
      ),
      ServiceModel(
        title: l10n.blacksmithing,
        image: AssetsManager.service6,
        onTap: () => onCategorySelected('حدادة'),
      ),
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.mostRequestedServices,
                style: TextStyle(
                  fontSize: AppSizes.p16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: onShowAll,
                child: Text(
                  l10n.showAll,
                  style: TextStyle(
                    fontSize: AppSizes.p12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSizes.p12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ServicesGrid(services: services),
        ),
      ],
    );
  }
}
