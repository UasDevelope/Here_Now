import 'package:flutter/material.dart';
import 'package:here_now/app/modules/home/widget/posts.dart';

import '../../../utils/widgets.dart';
import '../widget/filters.dart';
import '../widget/home_header.dart';

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
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 10),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Align items to the ends
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        4), // Rounded corners for the button
                    gradient: LinearGradient(colors: [
                      Color(0xffE51B20),
                      Color(0xff7F0F12),
                    ]),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Button press logic
                      print('Button Pressed');
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      child: Text(
                        'Publish',
                        style: AppStyle.openSans(
                            fontSize: 12,
                            color: AppColors.white,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: Get.height / 1.7,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 2,
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
