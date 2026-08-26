import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<String> getAddressFromLatLng(Position position) async {
  try {
    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isEmpty) {
      return _fallback(position);
    }

    final place = placemarks.first;

    final parts = [
      place.street,
      place.subLocality,
      place.locality,
      place.administrativeArea,
      place.country,
    ]
        .where((e) => e != null && e.toString().trim().isNotEmpty)
        .map((e) => e!.trim())
        .toList();

    if (parts.isEmpty) {
      return _fallback(position);
    }

    return parts.join(', ');
  } catch (e) {
    return _fallback(position);
  }
}

String _fallback(Position position) {
  return '${position.latitude.toStringAsFixed(5)}, ${position.longitude.toStringAsFixed(5)}';
}
