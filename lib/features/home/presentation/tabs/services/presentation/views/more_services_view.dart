import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/features/chat/presentation/widgets/chats_header_section.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/models/service_model.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/more_services_view_body.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class MoreServicesView extends StatelessWidget {
  final String type;

  const MoreServicesView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    ServiceModel service(String title, String categoryId, String image) =>
        ServiceModel(title: title, categoryId: categoryId, image: image);

    late final String title;
    late final List<ServiceModel> services;
    switch (type) {
      case 'home-maintenance':
        title = l10n.homeMaintenanceServices;
        services = [
          service(l10n.airConditioning, 'مكيفات', AssetsManager.service1),
          service(l10n.carpentry, 'نجارة', AssetsManager.service2),
          service(l10n.painting, 'دهانات', AssetsManager.service3),
          service(l10n.plumbing, 'سباكة', AssetsManager.service4),
          service(l10n.electricity, 'كهرباء', AssetsManager.service5),
          service(l10n.blacksmithing, 'حدادة', AssetsManager.service5),
          service(l10n.finishing, 'تشطيب', AssetsManager.service5),
          service(l10n.homeAppliances, 'أجهزة منزلية', AssetsManager.service5),
          service(l10n.washingMachines, 'غسالات', AssetsManager.service5),
        ];
        break;
      case 'construction':
        title = l10n.finishingConstructionServices;
        services = [
          service(l10n.painting, 'دهانات', AssetsManager.service3),
          service(l10n.ceramic, 'سيراميك', AssetsManager.service7),
          service(l10n.gypsumBoard, 'جبس بورد', AssetsManager.service2),
          service(l10n.kitchens, 'مطابخ', AssetsManager.service8),
          service(l10n.parquet, 'باركيه', AssetsManager.service5),
          service(l10n.constructionWork, 'أعمال بناء', AssetsManager.service5),
          service(l10n.decor, 'ديكور', AssetsManager.service5),
        ];
        break;
      case 'cleaning':
        title = l10n.cleaningServices;
        services = [
          service(l10n.homes, 'منازل', AssetsManager.service5),
          service(l10n.offices, 'مكاتب', AssetsManager.service5),
          service(l10n.carpets, 'سجاد', AssetsManager.service5),
          service(l10n.tanks, 'خزانات', AssetsManager.service5),
          service(l10n.glassFacades, 'واجهات زجاج', AssetsManager.service5),
        ];
        break;
      default:
        title = '';
        services = [];
        break;
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: AppSizes.h(20)),
            ChatsHeaderSection(title: title),
            SizedBox(height: AppSizes.h(20)),
            MoreServicesViewBody(services: services),
          ],
        ),
      ),
    );
  }
}
