import 'package:get/get.dart';
import 'package:here_now/app/modules/bottom/controller/bottom_nav.dart';
import 'package:here_now/app/modules/events/controller/Events.dart';

import '../modules/splash/controllers/splash.dart';
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());  // Lazy load the SplashController
    Get.lazyPut(()=>BottomNavController());
    Get.lazyPut(()=>EventsController());
  }
}