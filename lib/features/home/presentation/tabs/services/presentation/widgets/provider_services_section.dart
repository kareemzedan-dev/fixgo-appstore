import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/features/offers/domain/entities/offer_entity.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class ProviderServicesSection extends StatelessWidget {
  final List<OfferEntity> services;
  final int yearsOfExperience;
  final ValueChanged<OfferEntity> onServiceTap;

  const ProviderServicesSection({
    super.key,
    required this.services,
    required this.yearsOfExperience,
    required this.onServiceTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              AppLocalizations.of(context).servicesProvided,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: AppSizes.h(20)),
          Expanded(
            child: services.isEmpty
                ? Center(child: Text(AppLocalizations.of(context).noServices))
                : ListView.builder(
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      final service = services[index];
                      return InkWell(
                        onTap: () => onServiceTap(service),
                        child: Container(
                          margin: EdgeInsets.only(bottom: AppSizes.h(12)),
                          padding: EdgeInsets.all(AppSizes.p12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  service.imageUrl,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: AppSizes.w(16)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      service.profession ?? "",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ColorsManager.secondaryColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.orange,
                                          size: 16,
                                        ),
                                        Text(
                                          service.averageRating.toStringAsFixed(
                                            1,
                                          ),
                                        ),
                                        SizedBox(width: AppSizes.w(16)),
                                        Row(
                                          children: [
                                            Image.asset(
                                              AssetsManager.experience,
                                              height: 14,
                                              width: 14,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              AppLocalizations.of(
                                                context,
                                              ).yearValue(yearsOfExperience),
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text(service.description),
                                  ],
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios, size: 16),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
