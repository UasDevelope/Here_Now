import 'package:here_now/app/modules/events/view/events.dart';
import 'package:here_now/app/modules/home/view/home.dart';
import 'package:here_now/app/modules/institute/view/institute.dart';
import 'package:here_now/app/modules/post/view/post.dart';
import 'package:here_now/app/utils/widgets.dart';

class BottomNavController extends GetxController {
  RxInt currentIndex = RxInt(0);
  List<Widget> pages = [];

  ///Change a Current INDEX
  void changeIndex(int index) {
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
