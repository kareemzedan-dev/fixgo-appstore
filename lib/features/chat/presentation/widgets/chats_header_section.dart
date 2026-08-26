import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/l10n/app_localizations.dart';
import 'package:fixgo/features/chat/presentation/widgets/header_back_button.dart';

class ChatsHeaderSection extends StatelessWidget {
  final String? title;

  const ChatsHeaderSection({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: AppSizes.w(16)),
        if (!kIsWeb) HeaderBackButton(),

        Expanded(
          child: Center(
            child: Text(
              title ?? AppLocalizations.of(context)!.chatTitle,
              style: TextStyle(
                fontSize: AppSizes.sp(16),
                fontWeight: FontWeight.w700,
                height: 1.6,
              ),
            ),
          ),
        ),

        SizedBox(width: AppSizes.w(48), height: AppSizes.h(48)),
      ],
    );
  }
}
