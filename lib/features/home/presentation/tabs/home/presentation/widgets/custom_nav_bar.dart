import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';

class NavItemModel {
  final String icon;
  final String label;

  NavItemModel({required this.icon, required this.label});
}

class CustomNavBar extends StatelessWidget {
  final List<NavItemModel> items;
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback onCenterTap;

  const CustomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    required this.onCenterTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: BottomAppBar(
        color: isDark ? Color(0Xff1E1E1E) : Colors.white,
        shape: const TopFabNotch(),
        notchMargin: 6,
        elevation: 0,
        child: SizedBox(
          height: AppSizes.h(55),
          child: Row(
            children: [
              Expanded(
                child: _NavItem(
                  icon: items[0].icon,
                  label: items[0].label,
                  active: currentIndex == 0,
                  onTap: () => onTap(0),
                ),
              ),

              Expanded(
                child: _NavItem(
                  icon: items[1].icon,
                  label: items[1].label,
                  active: currentIndex == 1,
                  onTap: () => onTap(1),
                ),
              ),

              const SizedBox(width: 50),

              Expanded(
                child: _NavItem(
                  icon: items[2].icon,
                  label: items[2].label,
                  active: currentIndex == 2,
                  onTap: () => onTap(2),
                ),
              ),

              Expanded(
                child: _NavItem(
                  icon: items[3].icon,
                  label: items[3].label,
                  active: currentIndex == 3,
                  onTap: () => onTap(3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: AppSizes.w(18),
              height: AppSizes.h(18),
              colorFilter: ColorFilter.mode(
                active ? ColorsManager.primaryColor : Colors.grey,
                BlendMode.srcIn,
              ),
            ),

            if (active)
              Text(
                label,
                style: TextStyle(
                  fontSize: AppSizes.sp(12),
                  fontWeight: FontWeight.w600,
                  color: ColorsManager.primaryColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TopFabNotch extends NotchedShape {
  const TopFabNotch();

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null) {
      return Path()..addRect(host);
    }

    final double notchRadius = guest.width / 2 + 10;
    final double center = guest.center.dx;

    final Path path = Path();

    path.moveTo(host.left, host.top);

    path.lineTo(center - notchRadius - 15, host.top);

    path.quadraticBezierTo(
      center,
      host.top - notchRadius - 30,
      center + notchRadius + 15,
      host.top,
    );

    path.lineTo(host.right, host.top);
    path.lineTo(host.right, host.bottom);
    path.lineTo(host.left, host.bottom);
    path.close();

    return path;
  }
}
