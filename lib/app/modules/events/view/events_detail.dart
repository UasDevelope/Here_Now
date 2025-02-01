import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:here_now/app/modules/events/model/comment_model.dart';
import 'package:here_now/app/modules/events/model/event_model.dart';
import 'package:intl/intl.dart';
import '../../../utils/widgets.dart';
import '../widget/button.dart';
import '../widget/map.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

class EventDetailPost extends StatelessWidget {
  bool showMap;
  Event data;
  EventDetailPost({super.key, this.showMap = false, required this.data});
  @override
  Widget build(BuildContext context) {
    final controller = ControllerLocator.eventsController;
    final userController = ControllerLocator.profileController;
    Future<void> _sharePost() async {
      try {
        CustomLoadingDialog.showCustomLoadingDialog("Sharing post.....");
        String userName =
            "${data.user?.firstName ?? ''} ${data.user?.lastName ?? ''}";
        String postDescription = data.description;
        if (data.image.isNotEmpty && data.image.startsWith("http")) {
          // Download the image
          final response = await http.get(Uri.parse(data.image));
          final Uint8List bytes = response.bodyBytes;

          // Get a temporary directory
          final Directory tempDir = await getTemporaryDirectory();
          final File file = File('${tempDir.path}/shared_image.png');

          // Write the image file
          await file.writeAsBytes(bytes);

          // Share the image with title & description
          await Share.shareXFiles([XFile(file.path)],
              text: "$userName's Post\n\n$postDescription");
        } else {
          await Share.share("$userName's Post\n\n$postDescription");
        }
      } catch (e) {
        print("Error sharing post: $e");
      } finally {
        CustomLoadingDialog.closeLoadingDialog();
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.03,
              ),
              GestureDetector(
                onTap: () => Get.back(), // Go back to previous screen
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 28.0, // Customize icon size
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align vertically
                children: [
                  // Display user image if available, otherwise show a default image
                  CircleAvatar(
                    radius: 20, // Size of the circular image
                    backgroundImage: data.user?.image != null
                        ? NetworkImage("${data.user?.image}")
                        : AssetImage(Images.person),
                  ),
                  SizedBox(width: 10), // Add spacing between the image and name
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      // Safely display user name, if available
                      "${data.user?.firstName ?? ''} ${data.user?.lastName ?? ''}",
                      style: AppStyle.openSans(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.share, color: AppColors.appColor),
                    onPressed: _sharePost,
                  ),
                ],
              ),
              Text(
                // Format the createdAt date and include the location
                "${data.location}, ${DateFormat('dd/MM/yy HH:mm').format(data.createdAt)}",
                style: AppStyle.openSans(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(data.description,
                  style: AppStyle.openSans(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w800)),
              SizedBox(
                height: 3,
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.fullScreenImageView,
                          arguments: data.image);
                    },
                    child: Container(
                      height: Get.height / 3.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          7,
                        ), // Rounded corners with radius 15
                        image: DecorationImage(
                          image: NetworkImage(data.image),
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
                              data.location,
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
                  ),
                  if (showMap)
                    EventsGoogleMap(
                      showAdditional: true,
                      event: data,
                    ),
                ],
              ),
              if (!showMap)
                Center(
                  child: EventButton(
                    imagePath: Images.rating,
                    text: 'Add your Rating',
                    onPressed: () {
                      showRatingDialog(
                          controller.rated, controller.changeRating, () {
                        controller.addEventRating(data.id);
                        log(data.id);
                      });
                    },
                    height: 50.0,
                    width: Get.width / 2,
                    shadowColor: Colors.grey.withOpacity(0.6),
                    buttonColor: Colors.white,
                  ),
                ),
              Row(
                children: [
                  Text(
                    double.parse(data.averageRating).toStringAsFixed(1),
                    style: AppStyle.openSans(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Image.asset(
                    Images.star,
                    height: 30,
                    color: data.userRated ? AppColors.appColor : null,
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
                      controller.fetchComments(data.id).then((_) {
                        commentsBottomSheet(
                          commentController: controller.commentController,
                          onSendComment: () {
                            final newCommentText =
                                controller.commentController.text.trim();
                            if (newCommentText.isNotEmpty) {
                              // Add a new comment to the local comments list
                              controller.commentsList.add(
                                Comment(
                                  user: commentUser(
                                    email: userController.user.value!.email,
                                    image: userController.user.value!.image,
                                    firstName:
                                        userController.user.value!.firstName,
                                    lastName:
                                        userController.user.value!.lastName,
                                  ),
                                  content: newCommentText,
                                  createdAt: DateTime.now()
                                      .toString(), // Current timestamp
                                ),
                              );

                              // Clear the text field

                              // Optionally send the comment to the server
                              controller
                                  .addComment(
                                data.id,
                              )
                                  .then((success) {
                                controller.commentController.clear();

                                if (!success) {
                                  print(
                                      "Failed to post comment to the server.");
                                }
                              });
                            }
                          },
                        );
                      });
                    },
                    child: Image.asset(
                      Images.comment,
                      height: 30,
                      width: 30,
                    ),
                  ),

                  Text("${data.comments.length}",
                      style: AppStyle.openSans(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w800))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
