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

    return Scaffold(
        backgroundColor: AppColors.white,
        body: Obx(
          () => controller.loading.value
              ? EventPostsShimmer()
              : RefreshIndicator(
                  onRefresh: () {
                    return controller.fetchAllEvents();
                  },
                  child: Column(
                    children: [
                      HomeHeader(
                        isNews: false,
                      ),
                      Container(
                        height: Get.height / 1.36,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.eventList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final data = controller.eventList[index];
                              log("${data}");
                              return EventPosts(
                                showMap: true,
                                data: data,
                              );
                            }),
                      )
                    ],
                  ),
                ),
        ));
  }
}
