import 'package:flutter/material.dart';

import '../../../utils/widgets.dart';
import '../widgets/bottomItems.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ControllerLocator.bottomNavController;
    return Scaffold(
        body: Obx(() => controller.pages[controller.currentIndex.value]),
        bottomNavigationBar: Obx(
              () => Theme(
            data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory, // Disable ripple effect
              highlightColor: Colors.transparent,   // Remove highlight color
            ),
            child: BottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              onTap: (value) {
                controller.changeIndex(value);
              },
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                CustomBottomNavItem.create(
                  imagePath: Images.home,
                  isSelected: controller.currentIndex.value == 0,
                  selectedColor: Colors.blue,
                  unselectedColor: Colors.grey,
                  label: "Home",
                ),
                CustomBottomNavItem.create(
                  imagePath: Images.event,
                  isSelected: controller.currentIndex.value == 1,
                  selectedColor: Colors.blue,
                  unselectedColor: Colors.grey,
                  label: "Event",
                ),
                CustomBottomNavItem.create(
                  imagePath: Images.post,
                  isSelected: controller.currentIndex.value == 2,
                  selectedColor: Colors.blue,
                  unselectedColor: Colors.grey,
                  label: "Post",
                ),
                // CustomBottomNavItem.create(
                //   imagePath: Images.institue,
                //   isSelected: controller.currentIndex.value == 3,
                //   label: "Institute",
                // ),
              ],
            ),
          ),
        )
    );
  }
}
