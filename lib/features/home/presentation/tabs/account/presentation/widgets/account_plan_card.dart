import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/features/home/presentation/tabs/account/domain/entities/plan_entity.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class AccountPlanCard extends StatelessWidget {
  const AccountPlanCard({required this.plan, required this.onTap, super.key});

  final PlanEntity plan;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(0.0),
          child: Card(
            elevation: 8,
            shadowColor: const Color(0xFF160B48).withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isDark ? const Color(0Xff1E1E1E) : Colors.white,
                border: Border.all(
                  color: const Color(0xFF160B48).withOpacity(0.1),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF160B48), Color(0xFF322C4E)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF160B48).withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  plan.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'NeoSansArabic',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              _PriceBadge(price: plan.price),
                            ],
                          ),
                          if (plan.description.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              plan.description,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontFamily: 'NeoSansArabic',
                                height: 1.4,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorsManager.primaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.touch_app,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      ).tapForDetails,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'NeoSansArabic',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_right_outlined,
                                size: 16,
                                color: Color(0xFF160B48),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PriceBadge extends StatelessWidget {
  const _PriceBadge({required this.price});

  final String? price;

  @override
  Widget build(BuildContext context) {
    final hasPrice = price != null && price!.isNotEmpty;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: hasPrice
              ? [Colors.green[400]!, Colors.green[600]!]
              : [Colors.grey[300]!, Colors.grey[400]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: hasPrice
            ? [
                BoxShadow(
                  color: Colors.green.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Text(
        hasPrice
            ? AppLocalizations.of(context).priceInRiyals(price!)
            : AppLocalizations.of(context).free,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'NeoSansArabic',
        ),
      ),
    );
  }
}
