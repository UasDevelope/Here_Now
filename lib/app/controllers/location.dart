import 'dart:developer';

import 'package:get/get.dart';

import '../utils/location_utils.dart';
import '../utils/widgets.dart';

class LocationController extends GetxController {
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxMap<String, dynamic> userLocation = <String, dynamic>{}.obs;
  RxMap<String, dynamic> selectedLocation = <String, dynamic>{}.obs;
  final TextEditingController locationController = TextEditingController();
  Future<void> fetchUserLocation() async {
    Map<String, dynamic> locationName =
        await LocationService.getCurrentLocation();
    final location = locationName["locationName"];
    log("Fetched location is $locationName");
    longitude.value = locationName["lng"];
    latitude.value = locationName["lat"];
    userLocation.value = location;
    selectedLocation.value = location;
    locationController.text = location["locationName"];
  }

  Future<void> onMapTapped(LatLng tappedLatLng) async {
    latitude.value = tappedLatLng.latitude;
    longitude.value = tappedLatLng.longitude;

    selectedLocation.value = await LocationService.getAddressFromCoordinates(
        tappedLatLng.latitude, tappedLatLng.longitude);
    locationController.text = selectedLocation["locationName"];
    log("Selected location is $selectedLocation");
  }

  @override
  void onInit() {
    log("Reached here");
    super.onInit();
    fetchUserLocation();
  }
}
