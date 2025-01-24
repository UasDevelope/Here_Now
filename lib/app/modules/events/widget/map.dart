import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:here_now/app/modules/events/model/event_model.dart';
import 'package:here_now/app/modules/events/widget/button.dart';
import '../../../utils/widgets.dart';

class EventsGoogleMap extends StatelessWidget {
  final bool showAdditional;
  Event event;
  EventsGoogleMap({this.showAdditional = false, required this.event});

  @override
  Widget build(BuildContext context) {
    final controller = ControllerLocator.eventsController;

    // Update the initial camera position with the given latitude and longitude
    final CameraPosition initialPosition = CameraPosition(
      target: LatLng(event.latitude, event.longitude),
      zoom: 7.0,
    );

    return Column(
      children: [
        Container(
          padding: EdgeInsets.zero,
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius:
                BorderRadius.circular(15), // Optional: for rounded corners
          ),
          child: Card(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: GoogleMap(
                      gestureRecognizers: <Factory<
                          OneSequenceGestureRecognizer>>{
                        Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer(),
                        ),
                      },
                      mapType: MapType.terrain,
                      initialCameraPosition: initialPosition,
                      onMapCreated: (value) {
                        controller.googleMapController.value = value;
                        controller.googleMapController.value?.animateCamera(
                          CameraUpdate.newLatLng(
                              LatLng(event.latitude, event.longitude)),
                        );
                      },
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 2),
                      Image.asset(
                        Images.pin,
                        height: 25,
                      ),
                      Text(
                        event.location, // Optionally update dynamically
                        style: AppStyle.openSans(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showAdditional)
          Row(
            children: [
              EventButton(
                imagePath: Images.phone, // Optional: Add image path here
                text: event.contact, // Optional: Add button text here
                onPressed: () {
                  print("Button Pressed");
                },
                height: 60.0,
                width: Get.width / 2.2,
                shadowColor: Colors.grey.withOpacity(0.6),
                buttonColor: Colors.white,
              ),
              EventButton(
                imagePath: Images.money,
                text: "\$${event.price}",
                onPressed: () {
                  print("Button Pressed");
                },
                height: 50.0,
                width: Get.width / 2.2,
                shadowColor: Colors.grey.withOpacity(0.6),
                buttonColor: Colors.white,
              ),
            ],
          ),
        if (showAdditional && !event.userRated)
          EventButton(
            imagePath: Images.rating,
            text: 'Add your Rating',
            onPressed: () {
              showRatingDialog(
                  controller.rated, // Pass the reactive rating
                  controller.changeRating, () async {
                final success = await controller.addEventRating(event.id);
                if (success) {
                  Get.back(); // Closes the current dialog or screen
                }
              });
            },
            height: 50.0,
            width: Get.width,
            shadowColor: Colors.grey.withOpacity(0.6),
            buttonColor: Colors.white,
          ),
      ],
    );
  }
}
