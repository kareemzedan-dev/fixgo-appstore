import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/models/service_model.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/service_item.dart';

class ServicesHorizontalList extends StatelessWidget {
  final List<ServiceModel> services;

  const ServicesHorizontalList({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.h(130),
      child: ListView.builder(
        shrinkWrap: true,

        scrollDirection: Axis.horizontal,
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];

          return ServiceItem(
            title: service.title,
            image: service.image,
            categoryId: service.categoryId,
          );
        },
      ),
    );
  }
}
