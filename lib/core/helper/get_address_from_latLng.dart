import 'package:geocoding/geocoding.dart';

Future<Map<String, String>> getAddressParts(
  double lat,
  double lng,
) async {
  final placemarks = await placemarkFromCoordinates(lat, lng);
  final place = placemarks.first;

  return {
    "street": place.street ?? "",
    "city": place.locality ?? "",
    "district": place.subLocality ?? "",
  };
}