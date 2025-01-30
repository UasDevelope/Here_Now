import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:here_now/app/modules/home/widget/home_header.dart';
import 'package:here_now/app/utils/date_time_utlisee.dart';
import 'package:here_now/app/utils/short_message_utils.dart';
import '../../../utils/widgets.dart';
import '../../events/widget/event_shimmer.dart';
import '../../home/widget/posts.dart';

class InstituteScreen extends StatelessWidget {
  const InstituteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = ControllerLocator.homeController;

    homeController.fetchNews(category: "Institutes");
    return Scaffold(
      backgroundColor: AppColors.white,
      body: RefreshIndicator(
        onRefresh: () {
          return homeController.fetchNews(category: "Institutes");
        },
        color: AppColors.appColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeHeader(),
              // Container(
              //   height: Get.height / 1.33,
              //   child: ListView.builder(
              //       shrinkWrap: true,
              //       itemCount: 4,
              //       itemBuilder: (BuildContext context, int index) {
              //         return Posts();
              //       }),
              // )
              Obx(() {
                if (homeController.isLoading.value) {
                  return EventPostsShimmer();
                } else if (homeController.filteredNews.isEmpty) {
                  return Text(
                    "No Institutes exist",
                    style: AppStyle.openSans(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w800),
                  );
                } else {
                  return ListView.builder(
                      physics: ScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: homeController.filteredNews.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final data = homeController.filteredNews[index];
                        String latDirection = data.lat >= 0 ? "N" : "S";
                        String lonDirection = data.long >= 0 ? "E" : "W";
                        String formattedLat =
                            "${data.lat.abs().toStringAsFixed(4)}° $latDirection";
                        String formattedLon =
                            "${data.long.abs().toStringAsFixed(4)}° $lonDirection";
                        log("Image is ${data.image}");
                        return Posts(
                          coordinates: "$formattedLat $formattedLon",
                          userName:
                              "${data.user.firstName} ${data.user.lastName}",
                          userAvatar: "${data.user.image}",
                          locationAndTime:
                              "${data.location}, ${DateTimeUtils.formatToDmy(data.createdAt)}",
                          postDescription: data.description,
                          postImage: "${data.image}",
                          likes: data.averageRating.toStringAsFixed(1),
                          comments: homeController.commentMap[data.id] !=
                                      null &&
                                  homeController.commentMap[data.id]!.isNotEmpty
                              ? homeController.commentMap[data.id]!.length
                              : data.commentsCount,
                          onRate: () {
                            if (!data.isRating) {
                              showRatingDialog(homeController.rated,
                                  homeController.changeRating, () {
                                homeController.addRating(data.id);
                              });
                            } else {
                              ShortMessageUtils.showError(
                                  "You already added rating to this post");
                            }
                          },
                          onComment: () {
                            homeController.fetchComments(data.id);
                            newsCommentsBottomSheet(
                                commentController:
                                    homeController.commentController,
                                onSendComment: () async {
                                  await homeController.addComment(data.id);
                                });
                          },
                        );
                      });
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
