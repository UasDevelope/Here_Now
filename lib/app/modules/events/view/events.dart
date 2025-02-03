import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:here_now/app/modules/home/widget/home_header.dart';
import '../../../utils/widgets.dart';
import '../controller/Events.dart';
import '../widget/event_shimmer.dart';
import '../widget/posts.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    EventsController controller = ControllerLocator.eventsController;

    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.white,
          body: Obx(
            () => controller.loading.value
                ? EventPostsShimmer()
                : RefreshIndicator(
                    onRefresh: () {
                      return controller.fetchAllEvents();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          HomeHeader(
                            isNews: false,
                          ),
                          ListView.separated(
                            padding: EdgeInsets.zero,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.eventList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final data = controller.eventList[index];
                              log("${data}");
                              return EventPosts(
                                showMap: true,
                                data: data,
                              );
                            },
                            separatorBuilder: (context, index) => Divider(
                              color: Colors.grey, // Set color for the divider
                              thickness: 1, // Adjust thickness as needed
                              indent: 16, // Adjust indent for better alignment
                              endIndent: 16, // Same as indent for symmetry
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          )),
    );
  }
}
