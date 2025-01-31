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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Pick a Location',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  onMapCreated: (GoogleMapController mapController) {},
                  onTap: (LatLng tappedLatLng) {
                    log("testing $tappedLatLng");
                    locationController.onMapTapped(tappedLatLng);
                  },
                  markers: {
                    Marker(
                      markerId: MarkerId('selectedLocation'),
                      position: LatLng(locationController.latitude.value,
                          locationController.longitude.value),
                    ),
                  },
                ),
              )),
          // Location Info

          LocationDetailsWidget(locationController: locationController),

          // ElevatedButton(
          //   onPressed: () {
          //     Get.back();
          //   },
          //   child: Text('Confirm Location'),
          // ),
        ],
      ),
    );
  }
}
