import 'package:get/get.dart';
import 'package:here_now/app/modules/bottom/controller/bottom_nav.dart';
import 'package:here_now/app/modules/events/controller/Events.dart';
import 'package:here_now/app/modules/home/controller/home.dart';
import 'package:here_now/app/modules/profile/controller/profile_controller.dart';
import '../modules/auth/controller/auth_controller.dart';
import '../modules/splash/controllers/splash.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController()); // Lazy load the SplashController
    Get.lazyPut(() => BottomNavController());
    Get.lazyPut(() => EventsController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => ProfileController());
  }
}
