import 'package:flutter/material.dart';
import 'package:here_now/app/controllers/location.dart';
import 'package:here_now/app/modules/events/widget/event_shimmer.dart';
import 'package:here_now/app/modules/events/widget/map.dart';
import 'package:here_now/app/modules/home/widget/posts.dart';

import '../../../utils/date_time_utlisee.dart';
import '../../../utils/widgets.dart';
import '../widget/filters.dart';
import '../widget/home_header.dart';
import '../widget/map_shimmer.dart';
import 'map.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = ControllerLocator.homeController;
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
                height: 70,
                child: TextGridView(),
              ),
              Obx(() {
                if (homeController.mapLoading.value) {
                  return ShimmerMapContainer();
                } else if (homeController.newsList.isEmpty) {
                  return Container();
                } else {
                  return HomeMap();
                }
              }),
              Obx(() {
                if (homeController.isLoading.value) {
                  return SizedBox(
                      height: Get.height / 2.1, child: EventPostsShimmer());
                } else if (homeController.newsList.isEmpty) {
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
                        itemCount: homeController.newsList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final data = homeController.newsList[index];
                          String latDirection = data.lat >= 0 ? "N" : "S";
                          String lonDirection = data.long >= 0 ? "E" : "W";
                          String formattedLat =
                              "${data.lat.abs().toStringAsFixed(4)}° $latDirection";
                          String formattedLon =
                              "${data.long.abs().toStringAsFixed(4)}° $lonDirection";
                          return Posts(
                            coordinates: "$formattedLat $formattedLon",
                            userName:
                                "${data.user.firstName} ${data.user.lastName}",
                            userAvatar: "${data.user.image}",
                            locationAndTime:
                                "${data.location}, ${DateTimeUtils.formatToDmy(data.createdAt)}",
                            postDescription: data.description,
                            postImage: "${data.image}",
                            likes: data.score,
                            comments: data.commentsCount,
                            onRate: () {
                              showRatingDialog(homeController.rated,
                                  homeController.changeRating, () {
                                homeController.addRating(data.id);
                              });
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
                        }),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
