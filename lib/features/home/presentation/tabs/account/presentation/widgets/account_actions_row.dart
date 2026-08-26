import 'package:flutter/material.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class AccountActionsRow extends StatelessWidget {
  const AccountActionsRow({
    required this.onLogoutTap,
    required this.onDeleteAccountTap,
    super.key,
  });

  final VoidCallback onLogoutTap;
  final VoidCallback onDeleteAccountTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      children: [
        Expanded(
          child: _AccountActionButton(
            onPressed: onLogoutTap,
            icon: Icons.logout,
            label: l10n.logout,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _AccountActionButton(
            onPressed: onDeleteAccountTap,
            icon: Icons.delete_outline,
            label: l10n.deleteAccount,
          ),
        ),
      ],
    );
  }
}

class _AccountActionButton extends StatelessWidget {
  const _AccountActionButton({
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.red),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.red, size: 18),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
