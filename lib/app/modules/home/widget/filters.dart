import 'package:flutter/material.dart';

import '../../../utils/widgets.dart';

class TextGridView extends StatelessWidget {
  final List<String> items = [
    "City",
    'Country',
    "State",
    // "Nation",
    "World",
    "Recent",
    "Popular",
    "Events",
    "Institutions",
  ];

  @override
  Widget build(BuildContext context) {
    final homeController = ControllerLocator.homeController;
    return Scaffold(
      body: Container(
        color: Color(0xffE51B20),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5, // Number of columns in the grid
              crossAxisSpacing: 10, // Horizontal spacing between grid items
              mainAxisSpacing: 10, // Vertical spacing between grid items
              childAspectRatio: 3),
          itemCount: items.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
            return Obx(() => GestureDetector(
                  onTap: () {
                    homeController.changeSelectedNewsType(items[index]);
                  },
                  child: Text(
                    items[index],
                    style: AppStyle.openSans(
                        color: homeController.selectedNewsType.value ==
                                items[index]
                            ? Colors.black
                            : AppColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w800),
                  ),
                ));
          },
        ),
      ),
    );
  }
}
