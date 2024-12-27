import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:here_now/app/utils/appbutton.dart';
import 'package:here_now/app/utils/appstyle.dart';
import 'package:here_now/app/utils/colors.dart';
import 'package:here_now/app/utils/images.dart';
import 'package:here_now/app/utils/string.dart';

Future commentsBottomSheet() {
  // Controller to manage comments and input
  final TextEditingController commentController = TextEditingController();
  final List<String> comments = [
    "Why don’t skeletons fight each other? They don’t have the guts!",
    "I told my computer I needed a break, and now it’s frozen.",
    "Parallel lines have so much in common… it’s a shame they’ll never meet!",
    "I’m on a seafood diet. I see food, and I eat it.",
    "I would tell you a chemistry joke, but I know I wouldn’t get a reaction.",
  ];

  return Get.bottomSheet(
    StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          margin: EdgeInsets.only(top: 100),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with drag handle
              Container(
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.appColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: 16),
              // Title
              Text(
                AppString.comment,
                style: AppStyle.openSans(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 16),
              // Comments List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0), // Adds spacing between comments
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // User Avatar
                          CircleAvatar(
                            backgroundImage: AssetImage(Images
                                .person), // Replace with dynamic user image URL
                            radius: 20,
                          ),
                          SizedBox(
                              width: 10), // Adds space between avatar and text
                          // Comment Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Username and Timestamp
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Usama Mukhtiar", // Replace with dynamic username
                                      style: AppStyle.openSans(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      "2 hours ago", // Replace with dynamic timestamp
                                      style: AppStyle.openSans(
                                        color: Colors.grey,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4), // Adds space between rows
                                // Comment Text
                                Text(
                                  comments[index], // Dynamic comment text
                                  style: AppStyle.openSans(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              Divider(thickness: 1),
              // Add Comment Section
              Row(
                children: [
                  // Comment Input Field
                  Expanded(
                    child: TextFormField(
                      controller: commentController,
                      decoration: InputDecoration(
                        hintText: "Write a comment...",
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  // Send Button
                  AppButton(
                      height: 50,
                      width: 100,
                      text: "Send",
                      textColor: AppColors.appColor,
                      borderRadius: 20,
                      onTap: () {
                        if (commentController.text.isNotEmpty) {
                          setState(() {
                            comments.add(commentController
                                .text); // Add comment to the list
                          });
                          commentController.clear(); // Clear the input field
                        }
                      })
                ],
              ),
            ],
          ),
        );
      },
    ),
    isScrollControlled:
        true, // Ensures the bottom sheet can expand fully if needed
  );
}
