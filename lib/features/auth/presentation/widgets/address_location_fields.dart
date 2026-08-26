import 'package:flutter/material.dart';
import 'package:fixgo/core/constants/oman_locations.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

class AddressLocationFields extends StatelessWidget {
  final String selectedCity;
  final String selectedDistrict;
  final ValueChanged<String> onCitySelected;
  final ValueChanged<String> onDistrictSelected;

  const AddressLocationFields({
    super.key,
    required this.selectedCity,
    required this.selectedDistrict,
    required this.onCitySelected,
    required this.onDistrictSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _AddressDropdownField(
            label: selectedCity,
            items: OmanLocations.cities,
            onSelected: onCitySelected,
          ),
        ),
        SizedBox(width: AppSizes.w(12)),
        Expanded(
          child: _AddressDropdownField(
            label: selectedDistrict,
            items: OmanLocations.getDistricts(selectedCity),
            onSelected: onDistrictSelected,
          ),
        ),
      ],
    );
  }
}

class _AddressDropdownField extends StatelessWidget {
  final String label;
  final List<String> items;
  final ValueChanged<String> onSelected;

  const _AddressDropdownField({
    required this.label,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      itemBuilder: (context) {
        return items.map((item) {
          return PopupMenuItem<String>(value: item, child: Text(item));
        }).toList();
      },
      child: Container(
        height: 52,
        padding: EdgeInsets.symmetric(horizontal: AppSizes.w(14)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            const Icon(Icons.keyboard_arrow_down),
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: AppSizes.sp(14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
