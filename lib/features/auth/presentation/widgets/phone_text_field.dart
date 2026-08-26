import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class PhoneTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;

  const PhoneTextField({
    super.key,
    required this.controller,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFE8E8E8),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          /// Country Code
          const Text(
            "968+",
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Alyamama',
              fontWeight: FontWeight.w600,
              height: 1.60,
            ),
          ),

          /// Divider
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            height: 24,
            width: 1,
            color: const Color(0xFFE8E8E8),
          ),

          /// Text Field
          Expanded(
            child: TextFormField(
              enabled: enabled,
              controller: controller,

              /// أرقام فقط
              keyboardType: TextInputType.number,

              /// يمنع أكثر من 9 أرقام
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(8),
              ],

              textAlign: TextAlign.right,

              style: TextStyle(
                fontSize: AppSizes.sp(12),
                fontWeight: FontWeight.w600,
                height: 1.60,
              ),

              decoration: InputDecoration(
                hintText: l10n.phoneNumber,

                hintStyle: TextStyle(
                  color: ColorsManager.darkGrey,
                  fontSize: 12,
                  fontFamily: 'Alyamama',
                  fontWeight: FontWeight.w300,
                  height: 1.60,
                ),

                border: InputBorder.none,

                counterText: "", // يخفي عداد الأحرف
              ),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.enterPhoneNumber;
                }

                if (value.length != 9) {
                  return l10n.phoneNumberNineDigits;
                }

                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OmanPhoneTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;

  const OmanPhoneTextField({
    super.key,
    required this.controller,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE8E8E8)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Text(
            "+968",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            width: 1,
            height: 24,
            color: const Color(0xFFE8E8E8),
          ),

          Expanded(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: TextFormField(
                controller: controller,
                enabled: enabled,
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.left,
                maxLength: 8,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(8),
                ],
                decoration: const InputDecoration(
                  hintText: "90000001",
                  border: InputBorder.none,
                  counterText: "",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.enterPhoneNumber;
                  }

                  if (value.length != 8) {
                    return l10n.phoneNumberEightDigits;
                  }

                  if (!RegExp(r'^[789]').hasMatch(value)) {
                    return l10n.phoneNumberStart789;
                  }

                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
