import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:here_now/app/controllers/location.dart';
import 'package:here_now/app/modules/bottom/controller/bottom_nav.dart';
import 'package:here_now/app/modules/events/controller/Events.dart';
import 'package:here_now/app/modules/home/controller/home.dart';
import 'package:here_now/app/modules/post/controller/controller.dart';
import 'package:here_now/app/modules/profile/controller/profile_controller.dart';
import 'package:here_now/app/modules/splash/controllers/splash.dart';

import '../modules/auth/controller/auth_controller.dart';
import '../modules/search/controller/search_controller.dart';

class ControllerLocator {
  static SplashController get splashController => Get.find<SplashController>();
  static BottomNavController get bottomNavController =>
      Get.find<BottomNavController>();
  static EventsController get eventsController => Get.find<EventsController>();
  static HomeController get homeController => Get.find<HomeController>();
  static AuthController get authController => Get.find<AuthController>();
  static ProfileController get profileController =>
      Get.find<ProfileController>();
  static PostController get postController => Get.find<PostController>();
  static SearchScreenController get searchController =>
      Get.find<SearchScreenController>();
  static LocationController get locationController =>
      Get.find<LocationController>();
}
