import 'dart:async';
import 'package:get/get.dart';
import 'package:here_now/app/utils/pref_util.dart';  // Ensure the correct import
import '../../../routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("Splash screen initialized");
    _navigateBasedOnToken();
  }

  // Function to navigate based on token presence
  void _navigateBasedOnToken() async {
    // Wait for 2 seconds before checking the token (optional, for splash effect)
    Timer(Duration(seconds: 2), () async {
      // Get token from SharedPreferences (or wherever it's stored)
      String? token = PrefUtil.getString(PrefUtil.changeToken); // Token key

      print("Token found: $token"); // Debugging print statement

      // Check if token is valid or not
      if (token != null && token.isNotEmpty) {
        print("===================>Navigating to Bottom Nav");
        Get.offAllNamed(Routes.bottomNav); // Navigate to the bottom nav screen
      } else {
        print("===================>Navigating to Login screen");
        Get.offAllNamed(Routes.login); // Navigate to the login screen
      }
    });
  }
}
