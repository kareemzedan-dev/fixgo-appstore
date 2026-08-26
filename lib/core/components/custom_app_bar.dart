import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: centerTitle,

      /// iOS Back Icon
      leading: Navigator.canPop(context)
          ? IconButton(
              icon: const Icon(CupertinoIcons.back),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,

      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: AppSizes.sp(16),
        ),
      ),

      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
