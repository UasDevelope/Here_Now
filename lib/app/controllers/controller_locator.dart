import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:here_now/app/controllers/location.dart';
import 'package:here_now/app/modules/auth/controller/auth.dart';
import 'package:here_now/app/modules/bottom/controller/bottom_nav.dart';
import 'package:here_now/app/modules/events/controller/Events.dart';
import 'package:here_now/app/modules/home/controller/home.dart';
import 'package:here_now/app/modules/post/controller/controller.dart';
import 'package:here_now/app/modules/splash/controllers/splash.dart';

class ControllerLocator {
  static SplashController get splashController => Get.find<SplashController>();
  static BottomNavController get bottomNavController =>
      Get.find<BottomNavController>();
  static EventsController get eventsController => Get.find<EventsController>();
  static HomeController get homeController => Get.find<HomeController>();
  static AuthController get authController => Get.find<AuthController>();
  static LocationController get locationController =>
      Get.find<LocationController>();
  static PostController get postController => Get.find<PostController>();
}
