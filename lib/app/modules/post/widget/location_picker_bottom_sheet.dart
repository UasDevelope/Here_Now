import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:here_now/app/modules/post/widget/location_detail.dart';
import 'package:here_now/app/utils/widgets.dart';

import '../../../controllers/location.dart';

class LocationPickerBottomSheet extends StatelessWidget {
  final LocationController locationController =
      ControllerLocator.locationController;

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              children: [
                Text(
                  'Pick a Location',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search location...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      locationController.searchLocation(value);
                      _searchController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          // Google Map
          Obx(() => Expanded(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(locationController.latitude.value,
                        locationController.longitude.value),
                    zoom: 14.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    locationController.mapController = controller;
                  },
                  onTap: (LatLng tappedLatLng) {
                    locationController.onMapTapped(tappedLatLng);
                  },
                  markers: {
                    Marker(
                      markerId: MarkerId('selectedLocation'),
                      position: LatLng(locationController.latitude.value,
                          locationController.longitude.value),
                      infoWindow: InfoWindow(
                        title: locationController
                                .selectedLocation['locationName'] is String
                            ? locationController
                                .selectedLocation['locationName']
                            : locationController
                                        .selectedLocation['locationName']
                                    ?['locationName'] ??
                                'Selected Location',
                      ),
                      draggable: true,
                      onDragEnd: (LatLng newPosition) {
                        locationController.onMapTapped(newPosition);
                      },
                    ),
                  },
                ),
              )),
          // Location Info
          LocationDetailsWidget(locationController: locationController),

          // Confirm Button
          Center(
            child: AppButton(
              height: 50,
              textWeight: FontWeight.w800,
              textSize: 20,
              width: Get.width / 1.2,
              text: "Confirm Location",
              textColor: AppColors.white,
              borderRadius: 10,
              onTap: () {
                Get.back();
                // Get.toNamed(Routes.bottomNav);
              },
            ),
          ),
        ],
      ),
    );
  }
}
