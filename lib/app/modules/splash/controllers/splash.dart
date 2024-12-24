import 'dart:async';

import 'package:get/get.dart';
import '../../../routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print(
        "Splash screen initialized"); // Add a print statement to check if it's being called
    _navigateToAuth();
  }

  void _navigateToAuth() {
    Timer(Duration(seconds: 3), () {
      print("===================>Navigating to login screen");
      Get.offAllNamed(Routes.login); // Use Get.offAllNamed for named routes
    });
  }

}
