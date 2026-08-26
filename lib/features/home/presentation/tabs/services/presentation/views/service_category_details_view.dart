import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/components/custom_app_bar.dart';
import 'package:fixgo/core/di/di.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/service_details_view_body.dart';
import 'package:fixgo/features/offers/presentation/manager/service_category_cubit/service_category_cubit.dart';

class ServiceCategoryDetailsView extends StatelessWidget {
  final String category;

  const ServiceCategoryDetailsView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: category),
      body: BlocProvider(
        create: (context) => getIt<ServiceCategoryCubit>(),
        child: ServiceDetailsViewBody(category: category),
      ),
    );
  }
}
