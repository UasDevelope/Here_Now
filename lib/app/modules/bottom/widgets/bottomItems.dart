import 'package:flutter/material.dart';

class CustomBottomNavItem {
  static BottomNavigationBarItem create({
    required String imagePath,
    required bool isSelected,
    Color selectedColor = Colors.blue,
    Color unselectedColor = Colors.grey,
    double size = 40.0,
    String label = "",
  }) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        imagePath,
        height: size,
        width: size,
        // color: isSelected ? selectedColor : unselectedColor,
        fit: BoxFit.fill,
      ),
      label: label,
    );
  }
}
