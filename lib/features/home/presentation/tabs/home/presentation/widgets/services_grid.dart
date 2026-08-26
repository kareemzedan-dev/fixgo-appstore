import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/models/service_model.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/service_item.dart';

class ServicesGrid extends StatelessWidget {
  final List<ServiceModel> services;

  const ServicesGrid({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: .9,
      ),
      itemBuilder: (context, index) {
        final service = services[index];

        return InkWell(
          onTap: () {
            final category =
                services[index].categoryId ?? services[index].title;

            if (kIsWeb) {
              context.go("/service-category-details/$category");
            } else {
              context.push("/service-category-details/$category");
            }
          },
          child: ServiceItem(
            title: service.title,
            image: service.image,
            onTap: service.onTap,
          ),
        );
      },
    );
  }
}
