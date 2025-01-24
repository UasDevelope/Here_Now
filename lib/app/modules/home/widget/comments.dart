import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:here_now/app/controllers/controller_locator.dart';
import 'package:here_now/app/utils/appbutton.dart';
import 'package:here_now/app/utils/appstyle.dart';
import 'package:here_now/app/utils/colors.dart';
import 'package:here_now/app/utils/date_time_utlisee.dart';
import 'package:here_now/app/utils/images.dart';
import 'package:here_now/app/utils/string.dart';

Future<void> commentsBottomSheet({
  required TextEditingController commentController,
  required VoidCallback onSendComment,
}) {
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
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 16),
              // Comments List
              Obx(() {
                final comments = ControllerLocator
                    .eventsController.commentsList; // Observing comments list
                return comments.isEmpty
                    ? Text(
                        "No comments yet.",
                        style: AppStyle.openSans(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            final comment = comments[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: comment.user!.image != null
                                        ? NetworkImage(comment.user!.image!)
                                        : AssetImage(Images.person)
                                            as ImageProvider,
                                    radius: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${comment.user!.firstName}${comment.user!.lastName!}",
                                              style: AppStyle.openSans(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            Text(
                                              comment.createdAt != null
                                                  ? DateTimeUtils.formatToIsoWithTime(DateTime.parse(comment.createdAt!))
                                                  : '', // Fallback to an empty string if createdAt is null
                                              style: AppStyle.openSans(
                                                color: Colors.grey,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),


                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          comment.content!,
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
                      );
              }),
              Divider(thickness: 1),
              // Add Comment Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          print(value);
                        },
                        controller: commentController,
                        decoration: InputDecoration(
                          hintText: "Write a comment...",
                          hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                          filled: true,
                          fillColor: Colors.transparent, // Use transparent to inherit container color
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          border: InputBorder.none,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  GestureDetector(
                    onTap: onSendComment,
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: AppColors.appColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        );
      },
    ),
    isScrollControlled: true,
  );
}
