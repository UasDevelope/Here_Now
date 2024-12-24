import 'package:flutter/material.dart';
import 'package:here_now/app/utils/widgets.dart'; // Importing controller locator

class AppButton extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final Color textColor;
  final Color buttonColor;
  final double borderRadius;
  final Function() onTap;
  final double elevation;
  final double textSize;
  final FontWeight textWeight;
  final Gradient? gradient;

  const AppButton({
    Key? key,
    required this.height,
    required this.width,
    required this.text,
    required this.textColor,
    this.buttonColor = AppColors.buttonColor, // Default button color
    required this.borderRadius,
    required this.onTap,
    this.elevation = 2.0,
    this.textSize = 16.0,
    this.textWeight = FontWeight.bold,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: gradient == null ? buttonColor : null,
            gradient: gradient,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style:AppStyle.openSans(
              color: textColor,
              fontSize: textSize,
              fontWeight: textWeight,
            ),
          ),
        ),
      ),
    );
  }
}
