import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';

class RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 336,
        height: 160,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? const Color(0xFF243E63)
                : const Color(0xFFE8E8E8),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: AppSizes.sp(20),
                      fontWeight: FontWeight.w700,
                      height: 1.60,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: AppSizes.h(16)),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: AppSizes.sp(14),
                      fontWeight: FontWeight.w400,
                      height: 1.60,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: AppSizes.w(22),
              height: AppSizes.h(22),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? ColorsManager.primaryColor : Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
