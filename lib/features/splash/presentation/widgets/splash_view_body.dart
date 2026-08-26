import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fixgo/core/utils/assets_manager.dart';

import '../../../../core/utils/colors_manager.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetsManager.logo, width: 300, height: 300),

          // const Spacer(),

          // Padding(
          //   padding: EdgeInsets.only(bottom: 6.h),
          //   child: Align(
          //     alignment: Alignment.bottomCenter,
          //     child: Directionality(
          //       textDirection: TextDirection.ltr,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text(
          //             StringsManager.PoweredBy,
          //             style: Theme.of(context).textTheme.headlineLarge?.copyWith(
          //               color: ColorsManager.black,
          //               fontSize: RS.font(context, 18),
          //             ),
          //           ),
          //           SizedBox(width: RS.size(context, 6)),
          //           Image.asset(
          //             AssetsManager.agencyLogo,
          //             width: RS.size(context, 70),
          //             height: RS.size(context, 70),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
