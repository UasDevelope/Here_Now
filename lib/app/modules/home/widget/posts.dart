import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:here_now/app/utils/widgets.dart';

import 'comments.dart';

class Posts extends StatelessWidget {
  const Posts({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ControllerLocator.homeController;
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
            ReadMoreText(
              style: AppStyle.openSans(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w800),
              'Donec eleifend hendrerit purus et dignissim. Nunc lacinia lorem ut eros scelerisque, quis semper felis accumsan. Proin tempus dolor ex, at convallis mauris sollicitudin sit amet.',
              trimMode: TrimMode.Line,
              trimLines: 2,
              colorClickableText: Colors.pink,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              moreStyle: AppStyle.openSans(
                  color: AppColors.appColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w900),
            ),
            // Text(
            //     "Donec eleifend hendrerit purus et dignissim. Nunc lacinia lorem ut eros scelerisque, quis semper felis accumsan. Proin tempus dolor ex, at convallis mauris sollicitudin sit amet.",
            //     style: AppStyle.openSans(
            //         color: Colors.black,
            //         fontSize: 13,
            //         fontWeight: FontWeight.w800)),
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
                InkWell(
                  onTap: () {
                    showRatingDialog(
                      controller.rated, // Pass the reactive rating
                      controller
                          .changeRating, // Pass the callback for rating update
                    );
                  },
                  child: Image.asset(
                    Images.star,
                    height: 70,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    commentsBottomSheet();
                  },
                  child: Image.asset(
                    Images.comment,
                    height: 30,
                    width: 30,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text("72",
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
