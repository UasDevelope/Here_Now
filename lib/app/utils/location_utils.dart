import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

        String locationName =
            "${placemark.subLocality ?? ""},${placemark.street ?? ""}";

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

  static Future<Map<String, dynamic>> getAddressFromCoordinates(
      double lat, double lng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      lat,
      lng,
    );
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      lg.log(
          "Place is ${place.administrativeArea},${place.subLocality},${place.street}");
      return {
        'city': place.locality ?? '',
        'state': place.administrativeArea ?? '',
        'country': place.country ?? '',
        'locationName': "${place.subLocality ?? ""},${place.street ?? ""}",
      };
    } else {
      return {};
    }
  }

  static Future<List<Location>> searchLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      lg.log("Locations are $locations");
      return locations;
    } catch (e) {
      lg.log("Error searching location: $e");
      ShortMessageUtils.showError("Failed to find location");
      return [];
    }
  }
}
