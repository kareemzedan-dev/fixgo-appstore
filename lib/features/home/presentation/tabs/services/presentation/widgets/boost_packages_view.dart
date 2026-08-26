import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/boost_package_card.dart';
import 'package:fixgo/features/view_packages/presentation/manager/get_all_boost_package_view_model/get_all_boost_package_states.dart';
import 'package:fixgo/features/view_packages/presentation/manager/get_all_boost_package_view_model/get_all_boost_package_view_model.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class BoostPackagesView extends StatelessWidget {
  final ValueChanged<String> onSubscribe;

  const BoostPackagesView({super.key, required this.onSubscribe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).choosePackage,
            style: const TextStyle(
              fontFamily: 'NeoSansArabic',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context).boostPackageSubtitle,
            style: TextStyle(
              fontFamily: 'NeoSansArabic',
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child:
                BlocBuilder<
                  GetAllBoostPackageViewModel,
                  GetAllBoostPackageStates
                >(
                  builder: (context, state) {
                    if (state is GetAllBoostPackageLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is GetAllBoostPackageSuccess) {
                      return ListView.builder(
                        itemCount: state.packages.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final package = state.packages[index];
                          return BoostPackageCard(
                            title: package.title,
                            views: package.views,
                            price: package.price,
                            duration: package.duration,
                            isSelected: false,
                            description: package.description,
                            bankAccount: package.bankAccount,
                            onPressed: () => onSubscribe(package.title),
                          );
                        },
                      );
                    }
                    if (state is GetAllBoostPackageError) {
                      return Center(child: Text(state.error));
                    }
                    return const SizedBox.shrink();
                  },
                ),
          ),
        ],
      ),
    );
  }
}
