import 'package:flutter/material.dart';
import 'package:here_now/app/modules/events/widget/button.dart';

import '../../../utils/widgets.dart';

class EventsGoogleMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = ControllerLocator.eventsController;
    return Column(
      children: [
        Container(
          padding:EdgeInsets.zero,
          height: 200,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(15), // Optional: for rounded corners
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(bottom:0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Obx(() => GoogleMap(
                          initialCameraPosition:
                              controller.cameraPosition.value,
                          onMapCreated: (value) {
                            controller.googleMapController.value = value;
                          },
                        )),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 2,
                      ),
                      Image.asset(
                        Images.pin,
                        height: 25,
                      ),
                      Text(
                        "18 Fish Street Hill", // Display the address from controller
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
        Row(
          children: [
            EventButton(
              imagePath: Images.phone, // Optional: Add image path here
              text: '+92 232 8686 868', // Optional: Add button text here
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
              text: '\$399',
              onPressed: () {
                print("Button Pressed");
              },
              height: 50.0,
              width: Get.width / 2.2,
              shadowColor: Colors.grey.withOpacity(0.6),
              buttonColor: Colors.white,
            )
          ],
        ),
        EventButton(
          imagePath: Images.rating,
          text: 'Add your Rating',
          onPressed: () {
            print("Button Pressed");
          },
          height: 50.0,
          width: Get.width,
          shadowColor: Colors.grey.withOpacity(0.6),
          buttonColor: Colors.white,
        )
      ],
    );
  }
}
