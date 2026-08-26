import 'package:flutter/material.dart';
import 'package:fixgo/core/components/custom_app_bar.dart';
import 'package:fixgo/features/home/presentation/tabs/favorite/presentation/widgets/favorite_tab_view_body.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class FavoriteTabView extends StatelessWidget {
  const FavoriteTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context).favoritesTitle),
      body: const FavoriteTabViewBody(),
    );
  }
}
