
import 'package:flutter/material.dart';

import '../../../../../../../core/utils/app_sizes.dart';

class NotificationIcon extends StatelessWidget {
  final String icon;
  final int count;
  final VoidCallback onTap;

  const NotificationIcon({
    super.key,
    required this.icon,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      child: Stack(
        clipBehavior: Clip.none,
        children: [


          Container(
              width:  AppSizes.w(40),
              height: AppSizes.h(40),
              decoration: BoxDecoration(
                color:Color(0xFFF0F0F1),
                shape: BoxShape.circle,
              ),
              child:  Image.asset(
                icon,
                height: AppSizes.w(20),
                width: AppSizes.w(20),

              )
          ),

          if(count!=0)
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}