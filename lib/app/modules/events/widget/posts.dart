import 'package:flutter/material.dart';

import '../../../utils/widgets.dart';
import 'button.dart';
import 'map.dart';

class EventPosts extends StatelessWidget {
  bool showMap;
  EventPosts({super.key, this.showMap = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8), // Add some padding for better UI
      child: SingleChildScrollView(
        child: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Align vertically
              children: [
                CircleAvatar(
                  radius: 20, // Size of the circular image
                  backgroundImage:
                      AssetImage(Images.person), // Replace with your image path
                ),
                SizedBox(width: 10), // Add spacing between the image and name
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'John Doe',
                    style: AppStyle.openSans(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
            Text(
              "New York, 21/07/23 18:53",
              style: AppStyle.openSans(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
                "Donec eleifend hendrerit purus et dignissim. Nunc lacinia lorem ut eros scelerisque, quis semper felis accumsan. Proin tempus dolor ex, at convallis mauris sollicitudin sit amet.",
                style: AppStyle.openSans(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w800)),
            SizedBox(
              height: 3,
            ),
            Column(
              children: [
                Container(
                  height: Get.height / 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      7,
                    ), // Rounded corners with radius 15
                    image: DecorationImage(
                      image: AssetImage(Images.posts),
                      fit: BoxFit
                          .cover, // Ensure the image covers the entire container
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "41.9028° N 12.4964° E",
                          style: AppStyle.openSans(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      Image.asset(
                        Images.thumb,
                        height: 30,
                      ),
                    ],
                  ),
                ),
                if(showMap)
                EventsGoogleMap(),
              ],
            ),
            if(!showMap)
            Center(
              child: EventButton(
                imagePath: Images.rating,
                text: 'Add your Rating',
                onPressed: () {
                  print("Button Pressed");
                },
                height: 50.0,
                width: Get.width/2,
                shadowColor: Colors.grey.withOpacity(0.6),
                buttonColor: Colors.white,
              ),
            ),
            Row(
              children: [
                Text(
                  "555",
                  style: AppStyle.openSans(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w800),
                ),
                Image.asset(
                  Images.star,
                  height: 70,
                ),
                Spacer(),
                Image.asset(
                  Images.share,
                  height: 20,
                ),
                SizedBox(
                  width: 30,
                ),
                Text("${AppString.interactions}  72",
                    style: AppStyle.openSans(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w800))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
