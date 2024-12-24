import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:here_now/app/utils/widgets.dart';

class AppStyle {
  static TextStyle openSans({
    double spacing=0,
    Color color = Colors.black,           // Text color
    double fontSize = 16.0,               // Font size
    FontWeight fontWeight = FontWeight.normal, // Font weight (e.g., bold, light)
  }) {
    return GoogleFonts.openSans(
      color: color,
      letterSpacing:spacing,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}