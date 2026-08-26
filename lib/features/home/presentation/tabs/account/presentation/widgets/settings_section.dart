import 'package:flutter/material.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/widgets/settings_tile.dart';

class SettingsSection extends StatelessWidget {
  final List<SettingsItem> items;

  const SettingsSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDark ? const Color(0Xff1E1E1E) : Colors.white,
        border: Border.all(
          color: isDark ? const Color(0Xff1E1E1E) : Colors.grey.shade300,
        ),
      ),
      child: Column(
        children: List.generate(
          items.length,
          (index) => Column(
            children: [
              Material(
                color: Colors.transparent,
                child: SettingsTile(item: items[index]),
              ),
              if (index != items.length - 1)
                Divider(
                  height: 1,
                  color: isDark
                      ? const Color(0Xff1E1E1E)
                      : Colors.grey.shade300,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
