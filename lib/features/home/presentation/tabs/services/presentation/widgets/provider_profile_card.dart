import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class ProviderProfileCard extends StatelessWidget {
  final Map provider;

  const ProviderProfileCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 250,
      margin: EdgeInsets.all(AppSizes.p16),
      padding: EdgeInsets.all(AppSizes.p16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0Xff1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(6),
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
              ),
              child: ClipOval(
                child:
                    provider["imageUrl"] != null &&
                        provider["imageUrl"].toString().isNotEmpty
                    ? Image.network(
                        provider["imageUrl"],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildFallback(),
                      )
                    : _buildFallback(),
              ),
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        AssetsManager.experience,
                        height: 16,
                        width: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        AppLocalizations.of(
                          context,
                        ).yearValue(provider["yearsOfExperience"] ?? 0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    AppLocalizations.of(context).scientificExperience,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        AssetsManager.distance,
                        height: 16,
                        width: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        provider["neighborhood"] ??
                            provider["location"] ??
                            provider["district"] ??
                            "",
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    AppLocalizations.of(context).area,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        (provider["averageRating"] ?? 0).toStringAsFixed(1),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    AppLocalizations.of(
                      context,
                    ).ratingsCount(provider["ratingsCount"] ?? 0),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFallback() {
    return Center(
      child: Text(
        (provider["name"] ?? "?")[0],
        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }
}
