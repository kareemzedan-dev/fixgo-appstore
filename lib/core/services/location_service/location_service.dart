import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class LocationService {
  static Future<Position?> getCurrentLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // It's unsafe to use a BuildContext after an await.
    // So we should get the localizations before any async gaps.
    final l10n = AppLocalizations.of(context);
    final enableGpsMessage = l10n.enableGps;
    final permissionDeniedMessage = l10n.locationPermissionDenied;
    final permissionDeniedForeverMessage = l10n.locationPermissionDeniedForever;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      if (context.mounted) {
        _showMessage(context, enableGpsMessage);
      }
      return null;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        if (context.mounted) {
          _showMessage(context, permissionDeniedMessage);
        }
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (context.mounted) {
        _showMessage(context, permissionDeniedForeverMessage);
      }

      await Geolocator.openAppSettings();
      return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  static void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  static Future<String?> getCurrentCity(BuildContext context) async {
    final position = await getCurrentLocation(context);

    if (position == null) return null;

    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isEmpty) return null;

    final place = placemarks.first;

    print("locality: ${place.locality}");
    print("subLocality: ${place.subLocality}");
    print("subAdministrativeArea: ${place.subAdministrativeArea}");
    print("administrativeArea: ${place.administrativeArea}");

    return place.locality ?? place.administrativeArea;
  }
}
