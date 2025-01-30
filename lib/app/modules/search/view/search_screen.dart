import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/controller_locator.dart';
import '../../../utils/appstyle.dart';
import '../../../utils/colors.dart';
import '../../../utils/date_time_utlisee.dart';
import '../../../utils/rating_alert.dart';
import '../../../utils/short_message_utils.dart';
import '../../../utils/textfiled.dart';
import '../../events/controller/Events.dart';
import '../../events/widget/event_shimmer.dart';
import '../../events/widget/posts.dart';
import '../../home/widget/comments.dart';
import '../../home/widget/posts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final arguments = Get.arguments as Map<String, dynamic>;

  final homeController = ControllerLocator.homeController;
  final searchController = ControllerLocator.searchController;

  EventsController controller = ControllerLocator.eventsController;

  @override
  Widget build(BuildContext context) {
    log("Arguments are $arguments");
    log("Is news ${arguments["isNews"]}");
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.04,
              ),
              AppTextField(
                isAutoFocus: true,
                width: Get.width,
                height: 60,
                hintText: 'Search with title or description',
                onChanged: (newValue) {
                  searchController.changeSearchValue(
                      newValue, arguments["isNews"]);
                },
                controller: homeController.commentController,
              ),
              if (arguments["isNews"])
                Obx(() {
                  if (homeController.isLoading.value) {
                    return EventPostsShimmer();
                  } else if (homeController.filteredNewsList.isEmpty) {
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
                        itemCount: homeController.filteredNewsList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final data = homeController.filteredNewsList[index];
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
                            comments:
                                homeController.commentMap[data.id] != null &&
                                        homeController
                                            .commentMap[data.id]!.isNotEmpty
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
                                log("data is ${data.isRating}");
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
                }),
              if (!arguments["isNews"])
                Obx(() {
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
                })
            ],
          ),
        ),
      ),
    );
  }
}
