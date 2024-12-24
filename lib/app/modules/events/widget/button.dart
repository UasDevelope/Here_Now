import 'package:flutter/material.dart';
import 'package:here_now/app/utils/appstyle.dart';

class EventButton extends StatelessWidget {
  final String? imagePath;  // Path for asset image
  final String? text;  // Text for the button
  final VoidCallback onPressed;  // Function to handle button press
  final double height;  // Height of the button
  final double width;  // Width of the button
  final Color shadowColor;  // Color for shadow
  final Color buttonColor;  // Background color of the button
  final Color textColor;
  const EventButton({
    Key? key,
    this.imagePath,
    this.text,
    required this.onPressed,
    this.textColor=const Color(0xff4F4F4F),
    this.height = 50.0,
    this.width = 200.0,
    this.shadowColor = Colors.black,
    this.buttonColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 8,
        shadowColor: shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners for button
        ),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imagePath != null) ...[
                Image.asset(
                  imagePath!,
                  height: 24.0,
                  width: 24.0,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 8), // Space between image and text
              ],
              if (text != null) ...[
                Text(
                  text!,
                  style: AppStyle.openSans(color:textColor,fontSize:12,fontWeight:FontWeight.w800),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
