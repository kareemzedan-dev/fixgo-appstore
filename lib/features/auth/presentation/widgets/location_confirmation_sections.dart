import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fixgo/core/components/custom_button.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class WebLocationConfirmationContent extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onAddAddressDetails;

  const WebLocationConfirmationContent({
    super.key,
    required this.onBack,
    required this.onAddAddressDetails,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.p20,
        vertical: AppSizes.p20,
      ),
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: IconButton(
              onPressed: onBack,
              icon: Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Icons.arrow_forward
                    : Icons.arrow_back,
              ),
            ),
          ),
          SizedBox(height: AppSizes.h(28)),
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: ColorsManager.primaryColor.withOpacity(.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_on,
              size: 50,
              color: ColorsManager.primaryColor,
            ),
          ),
          SizedBox(height: AppSizes.h(20)),
          Text(
            l10n.selectYourAddress,
            style: TextStyle(
              fontSize: AppSizes.sp(16),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppSizes.h(10)),
          Text(
            l10n.addressDetailsSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: AppSizes.sp(12), color: Colors.grey),
          ),
          SizedBox(height: AppSizes.h(28)),
          const Spacer(),
          CustomButton(
            text: l10n.addAddressDetails,
            onPressed: onAddAddressDetails,
          ),
        ],
      ),
    );
  }
}

class LocationMapSection extends StatelessWidget {
  final LatLng currentPosition;
  final Set<Marker> markers;
  final VoidCallback onBack;

  const LocationMapSection({
    super.key,
    required this.currentPosition,
    required this.markers,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: currentPosition,
            zoom: 16,
          ),
          markers: markers,
          zoomControlsEnabled: false,
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          mapToolbarEnabled: false,
        ),
        Positioned(
          top: AppSizes.h(20),
          right: AppSizes.w(20),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSizes.r(14)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10),
              ],
            ),
            child: IconButton(
              onPressed: onBack,
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 18,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: IgnorePointer(
            ignoring: true,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.p14,
                  vertical: AppSizes.p10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffF3F6FB),
                  borderRadius: BorderRadius.circular(AppSizes.r(30)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.useCurrentLocation,
                      style: TextStyle(
                        fontSize: AppSizes.sp(10),
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.primaryColor,
                      ),
                    ),
                    SizedBox(width: AppSizes.w(8)),
                    Icon(
                      Icons.location_on,
                      size: AppSizes.w(18),
                      color: ColorsManager.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AddressConfirmationPanel extends StatelessWidget {
  final Map<String, String> address;
  final VoidCallback onAddAddressDetails;

  const AddressConfirmationPanel({
    super.key,
    required this.address,
    required this.onAddAddressDetails,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      width: double.infinity,
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
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 20),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                size: AppSizes.w(28),
                color: ColorsManager.primaryColor,
              ),
              SizedBox(width: AppSizes.w(10)),
              Expanded(
                child: Text(
                  l10n.addressSummary(
                    address["street"] ?? "",
                    address["district"] ?? "",
                    address["city"] ?? "",
                  ),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: AppSizes.sp(12),
                    color: ColorsManager.darkGrey,
                    height: 1.8,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.h(24)),
          CustomButton(
            text: l10n.addAddressDetails,
            onPressed: onAddAddressDetails,
          ),
        ],
      ),
    );
  }
}
