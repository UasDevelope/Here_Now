import 'package:get/get.dart';
import 'package:here_now/app/bindings/initial_binding.dart';
import 'package:here_now/app/modules/auth/view/login.dart';
import 'package:here_now/app/modules/auth/view/signup.dart';
import 'package:here_now/app/modules/bottom/view/bottom_nav.dart';
import 'package:here_now/app/modules/profile/view/editprofile.dart';
import 'package:here_now/app/modules/profile/view/profiile.dart';
import 'package:here_now/app/modules/profile/widget/AboutAppPage.dart';
import 'package:here_now/app/modules/profile/widget/PrivacyPolicyPage.dart';
import 'package:here_now/app/modules/profile/widget/SecurityPage.dart';
import 'package:here_now/app/modules/profile/widget/TermsOfServicePage.dart';
import '../modules/profile/widget/FAQPage.dart';
import '../modules/splash/views/splash.dart';
import '../utils/widgets.dart';

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
      binding: InitialBinding(),
    ),
    GetPage(name: Routes.profile, page: () => ProfiileScreen()),
    GetPage(name: Routes.security, page: () => SecurityPage()),
    GetPage(name: Routes.fqa, page: () => FAQPage()),
    GetPage(name: Routes.termsOfService, page: () => TermsOfServicePage()),
    GetPage(name: Routes.privacyPolicy, page: () => PrivacyPolicyPage()),
    GetPage(name: Routes.aboutApp, page: () => AboutAppPage()),
    GetPage(name:Routes.editprofile, page: ()=>Editprofile()),
  ];
}
