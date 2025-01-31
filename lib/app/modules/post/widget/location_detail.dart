import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:here_now/app/utils/widgets.dart';

import '../../../controllers/location.dart'; // Assuming AppStyle is in this file

class LocationDetailsWidget extends StatelessWidget {
  final LocationController locationController;

  LocationDetailsWidget({required this.locationController});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading for Location Info
              Text(
                'Location Details',
                style: AppStyle.openSans(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 12),
              // City
              _buildLocationDetail(
                  'City', locationController.selectedLocation.value['city']),
              SizedBox(height: 8),
              // State
              _buildLocationDetail(
                  'State', locationController.selectedLocation.value['state']),
              SizedBox(height: 8),
              // Country
              _buildLocationDetail('Country',
                  locationController.selectedLocation.value['country']),
              SizedBox(height: 8),
              // Location Name
              _buildLocationDetail('Location Name',
                  locationController.selectedLocation.value['locationName']),
              SizedBox(height: 8),
              // Latitude
              _buildLocationDetail(
                  'Latitude', locationController.latitude.value.toString()),
              SizedBox(height: 8),
              // Longitude
              _buildLocationDetail(
                  'Longitude', locationController.longitude.value.toString()),
              SizedBox(height: 16),
            ],
          ),
        ));
  }

  Widget _buildLocationDetail(String title, String? value) {
    return Row(
      children: [
        // Label for the location detail
        Text(
          '$title: ',
          style: AppStyle.openSans(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        // Value for the location detail
        Expanded(
          child: Text(
            value ?? 'N/A', // If the value is null, display 'N/A'
            style: AppStyle.openSans(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
