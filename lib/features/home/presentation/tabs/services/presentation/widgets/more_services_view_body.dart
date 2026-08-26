/// ===============================
/// MoreServicesViewBody
/// ===============================

import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/models/service_model.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/search_and_filter.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/services_grid.dart';

class MoreServicesViewBody extends StatelessWidget {
  final List<ServiceModel> services;

  const MoreServicesViewBody({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SearchAndFilter(onSearch: (String value) {}, onFilter: () {}),

          SizedBox(height: AppSizes.p12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ServicesGrid(services: services),
          ),
        ],
      ),
    );
  }
}
