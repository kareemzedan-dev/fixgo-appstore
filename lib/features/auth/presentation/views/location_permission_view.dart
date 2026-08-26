import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class LocationPermissionView extends StatelessWidget {
  final String type;

  const LocationPermissionView({super.key, required this.type});

  bool get isWorker => type == "worker" || type == "company";

  Future<void> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    /// التأكد من تفعيل خدمة الموقع
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return;
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      context.go(
        "/confirm-location",
        extra: {
          "type": type,
          "latitude": position.latitude,
          "longitude": position.longitude,
        },
      );
    }
  }

  String get _lottiePath {
    return AssetsManager.locationPermission;
  }

  Color get _backgroundColor {
    return const Color(0xffF7F7F7);
  }

  Color get _primaryColor {
    return const Color(0xff16396B);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.p24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Lottie Animation
              Container(
                width: AppSizes.w(260),
                height: AppSizes.h(260),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Lottie.asset(
                  _lottiePath,
                  height: AppSizes.h(260),
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: AppSizes.h(40)),

              /// Title
              Text(
                l10n.allowLocationAccess,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppSizes.sp(20),
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: AppSizes.h(16)),

              /// Description
              Text(
                isWorker
                    ? l10n.workerLocationDescription
                    : l10n.customerLocationDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppSizes.sp(13),
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                  height: 1.8,
                ),
              ),

              SizedBox(height: AppSizes.h(48)),

              /// Allow Button
              SizedBox(
                width: double.infinity,
                height: AppSizes.h(58),
                child: ElevatedButton(
                  onPressed: () => _handleLocationPermission(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.r16),
                    ),
                  ),
                  child: Text(
                    l10n.allowLocationAccess,
                    style: TextStyle(
                      fontSize: AppSizes.sp(16),
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
