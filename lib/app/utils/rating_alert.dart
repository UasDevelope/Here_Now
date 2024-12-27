import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:here_now/app/utils/widgets.dart';

void showRatingDialog(RxDouble rating, Function(double) onRatingUpdate) {
  Get.defaultDialog(
    title: AppString.addyourrating,
    titleStyle: AppStyle.openSans(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black),
    content: Obx(() => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            bool isSelected = index < rating.value; // Check if the star should be selected
            return GestureDetector(
              onTap: () {
                rating.value = index + 1.0; // Set the rating based on the tapped star
                onRatingUpdate(rating.value); // Call the update function
              },
              child: Icon(
                Icons.star,
                color: isSelected ? Colors.amber : Colors.grey,
                size: 40,
              ),
            );
          }),
        ),
        SizedBox(width: 8),
        Text(
          "${rating.value.toStringAsFixed(1)}/3.0", // Show rating with 1 decimal place
          style: TextStyle(fontSize: 16),
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
          textColor: Colors.white,
          borderRadius: 10,
          onTap: () {
            Get.back();
          },
        ),
      ),
    ],
  );
}