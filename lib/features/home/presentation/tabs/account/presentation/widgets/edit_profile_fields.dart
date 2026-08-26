import 'package:flutter/material.dart';
import 'package:fixgo/core/components/custom_text_field.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/auth/presentation/widgets/phone_text_field.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class EditProfileFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final String address;
  final VoidCallback onEditAddress;

  const EditProfileFields({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.address,
    required this.onEditAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context).username),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: AppLocalizations.of(context).username,
          controller: nameController,
        ),
        const SizedBox(height: 16),
        Text(AppLocalizations.of(context).phoneNumber),
        const SizedBox(height: 8),
        PhoneTextField(controller: phoneController, enabled: false),
        const SizedBox(height: 20),
        AddressCard(address: address, onEdit: onEditAddress),
      ],
    );
  }
}

class AddressCard extends StatelessWidget {
  final String address;
  final VoidCallback? onEdit;

  const AddressCard({super.key, required this.address, this.onEdit});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(AppLocalizations.of(context).address),
            const Spacer(),
            GestureDetector(
              onTap: onEdit,
              child: Text(AppLocalizations.of(context).edit),
            ),
          ],
        ),
        SizedBox(height: AppSizes.h(12)),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE5E5E5)),
            borderRadius: BorderRadius.circular(16),
            color: isDark ? const Color(0Xff1E1E1E) : Colors.white,
          ),
          child: Text(address),
        ),
      ],
    );
  }
}
