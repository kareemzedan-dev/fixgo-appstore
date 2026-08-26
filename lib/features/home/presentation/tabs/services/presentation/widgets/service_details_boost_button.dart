//==========================
// 3. service_details_boost_button.dart
//==========================
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/boost_views_button.dart';

class ServiceDetailsBoostButton extends StatelessWidget {
  final dynamic offer;
  const ServiceDetailsBoostButton({Key? key, required this.offer})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BoostViewsButton(
      onPressed: () {
        if (kIsWeb) {
          context.go('/offer/boost/${offer.id}');
        } else {
          context.push('/offer/boost/${offer.id}');
        }
      },
    );
  }
}
