import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:here_now/app/modules/events/model/comment_model.dart';
import 'package:here_now/app/modules/events/model/event_model.dart';
import 'package:here_now/app/modules/profile/controller/profile_controller.dart';
import 'package:intl/intl.dart';
import '../../../utils/widgets.dart';
import '../view/events_detail.dart';
import 'button.dart';
import 'map.dart';

class EventPosts extends StatelessWidget {
  bool showMap;
  Event data;
  EventPosts({super.key, this.showMap = false, required this.data});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(EventDetailPost(
          data: data,
          showMap: showMap,
        ));
      },
      child: Container(
        padding: EdgeInsets.all(8), // Add some padding for better UI
        child: SingleChildScrollView(
          child: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Text(
                  data.description.length > 5
                      ? "${data.description.substring(0, 5)}......"
                      : data.description,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
