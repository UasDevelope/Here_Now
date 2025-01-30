import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:developer' as lg;

import 'package:here_now/app/modules/loading/widget/custom_loading_widget.dart';
import 'package:here_now/app/utils/short_message_utils.dart';

class LocationService {
  static Future<Map<String, dynamic>> getCurrentLocation() async {
    try {
      // CustomLoadingDialog.showCustomLoadingDialog("Fetching user location");
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          // CustomLoadingDialog.closeLoadingDialog();
          ShortMessageUtils.showError("Location permission denied ");
          throw Exception("Location permission denied by user.");
        }
      }

      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      );
      final position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );
      // Reverse geocode to get location details
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;

        String city = placemark.locality ?? "Unknown City";
        String state = placemark.administrativeArea ?? "Unknown State";
        String country = placemark.country ?? "Unknown Country";

        String locationName = "$city, $country";

        // Log the location details
        lg.log(
            "Current location: Lat: ${position.latitude}, Lon: ${position.longitude}, Location Name: $locationName");
        // CustomLoadingDialog.closeLoadingDialog();
        return {
          'lng': position.longitude,
          'lat': position.latitude,
          'locationName': {
            "locationName": locationName,
            "city": city,
            "state": state,
            "country": country,
          },
        };
      } else {
        // CustomLoadingDialog.closeLoadingDialog();
        ShortMessageUtils.showError("Unable to determine location");
        throw Exception("Unable to determine location name.");
      }
    } catch (e) {
      lg.log("Error fetching location: $e");
      // CustomLoadingDialog.closeLoadingDialog();
      ShortMessageUtils.showError("Failed to fetch location: $e");
      throw Exception("Failed to fetch location: $e");
    }
  }
}
