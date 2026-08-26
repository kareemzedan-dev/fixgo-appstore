import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class BoostPackageBankTransfer extends StatelessWidget {
  const BoostPackageBankTransfer({required this.bankAccount, super.key});

  final String bankAccount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF160B48).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.account_balance, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              AppLocalizations.of(context).bankTransferNumber(bankAccount),
              overflow: TextOverflow.visible,
              style: const TextStyle(fontFamily: 'NeoSansArabic', fontSize: 12),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Clipboard.setData(ClipboardData(text: bankAccount));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppLocalizations.of(context).accountNumberCopied,
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.copy, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class BoostPackagePriceAction extends StatelessWidget {
  const BoostPackagePriceAction({
    required this.price,
    required this.isSelected,
    required this.onPressed,
    super.key,
  });

  final String price;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).price,
              style: const TextStyle(
                fontFamily: 'NeoSansArabic',
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            Text(
              price,
              style: TextStyle(
                fontFamily: 'NeoSansArabic',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: const Color(0xFF160B48).withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF160B48), Color(0xFF322C4E)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(
                  0xFF160B48,
                ).withOpacity(isSelected ? 0.4 : 0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context).subscribeNow,
                  style: const TextStyle(
                    fontFamily: 'NeoSansArabic',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward, size: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
