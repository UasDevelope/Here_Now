import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:here_now/app/controllers/location.dart';
import 'package:here_now/app/modules/events/widget/event_shimmer.dart';
import 'package:here_now/app/modules/events/widget/map.dart';
import 'package:here_now/app/modules/home/widget/posts.dart';
import 'package:here_now/app/utils/short_message_utils.dart';

import '../../../utils/date_time_utlisee.dart';
import '../../../utils/widgets.dart';
import '../../events/widget/posts.dart';
import '../widget/filters.dart';
import '../widget/home_header.dart';
import '../widget/map_shimmer.dart';
import 'map.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = ControllerLocator.homeController;
    final controller = ControllerLocator.eventsController;
    homeController.fetchNews();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: homeController.fetchNews,
        color: AppColors.appColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeHeader(),
              Container(
                decoration: BoxDecoration(color: AppColors.appColor),
                height: 82,
                child: TextGridView(),
              ),
              Obx(() {
                if (homeController.mapLoading.value) {
                  return ShimmerMapContainer();
                } else if (homeController.filteredNews.isEmpty) {
                  return Container();
                } else {
                  return HomeMap();
                }
              }),
              Obx(() {
                if (!homeController.selectedNewsType.contains("Events")) {
                  if (homeController.isLoading.value) {
                    return SizedBox(
                        height: Get.height / 2.1, child: EventPostsShimmer());
                  } else if (homeController.filteredNews.isEmpty) {
                    return Text(
                      "No News exist",
                      style: AppStyle.openSans(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w800),
                    );
                  } else {
                    return SizedBox(
                      height: Get.height / 2.1,
                      child: ListView.builder(
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
                            return Obx(() => Posts(
                                  coordinates: "$formattedLat $formattedLon",
                                  userName:
                                      "${data.user.firstName} ${data.user.lastName}",
                                  userAvatar: "${data.user.image}",
                                  locationAndTime:
                                      "${data.location}, ${DateTimeUtils.formatToDmy(data.createdAt)}",
                                  postDescription: data.description,
                                  postImage: "${data.image}",
                                  likes: data.averageRating.toStringAsFixed(1),
                                  comments:
                                      homeController.commentMap[data.id] !=
                                                  null &&
                                              homeController
                                                  .commentMap[data.id]!
                                                  .isNotEmpty
                                          ? homeController
                                              .commentMap[data.id]!.length
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
                                      log("data is ${data.isRating}");
                                    }
                                  },
                                  onComment: () {
                                    homeController.fetchComments(data.id);
                                    newsCommentsBottomSheet(
                                        commentController:
                                            homeController.commentController,
                                        onSendComment: () async {
                                          await homeController
                                              .addComment(data.id);
                                        });
                                  },
                                ));
                          }),
                    );
                  }
                } else {
                  if (controller.loading.value) {
                    return EventPostsShimmer();
                  } else if (controller.filteredEventList.isEmpty) {
                    return Text(
                      "No Events exist",
                      style: AppStyle.openSans(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w800),
                    );
                  } else {
                    return SizedBox(
                      height: Get.height / 1.36,
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.filteredEventList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = controller.filteredEventList[index];
                            return EventPosts(
                              showMap: true,
                              data: data,
                            );
                          }),
                    );
                  }
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
