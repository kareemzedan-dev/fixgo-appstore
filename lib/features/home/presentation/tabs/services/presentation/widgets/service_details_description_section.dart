//==========================
// 6. service_details_description_section.dart
//==========================
import 'package:flutter/material.dart';
import 'package:fixgo/l10n/app_localizations.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';

class ServiceDetailsDescriptionSection extends StatelessWidget {
  final String description;
  const ServiceDetailsDescriptionSection({Key? key, required this.description})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).serviceBio,
          style: TextStyle(
            fontSize: AppSizes.sp(14),
            fontWeight: FontWeight.w700,
            height: 1.60,
          ),
        ),
        SizedBox(height: AppSizes.h(12)),
        RichText(
          textAlign: TextAlign.right,
          text: TextSpan(
            style: TextStyle(
              color: ColorsManager.darkGrey,
              fontSize: AppSizes.sp(12),
              fontFamily: 'Alyamama',
              fontWeight: FontWeight.w400,
              height: 1.60,
            ),
            children: _buildHighlightedText(description),
          ),
        ),
      ],
    );
  }
}

List<TextSpan> _buildHighlightedText(String text) {
  final RegExp exp = RegExp(r'#[\u0600-\u06FF]+');

  final matches = exp.allMatches(text);

  int lastIndex = 0;
  List<TextSpan> spans = [];

  for (final match in matches) {
    // النص العادي قبل الهاشتاج
    if (match.start > lastIndex) {
      spans.add(TextSpan(text: text.substring(lastIndex, match.start)));
    }

    // الهاشتاج
    spans.add(
      TextSpan(
        text: match.group(0),
        style: TextStyle(
          color: ColorsManager.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    lastIndex = match.end;
  }

  // باقي النص
  if (lastIndex < text.length) {
    spans.add(TextSpan(text: text.substring(lastIndex)));
  }

  return spans;
}
