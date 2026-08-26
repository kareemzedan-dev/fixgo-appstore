import 'package:flutter/material.dart';
import 'package:fixgo/core/components/custom_app_bar.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/services_tab_view_body.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class ServicesTabView extends StatelessWidget {
  const ServicesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context).serviceCategories,
      ),
      body: const ServicesTabViewBody(),
    );
  }
}
