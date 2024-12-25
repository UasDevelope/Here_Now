import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:here_now/app/utils/widgets.dart';

void showRatingDialog(RxDouble rating, Function(double) onRatingUpdate) {
  Get.defaultDialog(
    // Title will now only show text as string
    title: AppString.addyourrating, // This is a simple string title
    titleStyle: AppStyle.openSans(
        fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black),
    // Adding custom content
    content: Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.builder(
                  initialRating: rating.value, // Use the reactive rating value
                  minRating: 1,
                  itemSize: 40,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 3,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (newRating) {
                    rating.value = newRating; // Update the rating reactively
                    onRatingUpdate(
                        newRating); // Call the onRatingUpdate function
                  },
                ),
                SizedBox(width: 8),
                Text(
                  "${rating.value.toStringAsFixed(1)}/3", // Show rating with 1 decimal place
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        )),
    actions: [
      SizedBox(width: 10), // Space between close and post button
      Center(
        child: AppButton(
          height: 50,
          textWeight: FontWeight.w800,
          textSize: 20,
          width: Get.width / 2,
          text: AppString.postnow,
          textColor: AppColors.white,
          borderRadius: 10,
          onTap: () {
            Get.back();
          },
        ),
      )
    ],
  );
}
