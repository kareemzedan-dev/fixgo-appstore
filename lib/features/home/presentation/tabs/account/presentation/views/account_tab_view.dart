import 'package:flutter/material.dart';
import 'package:fixgo/core/components/custom_app_bar.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/widgets/account_tab_view_body.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class AccountTabView extends StatelessWidget {
  const AccountTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context).myAccount),
      body: const AccountTabViewBody(),
    );
  }
}
