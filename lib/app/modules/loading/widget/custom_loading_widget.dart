import 'package:flutter/material.dart';

import '../../../utils/widgets.dart';

class CustomLoadingDialog extends StatelessWidget {
  final String text;

  const CustomLoadingDialog({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Center(
        child: Container(
          height: Get.height * 0.25, // Adjust height based on screen size
          width: Get.width * 0.6, // Adjust width based on screen size
          decoration: BoxDecoration(
            gradient: AppColors.splashGradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CupertinoActivityIndicator(
                color: AppColors.white,
                radius: 20,
              ),
              SizedBox(height: 20),
              DefaultTextStyle(
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Close the loading dialog
  static void closeLoadingDialog() {
    Get.back();
  }

  static void showCustomLoadingDialog(String loadingText) {
    Get.dialog(CustomLoadingDialog(text: loadingText));
  }
}
