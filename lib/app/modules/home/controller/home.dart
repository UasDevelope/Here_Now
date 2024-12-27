import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:here_now/app/utils/images.dart';

class HomeController extends GetxController {
  Rx<GoogleMapController?> googleMapController = Rx<GoogleMapController?>(null);
  // Reactive markers
  var markers = <Marker>{}.obs;
  // Default camera position centered in Italy
  Rx<CameraPosition> cameraPosition = CameraPosition(
    target: LatLng(42.8333, 12.8333), // Central Italy
    zoom: 4.5, // Zoomed out to view multiple cities
  ).obs;
  Future<BitmapDescriptor> _customIcon() async {
    return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size:Size(40, 40)), Images.marker);
  }

  // List of spaced-out locations in Italy
  RxList<LatLng> newLocation = <LatLng>[
    LatLng(41.9028, 12.4964), // Rome
    LatLng(45.4642, 9.1900), // Milan
    LatLng(43.7696, 11.2558), // Florence
    LatLng(40.8518, 14.2681), // Naples
    LatLng(44.4949, 11.3426), // Bologna
  ].obs;
  void loadMarkers() async{
    final updatedMarkers = <Marker>{}; // Temporary set to hold markers
    for (int i = 0; i < newLocation.length; i++) {
      updatedMarkers.add(
        Marker(
          markerId: MarkerId("Marker_$i"),
          position: newLocation[i],
          infoWindow: InfoWindow(
            title: "Location ${i + 1}",
            snippet: "News in this area",
          ),
        ),
      );
    }
    markers.value = updatedMarkers; // Update the reactive set
  }
  RxDouble rated = RxDouble(0);
  void changeRating(double rating) {
    rated.value = rating;
  }
  @override
  void onInit() {
    loadMarkers(); // Load markers when the controller is initialized
    super.onInit();
  }
}
