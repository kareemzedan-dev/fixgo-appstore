import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fixgo/core/helper/get_address_from_latLng.dart';
import 'package:fixgo/features/auth/presentation/widgets/address_details_bottom_sheet.dart';
import 'package:fixgo/features/auth/presentation/widgets/location_confirmation_sections.dart';

class ConfirmLocationView extends StatefulWidget {
  final String type;
  final double latitude;
  final double longitude;

  const ConfirmLocationView({
    super.key,
    required this.type,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<ConfirmLocationView> createState() => _ConfirmLocationViewState();
}

class _ConfirmLocationViewState extends State<ConfirmLocationView> {
  Map<String, String> address = {};

  @override
  void initState() {
    super.initState();
    loadAddress();
  }

  Future<void> loadAddress() async {
    final result = await getAddressParts(widget.latitude, widget.longitude);

    setState(() {
      address = result;
    });
  }

  void _showAddressDetails() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return AddressDetailsBottomSheet(
          address: address,
          latitude: widget.latitude,
          longitude: widget.longitude,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final LatLng currentPosition = LatLng(widget.latitude, widget.longitude);

    final Set<Marker> markers = {
      Marker(
        markerId: const MarkerId("current_location"),
        position: currentPosition,
      ),
    };
    if (kIsWeb) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: WebLocationConfirmationContent(
            onBack: () => context.pop(),
            onAddAddressDetails: _showAddressDetails,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: LocationMapSection(
                currentPosition: currentPosition,
                markers: markers,
                onBack: () => context.pop(),
              ),
            ),
            AddressConfirmationPanel(
              address: address,
              onAddAddressDetails: _showAddressDetails,
            ),
          ],
        ),
      ),
    );
  }
}
