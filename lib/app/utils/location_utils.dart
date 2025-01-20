import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:developer' as lg;

class LocationService {
  static Future<Map<String, dynamic>> getCurrentLocation() async {
    try {
      // Check for location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          throw Exception("Location permission denied by user.");
        }
      }

      // Get the current location
      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      );

      final position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      // Reverse geocode to get location name
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String locationName = "${placemark.locality}, ${placemark.country}";
        lg.log(
            "Current location: Lat: ${position.latitude}, Lon: ${position.longitude}, Location Name: $locationName");
        return {
          'lng': position.longitude,
          'lat': position.latitude,
          'locationName': locationName,
        };
      } else {
        throw Exception("Unable to determine location name.");
      }
    } catch (e) {
      lg.log("Error fetching location: $e");
      throw Exception("Failed to fetch location: $e");
    }
  }
}
