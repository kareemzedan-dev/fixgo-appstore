import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/models/service_model.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/search_and_filter.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/services_section.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class ServicesTabViewBody extends StatelessWidget {
  const ServicesTabViewBody({super.key});

  void _openMoreServices(BuildContext context, String type) {
    final route = '/more-services/$type';
    if (kIsWeb) {
      context.go(route);
    } else {
      context.push(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    ServiceModel service(String title, String categoryId, String image) =>
        ServiceModel(title: title, categoryId: categoryId, image: image);

    final maintenance = [
      service(l10n.airConditioning, 'مكيفات', AssetsManager.service1),
      service(l10n.carpentry, 'نجارة', AssetsManager.service2),
      service(l10n.painting, 'دهانات', AssetsManager.service3),
      service(l10n.plumbing, 'سباكة', AssetsManager.service4),
      service(l10n.electricity, 'كهرباء', AssetsManager.service5),
      service(l10n.blacksmithing, 'حدادة', AssetsManager.service6),
      service(l10n.finishing, 'تشطيب', AssetsManager.service5),
      service(l10n.homeAppliances, 'أجهزة منزلية', AssetsManager.service5),
      service(l10n.washingMachines, 'غسالات', AssetsManager.service5),
    ];
    final construction = [
      service(l10n.painting, 'دهانات', AssetsManager.service3),
      service(l10n.ceramic, 'سيراميك', AssetsManager.service7),
      service(l10n.gypsumBoard, 'جبس بورد', AssetsManager.service2),
      service(l10n.kitchens, 'مطابخ', AssetsManager.service8),
      service(l10n.parquet, 'باركيه', AssetsManager.service5),
      service(l10n.constructionWork, 'أعمال بناء', AssetsManager.service5),
      service(l10n.decor, 'ديكور', AssetsManager.service5),
    ];
    final cleaning = [
      service(l10n.homes, 'منازل', AssetsManager.service5),
      service(l10n.offices, 'مكاتب', AssetsManager.service5),
      service(l10n.carpets, 'سجاد', AssetsManager.service5),
      service(l10n.tanks, 'خزانات', AssetsManager.service5),
      service(l10n.glassFacades, 'واجهات زجاج', AssetsManager.service5),
    ];

    return ListView(
      children: [
        SearchAndFilter(onSearch: (_) {}, onFilter: () {}, showfiler: false),
        SizedBox(height: AppSizes.p16),
        ServicesSection(
          title: l10n.homeMaintenanceServices,
          services: maintenance,
          onViewAll: () => _openMoreServices(context, 'home-maintenance'),
        ),
        ServicesSection(
          title: l10n.finishingConstructionServices,
          services: construction,
          onViewAll: () => _openMoreServices(context, 'construction'),
        ),
        ServicesSection(
          title: l10n.cleaningServices,
          services: cleaning,
          onViewAll: () => _openMoreServices(context, 'cleaning'),
        ),
        ServicesSection(
          showOnViewAll: false,
          title: l10n.transportDeliveryServices,
          services: [
            service(l10n.furnitureMoving, 'نقل عفش', AssetsManager.service5),
            service(
              l10n.furnitureRelocation,
              'تحريك أثاث',
              AssetsManager.service5,
            ),
            service(l10n.orderDelivery, 'توصيل طلبات', AssetsManager.service5),
          ],
        ),
        ServicesSection(
          showOnViewAll: false,
          title: l10n.administrativeServices,
          services: [
            service(l10n.governmentFollowUp, 'تعقيب', AssetsManager.service5),
            service(
              l10n.paperworkClearance,
              'تخليص أوراق',
              AssetsManager.service5,
            ),
            service(l10n.governmentServices, 'حكومية', AssetsManager.service5),
          ],
        ),
      ],
    );
  }
}
