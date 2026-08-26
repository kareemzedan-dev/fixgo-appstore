import 'package:flutter/material.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class ServicesSearchField extends StatefulWidget {
  final Function(String) onSearch;

  const ServicesSearchField({super.key, required this.onSearch});

  @override
  State<ServicesSearchField> createState() => _ServicesSearchFieldState();
}

class _ServicesSearchFieldState extends State<ServicesSearchField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextField(
          controller: controller,
          onChanged: widget.onSearch,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).searchForService,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            prefixIcon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
