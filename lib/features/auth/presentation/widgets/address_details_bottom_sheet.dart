import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/components/custom_button.dart';
import 'package:fixgo/core/components/custom_top_error_message.dart';
import 'package:fixgo/core/constants/oman_locations.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/features/auth/presentation/widgets/address_location_fields.dart';
import 'package:fixgo/l10n/app_localizations.dart';

import '../../../../core/session/app_session_cubit.dart';
import '../manager/auth_cubit/auth_cubit.dart';

class AddressDetailsBottomSheet extends StatefulWidget {
  final Map<String, String> address;

  /// 🔥 NEW
  final double latitude;
  final double longitude;
  const AddressDetailsBottomSheet({
    super.key,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<AddressDetailsBottomSheet> createState() =>
      _AddressDetailsBottomSheetState();
}

class _AddressDetailsBottomSheetState extends State<AddressDetailsBottomSheet> {
  bool isChecked = false;

  String selectedCity = "";
  String selectedDistrict = "";
  @override
  void initState() {
    super.initState();

    selectedCity = widget.address["city"] ?? OmanLocations.cities.first;
    final districts = OmanLocations.getDistricts(selectedCity);
    selectedDistrict =
        widget.address["district"] ??
        (districts.isNotEmpty ? districts.first : "");
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.p20,
        vertical: AppSizes.p20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.r(24)),
          topRight: Radius.circular(AppSizes.r(24)),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Handle
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            SizedBox(height: AppSizes.h(16)),

            AddressLocationFields(
              selectedCity: selectedCity,
              selectedDistrict: selectedDistrict,
              onCitySelected: (value) {
                setState(() {
                  selectedCity = value;
                  final districts = OmanLocations.getDistricts(value);
                  selectedDistrict = districts.isNotEmpty
                      ? districts.first
                      : "";
                });
              },
              onDistrictSelected: (value) {
                setState(() {
                  selectedDistrict = value;
                });
              },
            ),
            SizedBox(height: AppSizes.h(20)),

            /// Checkbox
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  activeColor: ColorsManager.primaryColor,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    l10n.termsAndPrivacyAgreement,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: AppSizes.sp(13),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSizes.h(20)),

            CustomButton(
              text: l10n.saveAddress,
              onPressed: isChecked
                  ? () {
                      _handleSave(context);
                    }
                  : () {
                      CustomTopErrorMessage.show(
                        context,
                        message: l10n.acceptTermsBeforeContinue,
                      );
                    },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSave(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final currentUser = context.read<AppSessionCubit>().currentUser;

    if (currentUser == null) {
      CustomTopErrorMessage.show(context, message: l10n.currentUserNotFound);
      return;
    }

    final userId = currentUser.uid;

    final updatedUser = await context.read<AuthCubit>().updateUserLocation(
      uid: userId,
      latitude: widget.latitude,
      longitude: widget.longitude,
      city: selectedCity,
      district: selectedDistrict,
    );

    if (updatedUser == null || !context.mounted) return;
    await context.read<AppSessionCubit>().loadUser();

    if (context.mounted) context.go("/home/home");
  }
}
