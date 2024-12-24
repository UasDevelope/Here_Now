import 'package:flutter/material.dart';
import 'package:here_now/app/modules/events/widget/posts.dart';
import 'package:here_now/app/modules/home/widget/home_header.dart';

import '../../../utils/widgets.dart';

class InstituteScreen extends StatelessWidget {
  const InstituteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:AppColors.white,
      body:Column(
        children: [
          HomeHeader(),
          Container(
            height:Get.height/1.33,
            child: ListView.builder(
              shrinkWrap:true,
                itemCount:4,
                itemBuilder: (BuildContext context,int index){
              return EventPosts();
            }),
          )
        ],
      ),
    );
  }
}
