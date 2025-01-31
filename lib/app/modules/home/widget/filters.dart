import 'package:flutter/material.dart';

import '../../../utils/widgets.dart';

class TextGridView extends StatelessWidget {
  final List<String> items = [
    "City",
    "Country",
    "State",
    "World",
    "Popular",
    "Recent",
    // "Events",
    // "Institutions",
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
            crossAxisCount: 4, // Number of columns in the grid
            crossAxisSpacing: 10, // Horizontal spacing between grid items
            mainAxisSpacing: 10, // Vertical spacing between grid items
            childAspectRatio: 3, // Aspect ratio for each item
          ),
          itemCount: items.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
            return Obx(() {
              final isSelected =
                  homeController.selectedNewsType.contains(items[index]);

              return GestureDetector(
                onTap: () {
                  homeController.changeSelectedNewsType(items[index]);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? Colors.white : Colors.transparent,
                    ),
                  ),
                  child: Text(
                    items[index],
                    style: AppStyle.openSans(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
