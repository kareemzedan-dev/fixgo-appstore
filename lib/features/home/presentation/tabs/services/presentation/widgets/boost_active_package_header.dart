import 'package:flutter/material.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class BoostActivePackageHeader extends StatelessWidget {
  const BoostActivePackageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        color: const Color(0xFF160B48),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF160B48).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(shape: BoxShape.circle),
            ),
          ),
          Positioned(
            bottom: -40,
            left: -20,
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(shape: BoxShape.circle),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: const Icon(Icons.rocket_launch, size: 40),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context).packageActive,
                  style: const TextStyle(
                    fontFamily: 'NeoSansArabic',
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
