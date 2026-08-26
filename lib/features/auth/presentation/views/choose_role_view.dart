import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/components/custom_button.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/auth/presentation/widgets/auth_header.dart';
import 'package:fixgo/features/auth/presentation/widgets/role_card.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class ChooseRoleView extends StatefulWidget {
  const ChooseRoleView({super.key});

  @override
  State<ChooseRoleView> createState() => _ChooseRoleViewState();
}

class _ChooseRoleViewState extends State<ChooseRoleView> {
  int selectedIndex = 0;

  void _onChoose(BuildContext context) {
    context.push("/register", extra: {"isWorker": selectedIndex == 0});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 36.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AuthHeader(
                  title: l10n.iAm,
                  headerTitle: l10n.login,

                  onHeaderTap: () {
                    context.push("/login");
                  },
                ),

                SizedBox(height: AppSizes.h(32)),

                RoleCard(
                  title: l10n.serviceProviderRole,
                  subtitle: l10n.serviceProviderRoleSubtitle,
                  isSelected: selectedIndex == 0,
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                ),

                const SizedBox(height: 16),

                RoleCard(
                  title: l10n.findServiceRole,
                  subtitle: l10n.findServiceRoleSubtitle,
                  isSelected: selectedIndex == 1,
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                ),

                SizedBox(height: AppSizes.h(32)),

                CustomButton(
                  text: l10n.continueLabel,
                  onPressed: () {
                    _onChoose(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
