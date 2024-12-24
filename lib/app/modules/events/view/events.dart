import 'package:flutter/material.dart';
import 'package:here_now/app/modules/home/widget/home_header.dart';
import 'package:here_now/app/modules/home/widget/posts.dart';

import '../../../utils/widgets.dart';
import '../widget/posts.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.white,

      body: Column(
        children: [
          HomeHeader(),
          Container(
            height: Get.height / 1.36,
            child: ListView.builder(
              padding:EdgeInsets.zero,
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return EventPosts(showMap:true,);
                }),
          )
        ],
      ),
    );
  }
}
