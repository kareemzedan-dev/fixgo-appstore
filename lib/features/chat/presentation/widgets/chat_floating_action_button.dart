import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/core/utils/colors_manager.dart';

class ChatFloatingActionButton extends StatelessWidget {
  const ChatFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ColorsManager.primaryColor,
      onPressed: () {
        if (kIsWeb) {
          context.go('/following_users');
        } else {
          context.push('/following_users');
        }
      },
      child: Center(
        child: Image.asset(AssetsManager.edit, color: Colors.white),
      ),
    );
  }
}
