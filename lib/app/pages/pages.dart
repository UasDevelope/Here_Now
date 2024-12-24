import 'package:get/get.dart';
import 'package:here_now/app/bindings/initial_binding.dart';
import 'package:here_now/app/modules/auth/view/login.dart';
import 'package:here_now/app/modules/auth/view/signup.dart';
import 'package:here_now/app/modules/bottom/view/bottom_nav.dart';
import 'package:here_now/app/profile/view/profiile.dart';
import '../modules/splash/views/splash.dart';
import 'package:here_now/app/utils/widgets.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => SplashScreen(),
      binding: InitialBinding(), // Make sure the binding is set
    ),
    GetPage(name: Routes.login, page: () => LoginScreen()),
    GetPage(name: Routes.signup, page: () => SignupScreen()),
    GetPage(
        name: Routes.bottomNav,
        page: () => BottomNav(),
        binding: InitialBinding()),
    GetPage(name: Routes.porofile, page: () => ProfiileScreen())
  ];
}
