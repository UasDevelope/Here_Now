import 'dart:developer';

import 'package:here_now/app/modules/events/view/events.dart';
import 'package:here_now/app/modules/home/view/home.dart';
import 'package:here_now/app/modules/institute/view/institute.dart';
import 'package:here_now/app/modules/post/view/post.dart';
import 'package:here_now/app/utils/widgets.dart';

class BottomNavController extends GetxController {
  RxInt currentIndex = RxInt(0);
  List<Widget> pages = [];
  final postController = ControllerLocator.postController;
  final homeController = ControllerLocator.homeController;

  ///Change a Current INDEX
  void changeIndex(int index) {
    // String category = postController.selectedCategory.value;
    // log("Category is $category");
    if (currentIndex.value == 1 && index == 2) {
      postController.updateSelectedCategory("Events");
    } else if (currentIndex.value == 0 && index == 2) {
      postController.updateSelectedCategory("News");
    }
    if (index == 1) {
      homeController.changeSelectedNewsType("Events");
      homeController.changeSelectedNewsType("World");
      homeController.changeSelectedNewsType("Popular");
      homeController.changeSelectedNewsType("City");
      homeController.changeSelectedNewsType("Recent");
    } else if (index == 0) {
      homeController.changeSelectedNewsType("News");
    }
    currentIndex.value = index;
  }

  @override
  void onInit() {
    pages = [
      HomeScreen(),
      EventScreen(),
      Postscreen(),
      InstituteScreen(),
    ];
    // TODO: implement onInit
    super.onInit();
  }
}
