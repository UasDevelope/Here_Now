import 'package:flutter/material.dart';
import 'package:here_now/app/modules/events/widget/map.dart';
import 'package:here_now/app/modules/home/widget/posts.dart';

import '../../../utils/widgets.dart';
import '../widget/filters.dart';
import '../widget/home_header.dart';
import 'map.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeHeader(),
          Container(
            decoration: BoxDecoration(color: AppColors.appColor),
            height: 70,
            child: TextGridView(),
          ),
          HomeMap(),
          Container(
            height: Get.height /2.1,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Posts();
                }),
          )
        ],
      ),
    );
  }
}
