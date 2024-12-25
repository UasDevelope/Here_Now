import 'package:flutter/material.dart';
import 'package:here_now/app/utils/widgets.dart';

class Posts extends StatelessWidget {
  const Posts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 8, right: 8, top: 8), // Add some padding for better UI
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
            Container(
              height: Get.height / 6,
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
                Text("${AppString.interactions}  72",
                    style: AppStyle.openSans(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w800))
              ],
            )
          ],
        ),
      ),
    );
  }
}
