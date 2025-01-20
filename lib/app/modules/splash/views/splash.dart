import 'package:flutter/material.dart';
import 'package:here_now/app/utils/widgets.dart'; // Importing controller locator
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ControllerLocator.splashController;
    return Scaffold(
      body: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
              gradient: AppColors.splashGradient,
              image: SplashWidget.splashAssetImage()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SplashWidget.jumpingDots(),
              SizedBox(
                height: 70,
              ),
            ],
          )),
    );
  }
}
