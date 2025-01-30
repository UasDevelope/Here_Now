import 'dart:developer';

import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/location_utils.dart';

class LocationController extends GetxController {
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxMap<String, dynamic> userLocation = <String, dynamic>{}.obs;
  Future<void> fetchUserLocation() async {
    Map<String, dynamic> locationName =
        await LocationService.getCurrentLocation();
    log("Fetched location is $locationName");
    longitude.value = locationName["lng"];
    latitude.value = locationName["lat"];
    userLocation.value = locationName["locationName"];
  }

  @override
  void onInit() {
    log("Reached here");
    // TODO: implement onInit
    super.onInit();
    fetchUserLocation();
  }
}
