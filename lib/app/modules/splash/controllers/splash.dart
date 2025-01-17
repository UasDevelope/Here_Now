import 'dart:async';

import 'package:get/get.dart';
import 'package:here_now/app/utils/pref_util.dart';
import '../../../routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToAuth();
  }

  void _navigateToAuth() {
    Timer(Duration(seconds: 3), () async {
      String token = PrefUtil.getString(PrefUtil.token);
      if (token == "") {
        Get.offAllNamed(Routes.login);
      } else {
        Get.offAllNamed(Routes.bottomNav);
      }
      // print("===================>Navigating to login screen");
    });
  }
}
