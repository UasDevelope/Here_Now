import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController {
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxString locationName = ''.obs;

  /// Fetch current location details
  Future<Map<String, dynamic>> getCurrentLocation() async {
    try {
      // Check and request permissions
      if (await _handleLocationPermission()) {
        // Get current position
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        latitude.value = position.latitude;
        longitude.value = position.longitude;

        // Get location name using Geocoding
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          locationName.value =
              "${place.locality}, ${place.administrativeArea}, ${place.country}";
        }

        return {
          "latitude": latitude.value,
          "longitude": longitude.value,
          "locationName": locationName.value,
        };
      } else {
        throw Exception("Location permission denied");
      }
    } catch (e) {
      print("Error getting location: $e");
      return {
        "latitude": null,
        "longitude": null,
        "locationName": "Unknown",
        "error": e.toString(),
      };
    }
  }
  // Future<void> fetchLocation() async {
  //   var locationData = await locationController.getCurrentLocation();
  //   print("Latitude: ${locationData['latitude']}");
  //   print("Longitude: ${locationData['longitude']}");
  //   print("Location Name: ${locationData['locationName']}");
  // }

  /// Handle location permission
  Future<bool> _handleLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isDenied || status.isRestricted) {
      status = await Permission.location.request();
    }

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      // Open app settings if permission is permanently denied
      await openAppSettings();
      return false;
    }

    return false;
  }
}
