import 'package:flutter/material.dart';
import 'package:fixgo/features/home/presentation/tabs/services/presentation/widgets/boost_package_content.dart';

class BoostPackageCard extends StatefulWidget {
  final String title;
  final int views;
  final String price;
  final String duration;
  final bool isSelected;
  final VoidCallback onPressed;
  final Map<String, dynamic>? features;
  final String description;
  final String bankAccount;
  const BoostPackageCard({
    super.key,
    required this.title,
    required this.views,
    required this.price,
    required this.duration,
    required this.isSelected,
    required this.onPressed,
    this.features,
    required this.description,
    required this.bankAccount,
  });

  @override
  State<BoostPackageCard> createState() => _BoostPackageCardState();
}

class _BoostPackageCardState extends State<BoostPackageCard> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: widget.isSelected
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  isDark ? const Color(0xFF160B48) : Colors.white,
                  isDark
                      ? const Color(0xFF322C4E)
                      : const Color(0xFF160B48).withOpacity(0.05),
                ],
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: widget.isSelected
                ? isDark
                      ? Color(0xFF322C4E)
                      : const Color(0xFF160B48).withOpacity(0.15)
                : isDark
                ? Color(0xFF322C4E)
                : Colors.black.withOpacity(0.05),
            blurRadius: widget.isSelected ? 15 : 8,
            offset: Offset(0, widget.isSelected ? 6 : 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (widget.isSelected)
            Positioned(
              right: -20,
              bottom: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF160B48).withOpacity(0.03),
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.black.withOpacity(0.3),
                width: 1,
              ),
              color: isDark ? const Color(0Xff1E1E1E) : Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoostPackageHeader(
                  title: widget.title,
                  description: widget.description,
                ),
                const SizedBox(height: 16),
                BoostPackageStats(
                  views: widget.views,
                  duration: widget.duration,
                ),
                const SizedBox(height: 16),
                BoostPackageBankTransfer(bankAccount: widget.bankAccount),
                const Divider(color: Colors.grey),
                const SizedBox(height: 12),
                BoostPackagePriceAction(
                  price: widget.price,
                  isSelected: widget.isSelected,
                  onPressed: widget.onPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
