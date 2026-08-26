import 'package:geolocator/geolocator.dart';

double calculateDistance({
  required double userLat,
  required double userLng,
  required double offerLat,
  required double offerLng,
}) {
  return Geolocator.distanceBetween(
    userLat,
    userLng,
    offerLat,
    offerLng,
  );
}