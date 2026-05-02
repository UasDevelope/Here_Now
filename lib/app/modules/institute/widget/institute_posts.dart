import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/widgets.dart';
import '../../events/model/event_model.dart';
import '../../events/widget/button.dart';
import '../../events/widget/map.dart';

class InstitutePosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final controller = ControllerLocator.eventsController;
    // final userController = ControllerLocator.profileController;
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
                // Display user image if available, otherwise show a default image
                CircleAvatar(
                  radius: 20, // Size of the circular image
                  backgroundImage: AssetImage(Images.person),
                ),
                SizedBox(width: 10), // Add spacing between the image and name
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    // Safely display user name, if available
                    "{data.user?.firstName ?? ''} {data.user?.lastName ?? ''}",
                    style: AppStyle.openSans(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              // Format the createdAt date and include the location
              "${DateTime.now()})}",
              style: AppStyle.openSans(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text("data.description",
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
                      image: AssetImage(Images.event),
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
                          "data.location",
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
              ],
            ),
            Row(
              children: [
                Text(
                  "aaverage",
                  // "${double.parse().toStringAsFixed(1)}",
                  style: AppStyle.openSans(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Image.asset(
                  Images.star,
                  height: 30,
                  // color: data.userRated ? AppColors.appColor : null,
                ),
                Spacer(),
                // Image.asset(
                //   Images.share,
                //   height: 20,
                // ),
                SizedBox(
                  width: 30,
                ),
                InkWell(
                  onTap: () {
                    // controller.fetchComments(data.id).then((_) {
                    //   // commentsBottomSheet(
                    //   //   commentController: controller.commentController,
                    //   //   onSendComment: () {
                    //   //     final newCommentText =
                    //   //     controller.commentController.text.trim();
                    //   //     if (newCommentText.isNotEmpty) {
                    //   //       // Add a new comment to the local comments list
                    //   //       controller.commentsList.add(
                    //   //         Comment(
                    //   //           user: commentUser(
                    //   //             email: userController.user.value!.email,
                    //   //             image: userController.user.value!.image,
                    //   //             firstName:
                    //   //             userController.user.value!.firstName,
                    //   //             lastName: userController.user.value!.lastName,
                    //   //           ),
                    //   //           content: newCommentText,
                    //   //           createdAt: DateTime.now()
                    //   //               .toString(), // Current timestamp
                    //   //         ),
                    //   //       );
                    //   //
                    //   //       // Clear the text field
                    //   //
                    //   //       // Optionally send the comment to the server
                    //   //       controller
                    //   //           .addComment(
                    //   //         data.id,
                    //   //       )
                    //   //           .then((success) {
                    //   //         controller.commentController.clear();
                    //   //
                    //   //         if (!success) {
                    //   //           print("Failed to post comment to the server.");
                    //   //         }
                    //   //       });
                    //   //     }
                    //   //   },
                    //   // );
                    // });
                    // print(data.id);
                  },
                  child: Image.asset(
                    Images.comment,
                    height: 30,
                    width: 30,
                  ),
                ),

                Text("${"data.comments.length"}",
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
