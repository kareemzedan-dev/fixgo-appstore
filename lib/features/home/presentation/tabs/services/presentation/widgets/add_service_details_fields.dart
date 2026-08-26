import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class AddServiceDetailsFields extends StatelessWidget {
  const AddServiceDetailsFields({
    super.key,
    required this.titleController,
    required this.descriptionController,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.serviceTitle, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        TextFormField(
          controller: titleController,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Alyamama',
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintStyle: const TextStyle(
              color: ColorsManager.darkGrey,
              fontSize: 12,
              fontFamily: 'Alyamama',
              fontWeight: FontWeight.w400,
              height: 1.60,
            ),
            hintText: l10n.enterServiceTitle,
            contentPadding: const EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          l10n.serviceBio,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Alyamama',
            fontWeight: FontWeight.w400,
            height: 1.60,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: descriptionController,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Alyamama',
            fontWeight: FontWeight.w400,
            height: 1.6,
          ),
          decoration: InputDecoration(
            hintStyle: const TextStyle(
              color: ColorsManager.darkGrey,
              fontSize: 12,
              fontFamily: 'Alyamama',
              fontWeight: FontWeight.w400,
              height: 1.60,
            ),
            hintText: l10n.serviceDescriptionHint,
            contentPadding: const EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }
}
